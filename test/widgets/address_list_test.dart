import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_users_app/config/l10n/app_localizations.dart';
import 'package:my_users_app/data/models/address_model.dart';
import 'package:my_users_app/ui/cubits/cubits.dart';
import 'package:my_users_app/ui/screens/user/manage_address_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockManageAddressCubit extends Mock implements ManageAddressCubit {}

class FakeManageAddressState extends Fake implements ManageAddressState {}

final getIt = GetIt.instance;

void main() {
  late MockManageAddressCubit mockCubit;

  setUpAll(() {
    registerFallbackValue(FakeManageAddressState());
  });

  setUp(() {
    mockCubit = MockManageAddressCubit();
    getIt.registerSingleton<ManageAddressCubit>(mockCubit);
  });

  tearDown(() {
    getIt.reset();
  });

  Widget makeTestableWidget(Widget child) {
    final router = GoRouter(
      initialLocation: "/manage_address",
      routes: [
        GoRoute(
          path: "/manage_address",
          builder: (_, __) => child,
        ),
        GoRoute(
          name: "summary",
          path: "/summary",
          builder: (_, __) => const Scaffold(body: Text("Summary Screen")),
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }

  group('ManageAddressScreen', () {
    testWidgets('Displays empty list text when rendering without elements',
        (tester) async {
      final state = ManageAddressState(address: []);

      when(() => mockCubit.state).thenReturn(state);
      when(() => mockCubit.stream).thenAnswer((_) => Stream.value(state));

      await tester.pumpWidget(
        makeTestableWidget(
          BlocProvider<ManageAddressCubit>.value(
            value: mockCubit,
            child: const ManageAddressScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      expect(find.text(l10n.addressListEmpty), findsOneWidget);
    });

    testWidgets("renderiza lista con elementos", (tester) async {
      final state = ManageAddressState(address: [
        AddressModel(name: "Fake Street 123"),
      ]);
      when(() => mockCubit.state).thenReturn(state);
      when(() => mockCubit.stream).thenAnswer((_) => Stream.value(state));

      await tester.pumpWidget(
        makeTestableWidget(
          BlocProvider<ManageAddressCubit>.value(
            value: mockCubit,
            child: const ManageAddressScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining("Fake Street 123"), findsOneWidget);
    });

    testWidgets("al presionar Continue navega a summary", (tester) async {
      final state = ManageAddressState(address: [
        AddressModel(name: "Fake Street 123"),
      ]);
      when(() => mockCubit.state).thenReturn(state);
      when(() => mockCubit.stream).thenAnswer((_) => Stream.value(state));
      when(() => mockCubit.saveAddress()).thenReturn(true);

      await tester.pumpWidget(
        makeTestableWidget(
          BlocProvider<ManageAddressCubit>.value(
            value: mockCubit,
            child: const ManageAddressScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      final continueButton = find.text(l10n.continueBtn);

      expect(continueButton, findsOneWidget);

      await tester.tap(continueButton);
      await tester.pumpAndSettle();

      expect(find.text("Summary Screen"), findsOneWidget);
    });
  });
}
