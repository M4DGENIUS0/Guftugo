import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guftago/config/Colors/colors.dart';
import 'package:guftago/utils/assets.dart';
import 'package:guftago/utils/status/status.dart';
import '../../../../bloc/Login/login_bloc.dart';
import '../../../../bloc/PhotoPicker/photo_picker_bloc.dart';
import '../../../../bloc/SupabaseProfileImage/supabase_profile_image_bloc.dart';
import '../../../../bloc/UserInfoBloc/user_bloc.dart';
import '../../../Setting/Profile/NewProfile/widget/imagepreviewLogic.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    super.initState();
    context
        .read<SupabaseProfileImageBloc>()
        .add(const FetchfromDB(file: 'Profile'));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Material(
            color: const Color.fromARGB(255, 182, 226, 87),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile()),);
              },
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top, bottom: 24),
                child: BlocBuilder<SupabaseProfileImageBloc,
                    SupabaseProfileImageState>(
                  builder: (context, state) {
                    if (state is ImageLoading) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: colors.black,
                      ));
                    }

                    // Handle error state
                    if (state is ImageError) {
                      return Text("Error: ${state.message}");
                    }

                    // Handle loaded state
                    if (state is ImageLoaded) {
                      // Sanitize the URL for network image loading
                      final String sanitizedUrl =
                          Uri.encodeFull(state.imageURL);

                      return BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state.userStatus == GetUserDataStatus.success) {
                            return Column(
                              spacing: 2,
                              children: [
                                InkWell(
                                  onLongPress: () {
                                    context.read<PhotoPickerBloc>().add(
                                        const ImagePreview(previewImage: true));
                                    showDialog(
                                      context: context,
                                      barrierDismissible:
                                          true, // Allows closing by tapping outside
                                      builder: (context) {
                                        return PreviewImageLogic(
                                            image: sanitizedUrl);
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                sanitizedUrl.isEmpty
                                                    ? assets.placeholder2
                                                    : sanitizedUrl)),
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: colors.black, width: 1)),
                                    // child: ProfilePicture(
                                    //   name: state.user?.name ?? "Error",
                                    //   radius: 31,
                                    //   fontsize: 21,
                                    //   img: sanitizedUrl,
                                    // ),
                                  ),
                                ),
                                Text(
                                  state.user!.name,
                                  style: const TextStyle(
                                      fontSize: 28,
                                      color: Colors.black,
                                      fontFamily: "Regular"),
                                ),
                                Text(
                                  FirebaseAuth.instance.currentUser?.email ??
                                      "No Email",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontFamily: "Light"),
                                ),
                              ],
                            );
                          } else if (state.userStatus ==
                              GetUserDataStatus.failure) {
                            return const Text(
                                "Error While Fetching Data\nTry again after a while");
                          } else {
                            return const SizedBox(
                                height: 100,
                                child:
                                    Center(child: CircularProgressIndicator()));
                          }
                        },
                      );
                    }

                    // Default fallback (in case of an unexpected state)
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.account_circle_outlined,
              color: colors.black,
            ),
            title: const Text(
              ' My Profile ',
              style: TextStyle(
                color: colors.black,
                fontFamily: "Regular",
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings_outlined,
              color: colors.black,
            ),
            title: const Text(
              ' Setting',
              style: TextStyle(
                color: colors.black,
                fontFamily: "Regular",
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.message_outlined,
              color: colors.black,
            ),
            title: const Text(
              'Private Chat',
              style: TextStyle(
                color: colors.black,
                fontFamily: "Regular",
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.person_add_alt_outlined,
              color: colors.black,
            ),
            title: const Text(
              ' Invite Friends',
              style: TextStyle(
                color: colors.black,
                fontFamily: "Regular",
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info_outline,
              color: colors.black,
            ),
            title: const Text(
              '  Guftago Features',
              style: TextStyle(
                color: colors.black,
                fontFamily: "Regular",
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                Navigator.pop(context);
                context.read<LoginBloc>().add(LogOut(context));
                FirebaseAuth.instance.authStateChanges().listen(
                  (User? user) {
                    if (user == null) {
                      debugPrint('User is signed out');
                    } else {
                      debugPrint('User is signed in');
                    }
                  },
                );
              })
        ],
      ),
    );
  }
}
