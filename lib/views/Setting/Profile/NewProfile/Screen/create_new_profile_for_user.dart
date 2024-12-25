import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:guftago/config/Colors/colors.dart';
import 'package:guftago/views/Setting/Profile/NewProfile/widget/profilePhoto.dart';

import '../../../../../Cubit/ProfileScreenCubit.dart';
import '../../../../../bloc/PhotoPicker/photo_picker_bloc.dart';
import '../../../../../bloc/SupabaseProfileImage/supabase_profile_image_bloc.dart';
import '../../../../../config/components/toast.dart';
import '../../../../../config/routes/route_name.dart';
import '../../../../../utils/status/status.dart';
import '../widget/About.dart';
import '../widget/continueButton.dart';

class CreateNewProfile extends StatefulWidget {
  const CreateNewProfile({super.key});

  @override
  State<CreateNewProfile> createState() => _CreateNewProfileState();
}

class _CreateNewProfileState extends State<CreateNewProfile> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SupabaseProfileImageBloc, SupabaseProfileImageState>(
      listener: (context, state) {
        if (state is SupabaseProfileImageSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Route_Name.Home,
            (route) => false,
          );
        } else if (state is SupabaseProfileImageFailure) {
          String error = state.message!;
          showCustomToast(context, error);
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(
                  "Set a photo of yourself🤳",
                  style: TextStyle(
                      color: colors.black,
                      fontFamily: "Large",
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
              const Text("Photo make your profile more Engaging✨",
                  style: TextStyle(
                      color: colors.black,
                      fontFamily: "Regular",
                      fontSize: 15)),
              const Gap(100),
              const Center(child: Profilephoto()),
              const Gap(50),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: About(),
              ),
              const Gap(150),
              Padding(
                padding: const EdgeInsets.only(right: 100),
                child: BlocBuilder<PhotoPickerBloc, PhotoPickerState>(
                  builder: (context, state) {
                    return BlocBuilder<ProfileScreenCubit, ButtonState>(
                      builder: (context, status) {
                        final cubit = context.read<ProfileScreenCubit>();
                        return ContinueButton(
                          title: 'Continue',
                          Tap: () async {
                            if (state.file != null) {
                              context.read<SupabaseProfileImageBloc>().add(
                                  UploadtoDB(
                                      context: context, file: state.file!));
                              cubit.setLoading();
                              await Future.delayed(const Duration(seconds: 2));
                              cubit.setDone();
                            } else {
                              cubit.setLoading();
                              showCustomToast(context, 'No file selected');
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
