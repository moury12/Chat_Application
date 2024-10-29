import 'package:chat_application/core/base/blocs/user/user-own/user_info_bloc.dart';
import 'package:chat_application/core/components/default_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    super.initState();
    // Trigger fetching user info when the widget initializes.
    context.read<UserInfoBloc>().add(FetchUserInfoEvent());
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Drawer(
        child: Column(children: [
          BlocBuilder<UserInfoBloc, UserInfoState>(
            builder: (context, state) {
              if(state is UserInfoLoadingState){
                return DefaultLoading();
              }
              if(state is UserInfoLoadedState){
                return ListTile(
                  leading: Icon(Icons.account_circle),
                  title:Text(state.userInfo.username??'') ,
                  subtitle: Text(state.userInfo.email??''),
                );
              }
              return SizedBox.shrink();
            },
          )
        ],),
      ),
    );
  }
}
