import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:gap/gap.dart';
import 'package:guftago/config/Colors/colors.dart';
import 'package:guftago/service/Chat%20Service/ChatroomService.dart';

import '../../../Domain/model/model.dart';
import '../../../bloc/RealTimeChatUserList/real_time_chat_user_list_bloc.dart';
import '../../../utils/assets.dart';
import '../../views.dart';

class Chatlist extends StatelessWidget {
  const Chatlist({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RealTimeChatUserListBloc, RealTimeChatUserListState>(
      builder: (context, state) {
        if (state is UsersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UsersLoaded) {
          // print("Logs are here: ${state.usersProfile.length}");
          final users = state.users;
          // final profiles = state.usersProfile;
          if (users.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 3,
                children: [
                  const Gap(50),
                  Image.asset(
                    assets.EmptyChat,
                    height: 150,
                    width: 150,
                  ),
                  const Text(
                    "No User Exist 😥\nTry Creating new accounts 😋",
                    style: TextStyle(fontFamily: "Large", fontSize: 18),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: users.length,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final user = users[index];

              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    final currentUser = UserModel(
                      id: FirebaseAuth.instance.currentUser!.uid,
                      name: FirebaseAuth.instance.currentUser!.displayName ??
                          "N/A",
                      email:
                          FirebaseAuth.instance.currentUser!.email.toString(),
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Chatroom(
                            username: user.name.toString(),
                            chatroomID: user.id,
                            chatViewModel: ChatViewModel(
                                ChatRoomService(), currentUser, user),
                          ),
                        ));
                  },
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: colors.black,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    title: Text(user.name),
                    leading: ProfilePicture(
                      name: user.name.toString(),
                      radius: 20,
                      fontsize: 15,
                      random: true,
                    ),
                    subtitle: const Text(
                      "message here!",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    trailing: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: colors.green,
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                        child: Text(
                          index.toString(),
                          style: const TextStyle(
                              color: colors.black, fontFamily: "Large"),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else if (state is UsersError) {
          return Center(child: Text(state.message));
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 3,
              children: [
                const Gap(50),
                Image.asset(
                  assets.EmptyChat,
                  height: 150,
                  width: 150,
                ),
                const Text(
                  "No User Exist 😥\nTry Creating new accounts 😋",
                  style: TextStyle(fontFamily: "Large", fontSize: 18),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
