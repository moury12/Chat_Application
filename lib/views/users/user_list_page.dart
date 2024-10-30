import 'package:chat_application/core/base/blocs/user/all-user/user_bloc.dart';
import 'package:chat_application/core/base/blocs/user/user-own/user_info_bloc.dart';
import 'package:chat_application/core/components/drawer/custom_drawer.dart';
import 'package:chat_application/core/utils/navigate_util.dart';
import 'package:chat_application/views/chat/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/components/default_loading.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    context.read<UserBloc>().add(FetchUsersEvent());
    context.read<UserInfoBloc>().add(FetchUserInfoEvent());

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User list'),
      ),
      drawer: CustomDrawer(),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: DefaultLoading(),
            );
          }
          if (state is UserLoadedState) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.users[index].username ?? ''),
                  subtitle: Text(state.users[index].email ?? ''),
                  trailing: BlocBuilder<UserInfoBloc, UserInfoState>(
                    builder: (context, userState) {
                     if(userState is UserInfoLoadedState) {
                        return IconButton(
                            onPressed: () {
                              NavigateUtil.navigateToView(
                                  context,
                                  ChatScreen(recipientUser: state.users[index],
                                    currentUser:userState.userInfo,));
                            },
                            icon: const Icon(Icons.chat));
                      }
                     return SizedBox.shrink();
                    },

                  ),
                );
              },
            );
          }
          return const Text('data');
        },
      ),
    );
  }
}
