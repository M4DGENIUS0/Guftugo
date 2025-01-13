import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guftago/bloc/Login/login_bloc.dart';
import 'package:guftago/config/routes/route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:guftago/data/network/User%20Repo/firebase/firebase_userrepo.dart';
import 'package:guftago/utils/status/status.dart';
import 'package:guftago/views/views.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Cubit/ProfileScreenCubit.dart';
import 'bloc/AuthState/auth_state_bloc.dart';
import 'bloc/PhotoPicker/photo_picker_bloc.dart';
import 'bloc/RealTimeChatUserList/real_time_chat_user_list_bloc.dart';
import 'bloc/SignUp/signup_bloc.dart';
import 'bloc/SupabaseProfileImage/supabase_profile_image_bloc.dart';
import 'bloc/UserInfoBloc/user_bloc.dart';
import 'bloc/messageblocSocketIO/messagebloc_socket_io_bloc.dart';
import 'data/network/Chat Repo/UserList/Firebase/UserListAbstractRepo.dart';
import 'data/network/Chat Repo/UserList/Supabase/UserListProfileRepo.dart';
import 'data/network/User Repo/Supabase/UserPofileRepoSupabase.dart';
import 'firebase_options.dart';
import 'views/Setting/Profile/NewProfile/widget/profilePhoto.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SupaBase setup
  await Supabase.initialize(
      url: 'https://ckugaubnjndqictdovhh.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNrdWdhdWJuam5kcWljdGRvdmhoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM2ODExODgsImV4cCI6MjA0OTI1NzE4OH0.9U0yT7GPgIXGgyWhp9PFGIWWG6yDgMUJChetV992OSI');

  // Firebase Setup
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Lock the orientation to portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final repo = FirebaseUserRepo();
    return RepositoryProvider(
      create: (_) => AuthStateBloc(userRepo: repo),
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LoginBloc(userRepo: repo),
            ),
            BlocProvider(
              create: (context) => SignupBloc(UserRepo: repo),
            ),
            BlocProvider(
              create: (context) => UserBloc(UserRepository: repo)
                ..add(getUserinfo(
                    userUID: FirebaseAuth.instance.currentUser!.uid)),
            ),
            BlocProvider(
              create: (context) => PhotoPickerBloc(),
            ),
            BlocProvider(
              create: (context) =>
                  SupabaseProfileImageBloc(supbaseUserRepo: SupbaseUserRepo())
                    ..add(const FetchfromDB(file: 'Profile')),
            ),
            BlocProvider(
              create: (context) => ProfileScreenCubit(),
            ),
            BlocProvider(
                create: (context) => RealTimeChatUserListBloc(
                    UserListRepo(
                        userCollection:
                            FirebaseFirestore.instance.collection('users')),
                    UserProfileListRepo(
                      supabaseClient: Supabase.instance.client,
                    ))
                  ..add(
                      FetchUsersList(FirebaseAuth.instance.currentUser!.uid))),
            BlocProvider(create: (_) => MessageblocSocketIoBloc())
          ],
          child: MaterialApp(
            builder: FToastBuilder(),
            title: 'گفتگو',
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            onGenerateRoute: Routes.generateRoute,
            home: BlocBuilder<AuthStateBloc, AuthStateState>(
              builder: (context, state) {
                if (state.authstate == AuthStateStatus.Authenticate) {
                  // return const CreateNewProfile();
                  return const Home();
                  // return Onboard();
                  // return const CreateNewProfile();
                } else if (state.authstate != AuthStateStatus.unAuthenticate) {
                  return const SplashScreen();
                } else {
                  return const Onboard();
                }
              },
            ),
          )),
    );
  }
}
