import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/form_bloc/form_bloc.dart';
import '../bloc/form_bloc/from_state.dart';
import '../bloc/form_bloc/form_event.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatelessWidget {
  const PickImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          BlocBuilder<FormBloc, AuthFormState>(
            builder: (context, state) {
              return CircleAvatar(
                  radius: screenSize.width * 0.15,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: (state as SignUpForm).image != null
                      ? Container(
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(state.image!.path),
                            ),
                            color: Colors.grey,
                            border: Border.all(
                                width: 0.2,
                                color: Theme.of(context).primaryColor),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(53)),
                          width: 100,
                          height: 100,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ));
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: Icon(
                  Icons.image,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  BlocProvider.of<FormBloc>(context)
                      .add(PickImageEvent(ImageSource.gallery));
                },
                label: Text("Gallery",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    )),
              ),
              TextButton.icon(
                icon: Icon(
                  Icons.camera,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  BlocProvider.of<FormBloc>(context)
                      .add(PickImageEvent(ImageSource.camera));
                },
                label: Text(
                  "Camera",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
