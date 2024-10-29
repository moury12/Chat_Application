import 'package:chat_application/core/base/blocs/user/all-user/user_bloc.dart';
import 'package:chat_application/core/components/drawer/custom_drawer.dart';
import 'package:chat_application/core/utils/navigate_util.dart';
import 'package:chat_application/views/chat/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/components/default_loading.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

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
            context.read<UserBloc>().add(FetchUsersEvent());
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
                  trailing: IconButton(
                      onPressed: () {
                        NavigateUtil.navigateToView(
                            context,  ChatScreen(user: state.users[index],));
                      },
                      icon: const Icon(Icons.chat)),
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
