import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_together_app/core/widgets/network_error.dart';
import 'package:get_together_app/core/widgets/server_error.dart';
import 'package:get_together_app/features/authentication/di/authentication_di.dart';
import 'package:get_together_app/features/chats_overview/presentation/bloc/chats_overivew/chats_overview_cubit.dart';
import 'package:get_together_app/features/chats_overview/presentation/bloc/message_snippet_bloc/chat_snippet_bloc.dart';
import 'package:get_together_app/features/chats_overview/presentation/widgets/chat_snippet.dart';
import 'package:get_together_app/features/chats_overview/presentation/widgets/no_chats.dart';

class ChatsOverviewScreen extends StatefulWidget {
  const ChatsOverviewScreen({Key? key}) : super(key: key);

  @override
  _ChatsOverviewScreenState createState() => _ChatsOverviewScreenState();
}

class _ChatsOverviewScreenState extends State<ChatsOverviewScreen> {
  @override
  void initState() {
    BlocProvider.of<ChatsOverviewCubit>(context).getAllEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: screenSize.height * 0.15,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 15),
              child: Text(
                "GeTogether",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(child: BlocBuilder<ChatsOverviewCubit, ChatsOverviewState>(
              builder: (context, state) {
                if (state is ChatsOverviewLoading)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                if (state is ChatsOverviewNetworkFailure)
                  return NetworkErrorWidget(
                    state.message,
                    onReload: () {},
                  );
                if (state is ChatsOverviewServerFailure)
                  return ServerErrorWidget(
                    state.message,
                    onReload: () {},
                  );
                return (state as ChatsOverviewLoaded).userEvents.length == 0
                    ? NoChats()
                    : ListView.builder(
                        itemCount: state.userEvents.length,
                        itemBuilder: (context, index) {
                          return BlocProvider.value(
                            value: getIt<ChatSnippetBloc>(),
                            child: ChatSnippet(state.userEvents[index]),
                          );
                        },
                      );
              },
            )),
          ],
        ),
      ),
    );
  }
}
