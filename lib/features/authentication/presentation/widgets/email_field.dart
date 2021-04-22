import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_together_app/features/authentication/presentation/bloc/form_bloc/form_bloc.dart';
import 'package:get_together_app/features/authentication/presentation/bloc/form_bloc/from_state.dart';
import 'package:get_together_app/features/authentication/presentation/bloc/form_bloc/form_event.dart';

class EmailField extends StatelessWidget {
  const EmailField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<FormBloc, AuthFormState>(
        builder: (context, state) {
          return TextFormField(
            initialValue: state.email.value,
            decoration: InputDecoration(
                labelText: "Email",
                errorText: state.email.errorMessage,
                icon: Icon(
                  Icons.email,
                  color: Theme.of(context).primaryColor,
                )),
            onChanged: (value) {
              BlocProvider.of<FormBloc>(context).add(EmailChanged(value));
            },
          );
        },
      ),
    );
  }
}
