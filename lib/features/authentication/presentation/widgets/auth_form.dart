import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get_together_app/features/authentication/presentation/bloc/form_bloc/form_bloc.dart';
import 'package:get_together_app/features/authentication/presentation/bloc/form_bloc/from_state.dart';

import 'package:get_together_app/features/authentication/presentation/widgets/email_field.dart';
import 'package:get_together_app/features/authentication/presentation/widgets/pick_image.dart';
import 'package:get_together_app/features/authentication/presentation/widgets/confirm_password_field.dart';
import 'package:get_together_app/features/authentication/presentation/widgets/password_field.dart';
import 'package:get_together_app/features/authentication/presentation/widgets/username_field.dart';

class AuthForm extends StatefulWidget {
  final Size screenSize;

  AuthForm(this.screenSize, {Key key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, AuthFormState>(
/*       buildWhen: (currState, nextState) {
        log(currState.toString());
        log(nextState.toString());
        if (currState is LoginForm)
          return nextState is SignUpForm;
        else
          return nextState is LoginForm;
      }, */
      builder: (context, state) {
        print("AUTH FORM -> $state");
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child:
                (state is LogInForm) ? LogInFormWidget() : SingUpFormWidget(),
          ),
        );
      },
    );
  }
}

class LogInFormWidget extends StatelessWidget {
  const LogInFormWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        EmailField(),
        SizedBox(
          height: 15,
        ),
        PasswordField(),
      ],
    );
  }
}

class SingUpFormWidget extends StatelessWidget {
  const SingUpFormWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("FORM BUILD");
    return Container(
      child: Column(
        children: [
          PickImage(),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              UsernameField(),
              SizedBox(
                height: 15,
              ),
              EmailField(),
              SizedBox(
                height: 15,
              ),
              PasswordField(),
              SizedBox(
                height: 15,
              ),
              ConfirmPasswordField(),
            ],
          ),
        ],
      ),
    );
  }
}
