import 'dart:convert' as convert;
import 'dart:io';
import 'dart:typed_data';

import 'package:banking/src/presentation/blocs/sign_in_register/sign_in_register_bloc.dart';
import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/clippers.dart';
import 'package:banking/src/presentation/widgets/custom_clip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Uint8List? _bytes;

  void _uploadImage() async {
    final SignInRegisterBloc userBloc =
        BlocProvider.of<SignInRegisterBloc>(context);
    final state = userBloc.state as SignInRegisterLoadedState;
    // var image = await selectImage();
    // userBloc
    // .add(UploadImageEvent(file: image!.toString(), userId: state.user.id));
    final List<int> codeUnits = state.user.image!.codeUnits;
    var temp = Uint8List.fromList(codeUnits);
  }

  Future<Uint8List?> selectImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      File file = File(result.files.single.path!);
      var bytes = file.readAsBytesSync();
      return bytes;
      // var multipartFile = MultipartFile.fromBytes(
      //   'photo',
      //   bytes,
      //   filename: '123',
      //   contentType: MediaType('image', 'png'),
      // );
      // return multipartFile;
    }
  }

  Widget _loaded(SignInRegisterLoadedState state) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              SizedBox(
                width: double.infinity,
                child: ClipShadowPath(
                  clipper: SettingsCardClipper(),
                  shadow: Shadow(
                    offset: const Offset(0, 0),
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                  ),
                  child: Container(
                    color: AppColors.mainScaffold,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          state.user.name,
                                          style: AppTextStyles.boldMediumValue,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(width: 15),
                                        const CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.deepOrange,
                                          child: Icon(
                                            Icons.edit,
                                            size: 13,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      state.user.email,
                                      style: AppTextStyles.regularLowValueGrey,
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: const [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.black,
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.deepOrange,
                                      child: Icon(
                                        Icons.edit,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 400,
                child: ClipShadowPath(
                  clipper: SettingsCardClipper(),
                  shadow: Shadow(
                    offset: const Offset(0, 0),
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                  ),
                  child: Container(
                    color: AppColors.mainScaffold,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: const [
                          Text(
                            'Cards',
                            style: AppTextStyles.regularLowValueGrey,
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 400,
                child: ClipShadowPath(
                  clipper: SettingsCardClipper(),
                  shadow: Shadow(
                    offset: const Offset(0, 0),
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                  ),
                  child: Container(
                    color: AppColors.mainScaffold,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: const [
                          Text(
                            'Transactions',
                            style: AppTextStyles.regularLowValueGrey,
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loading() {
    return const SpinKitWave(
      color: Colors.deepOrange,
    );
  }

  Widget _error(SignInRegisterErrorState state) {
    return Column();
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: const Text(
        'Profile',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
        ),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInRegisterBloc, SignInRegisterState>(
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: _buildAppBar(),
          body: Container(
            decoration: AppColors.appBackgroundGradientDecoration,
            child: state is SignInRegisterLoadedState
                ? _loaded(state)
                : state is SignInRegisterLoadingState
                    ? _loading()
                    : state is SignInRegisterErrorState
                        ? _error(state)
                        : Container(),
          ),
        );
      },
    );
  }
}
