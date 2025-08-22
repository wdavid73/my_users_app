import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_users_app/config/l10n/app_localizations.dart';
import 'package:my_users_app/data/models/address_model.dart';
import 'package:my_users_app/data/models/my_user_model.dart';
import 'package:my_users_app/ui/blocs/user/user_bloc.dart';
import 'package:my_users_app/ui/cubits/manage_address_cubit/manage_address_cubit.dart';
import 'package:my_users_app/ui/cubits/register_user_cubit/register_user_cubit.dart';
import 'package:my_users_app/ui/screens/user/manage_address_screen.dart';
import 'package:my_users_app/ui/screens/user/register_user_screen.dart';
import 'package:my_users_app/ui/screens/user/summary_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';

class MockUserBloc extends Mock implements UserBloc {}

class FakeUserState extends Fake implements UserState {}

class MockRegisterUserCubit extends Mock implements RegisterUserCubit {}

class FakeRegisterUserState extends Fake implements RegisterUserState {}

class MockManageAddressCubit extends Mock implements ManageAddressCubit {}

class FakeManageAddressState extends Fake implements ManageAddressState {}

final getIt = GetIt.instance;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockUserBloc mockUserBloc;
  late MockRegisterUserCubit mockRegisterUserCubit;
  late MockManageAddressCubit mockManageAddressCubit;

  late StreamController<UserState> userStateController;
  late StreamController<RegisterUserState> registerUserStateController;
  late StreamController<ManageAddressState> manageAddressStateController;

  setUpAll(() {
    registerFallbackValue(FakeUserState());
    registerFallbackValue(FakeRegisterUserState());
    registerFallbackValue(FakeManageAddressState());
  });

  setUp(() {
    mockUserBloc = MockUserBloc();
    mockRegisterUserCubit = MockRegisterUserCubit();
    mockManageAddressCubit = MockManageAddressCubit();

    userStateController = StreamController<UserState>.broadcast();
    registerUserStateController =
        StreamController<RegisterUserState>.broadcast();
    manageAddressStateController =
        StreamController<ManageAddressState>.broadcast();

    getIt.registerLazySingleton<UserBloc>(() => mockUserBloc);
    getIt.registerLazySingleton<RegisterUserCubit>(() => mockRegisterUserCubit);
    getIt.registerLazySingleton<ManageAddressCubit>(
        () => mockManageAddressCubit);

    when(() => mockUserBloc.state).thenReturn(const UserState());
    when(() => mockUserBloc.stream)
        .thenAnswer((_) => userStateController.stream);
    when(() => mockUserBloc.close()).thenAnswer((_) async {});

    when(() => mockRegisterUserCubit.state)
        .thenReturn(const RegisterUserState());
    when(() => mockRegisterUserCubit.stream)
        .thenAnswer((_) => registerUserStateController.stream);
    when(() => mockRegisterUserCubit.close()).thenAnswer((_) async {});
    when(() => mockRegisterUserCubit.onSubmit()).thenReturn(true);

    when(() => mockManageAddressCubit.state)
        .thenReturn(const ManageAddressState());
    when(() => mockManageAddressCubit.stream)
        .thenAnswer((_) => manageAddressStateController.stream);
    when(() => mockManageAddressCubit.close()).thenAnswer((_) async {});
    when(() => mockManageAddressCubit.saveAddress()).thenReturn(true);
    when(() => mockManageAddressCubit.registerAddress(any()))
        .thenAnswer((invocation) {
      final name = invocation.positionalArguments[0] as String;
      final address = AddressModel(name: name);

      // Actualizamos el stream con un nuevo estado
      manageAddressStateController.add(
        ManageAddressState(address: [address]),
      );
    });
  });

  tearDown(() {
    getIt.reset();
  });

  GoRouter createRouter() {
    return GoRouter(
      initialLocation: "/register",
      routes: [
        GoRoute(
          path: "/register",
          name: "register",
          builder: (context, state) => const RegisterUserScreen(),
        ),
        GoRoute(
          path: "/manage_address",
          name: "manage_address",
          builder: (context, state) => const ManageAddressScreen(),
        ),
        GoRoute(
          path: "/summary",
          name: "summary",
          builder: (context, state) => const SummaryScreen(),
        ),
      ],
    );
  }

  Widget makeTestableWidget() {
    return MaterialApp.router(
      routerConfig: createRouter(),
      locale: const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }

  testWidgets('complete user registration and address flow', (tester) async {
    when(() => mockUserBloc.state).thenReturn(UserState(
      user: MyUserModel(
        firstName: 'Juan',
        lastName: 'Pérez',
        dateBirth: DateTime(1995, 5, 20),
      ),
      address: [
        AddressModel(name: 'Calle Falsa 123'),
      ],
    ));

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: mockUserBloc),
          BlocProvider.value(value: mockRegisterUserCubit),
          BlocProvider.value(value: mockManageAddressCubit),
        ],
        child: makeTestableWidget(),
      ),
    );

    // -------- RegisterUserScreen --------
    expect(find.text("Register User"), findsOneWidget);

    await tester.enterText(find.byKey(Key("first_name_field")), "Juan");
    await tester.enterText(find.byKey(Key("last_name_field")), "Pérez");

    // Para date picker: asumimos que tu widget usa showDatePicker internamente
    // Simulamos setear la fecha directamente en el cubit
    GetIt.I<RegisterUserCubit>().dateBirthChanged(DateTime(1995, 5, 20));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key("continue_button")));
    await tester.pumpAndSettle();

    // -------- ManageAddressScreen --------
    expect(find.text("Manage Address"), findsOneWidget);

    await tester.enterText(
        find.byKey(Key("new_address_field")), "Calle Falsa 123");
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key("continue_button")));
    await tester.pumpAndSettle();

    // -------- SummaryScreen --------
    expect(find.text("Summary"), findsOneWidget);

    // Validar nombre completo
    expect(find.textContaining("${l10n.fullName}: Juan Pérez"), findsOneWidget);

    final formatted = DateFormat(DateFormat.YEAR_MONTH_DAY, 'en')
        .format(DateTime(1995, 5, 20));
    expect(
        find.textContaining('${l10n.dateBirth}: $formatted'), findsOneWidget);

    // Validar dirección
    expect(find.textContaining("Calle Falsa 123"), findsOneWidget);
  });
}
