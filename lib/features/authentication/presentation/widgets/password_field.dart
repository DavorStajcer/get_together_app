import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_together_app/features/authentication/presentation/bloc/form_bloc/form_bloc.dart';
import 'package:get_together_app/features/authentication/presentation/bloc/form_bloc/from_state.dart';
import 'package:get_together_app/features/authentication/presentation/bloc/form_bloc/form_event.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<FormBloc, AuthFormState>(
        builder: (context, state) {
          return TextFormField(
            decoration: InputDecoration(
                labelText: "Password",
                errorText: state.password.errorMessage,
                icon: Icon(
                  Icons.lock,
                  color: Theme.of(context).primaryColor,
                )),
            obscureText: true,
            onChanged: (value) {
              BlocProvider.of<FormBloc>(context).add(PasswordChanged(value));
            },
          );
        },
      ),
    );
  }
}
