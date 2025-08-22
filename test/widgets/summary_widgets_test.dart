import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_users_app/config/l10n/app_localizations.dart';
import 'package:my_users_app/data/models/address_model.dart';
import 'package:my_users_app/data/models/my_user_model.dart';
import 'package:my_users_app/ui/blocs/user/user_bloc.dart';
import 'package:my_users_app/ui/screens/user/summary_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';

class MockUserBloc extends Mock implements UserBloc {}

class FakeUserState extends Fake implements UserState {}

final getIt = GetIt.instance;

void main() {
  late MockUserBloc mockUserBloc;

  setUpAll(() {
    registerFallbackValue(FakeUserState());
    Intl.defaultLocale = 'en';
  });

  setUp(() {
    mockUserBloc = MockUserBloc();
    getIt.registerSingleton<UserBloc>(mockUserBloc);
  });

  tearDown(() {
    getIt.reset();
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: child,
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

  group('SummaryScreen', () {
    testWidgets("displays the title Summary in the AppBar", (tester) async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));

      when(() => mockUserBloc.state).thenReturn(
        UserState(
          user: MyUserModel(
            firstName: 'John',
            lastName: 'Doe',
            dateBirth: DateTime(1990, 5, 20),
          ),
          address: [],
        ),
      );

      await tester.pumpWidget(makeTestableWidget(const SummaryScreen()));
      await tester.pumpAndSettle();

      expect(find.text(l10n.summary), findsOneWidget);
    });

    testWidgets("displays user information in UserCard", (tester) async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      final user = MyUserModel(
        firstName: 'John',
        lastName: 'Doe',
        dateBirth: DateTime(1990, 5, 20),
      );
      when(() => mockUserBloc.state).thenReturn(
        UserState(
          user: user,
          address: [],
        ),
      );

      await tester.pumpWidget(makeTestableWidget(const SummaryScreen()));
      await tester.pumpAndSettle();

      expect(find.textContaining(l10n.userInformation), findsOneWidget);
      expect(find.textContaining("John Doe"), findsOneWidget);
      final formatted =
          DateFormat(DateFormat.YEAR_MONTH_DAY, 'en').format(user.dateBirth);
      expect(find.text('${l10n.dateBirth}: $formatted'), findsOneWidget);
    });

    testWidgets("displays addresses in AddressList", (tester) async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));

      when(() => mockUserBloc.state).thenReturn(
        UserState(
          user: MyUserModel(
            firstName: 'John',
            lastName: 'Doe',
            dateBirth: DateTime(1990, 5, 20),
          ),
          address: [
            AddressModel(name: "Fake Street 123"),
            AddressModel(name: "Main Street 456"),
          ],
        ),
      );

      await tester.pumpWidget(makeTestableWidget(const SummaryScreen()));
      await tester.pumpAndSettle();

      expect(find.textContaining("Fake Street 123"), findsOneWidget);
      expect(find.textContaining("Main Street 456"), findsOneWidget);
      expect(find.textContaining(l10n.address), findsWidgets);
    });
  });
}
