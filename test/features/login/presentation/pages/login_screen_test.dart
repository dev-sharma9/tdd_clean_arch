import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_arch/features/login/domain/entities/user.dart';
import 'package:tdd_clean_arch/features/login/presentation/notifier/login_notifier.dart';
import 'package:tdd_clean_arch/features/login/presentation/notifier/login_state.dart';
import 'package:tdd_clean_arch/features/login/presentation/pages/login_screen.dart';

class MockNavigationObserver extends Mock implements NavigatorObserver {}

class MockLoginNotifier extends Mock implements LoginNotifier {}

class FakeRoute extends Fake implements Route {}

void main() {
  late MockNavigationObserver mockObserver;
  late MockLoginNotifier mockLoginNotifier;

  setUpAll(() {
    mockLoginNotifier = MockLoginNotifier();
    mockObserver = MockNavigationObserver();
    registerFallbackValue(FakeRoute());
  });

  group('Login Screen containing TextFields and button', () {
    testWidgets('displays 2 text fields 1 for username and another for entering password with Elevated button',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(child: MaterialApp(home: LoginScreen())),
      );

      expect(find.text('Login'), findsNWidgets(2));
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  // group('Validating button and on click function', () {
  //   testWidgets('given login button when clicked validates with login API and opens next screen', (tester) async {
  //     await tester.pumpWidget(ProviderScope(
  //       child: MaterialApp(
  //         home: LoginScreen(),
  //         navigatorObservers: [mockObserver],
  //       ),
  //     ));
  //
  //     await tester.tap(find.byKey(const Key('Login Button')));
  //     await tester.pumpAndSettle();
  //
  //     // expect(find.byType(LoginScreen), findsOneWidget);
  //     verify(() => mockObserver.didPush(any(), any()));
  //     // expect(find.byType(HomePage), findsOneWidget);
  //   });
  // });

  group('Test Login failure and success', () {
    final user = User(username: "username", password: "password");
    final userFail = User(username: "username", password: "password");

    testWidgets('Test Login success', (tester) async {
      when(() => mockLoginNotifier.login(user)).thenAnswer((invocation) => Future(() => true));

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
            navigatorObservers: [mockObserver],
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      verify(() => mockObserver.didPush(any(), any()));
      // expect(find.text('Home Page'), findsOneWidget);
    });

    testWidgets('Test Login success', (tester) async {
      when(() => mockLoginNotifier.login(userFail)).thenAnswer((invocation) => Future(() => false));

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
            navigatorObservers: [mockObserver],
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      verify(() => mockObserver.didPush(any(), any()));
      // expect(find.text('Something went wrong. Please try again.'), findsOneWidget);
    });
  });
}
