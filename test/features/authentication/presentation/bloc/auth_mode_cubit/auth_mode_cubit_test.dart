import 'package:flutter_test/flutter_test.dart';
import 'package:get_together_app/features/authentication/presentation/bloc/auth_mode_cubit/auth_mode_cubit.dart';

void main() {
  AuthModeCubit cubit;

  setUp(() {
    cubit = AuthModeCubit();
  });

  test("sinitial state should be LogIn", () {
    expect(cubit.state, AuthModeLogIn());
  });

  test("should change to SignInState and then back to LogIn", () {
    expectLater(
        cubit.stream, emitsInOrder([AuthModeSignUp(), AuthModeLogIn()]));
    cubit.changeAuthState();
    cubit.changeAuthState();
  });
}
