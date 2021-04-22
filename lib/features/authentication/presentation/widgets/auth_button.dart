import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_together_app/features/authentication/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:get_together_app/features/authentication/presentation/bloc/form_bloc/form_bloc.dart';
import 'package:get_together_app/features/authentication/presentation/bloc/form_bloc/from_state.dart';
import 'package:get_together_app/features/authentication/presentation/models/auth_param.dart';

class AuthButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, AuthFormState>(
      builder: (context, state) {
        return Container(
          width: 350,
          height: 45,
          child: ElevatedButton(
            child: Text(
              (state is LogInForm) ? "Log in" : "Sing up",
              style: TextStyle(color: Colors.white70),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) =>
                  (state is ValidForm)
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColor.withOpacity(0.2)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
              ),
            ),
            onPressed: !(state is ValidForm)
                ? null
                : () async {
                    if (state is LogInForm)
                      BlocProvider.of<AuthBloc>(context).add(
                        LogInEvent(
                          LogInParameters(
                            email: state.email.value,
                            password: state.password.value,
                          ),
                        ),
                      );
                    else
                      BlocProvider.of<AuthBloc>(context).add(
                        SignUpEvent(
                          SignUpParameters(
                            email: (state as SignUpForm).email.value,
                            password: (state as SignUpForm).password.value,
                            username: (state as SignUpForm).username.value,
                            image: (state as SignUpForm).image,
                          ),
                        ),
                      );
                  },
          ),
        );
      },
    );
  }
}
