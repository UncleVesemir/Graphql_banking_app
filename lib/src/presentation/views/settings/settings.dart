import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/clippers.dart';
import 'package:banking/src/presentation/views/settings/profile.dart';
import 'package:banking/src/presentation/widgets/custom_clip.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  GestureDetector _profile() {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext ctx) => const ProfilePage())),
      child: ClipShadowPath(
        shadow: Shadow(
          offset: const Offset(0, 1),
          color: Colors.grey.withOpacity(0.5),
          blurRadius: 10,
        ),
        clipper: SettingsCardClipper(),
        child: Container(
          color: AppColors.mainScaffold,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.language,
                      radius: 32,
                      child: const Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      'Profile',
                      style: AppTextStyles.settingsMid,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Edit',
                      style: AppTextStyles.settingsSmall,
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.keyboard_arrow_right_rounded,
                          size: 28,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ClipShadowPath _security() {
    return ClipShadowPath(
      shadow: Shadow(
        offset: const Offset(0, 1),
        color: Colors.grey.withOpacity(0.5),
        blurRadius: 10,
      ),
      clipper: SettingsCardClipper(),
      child: Container(
        color: AppColors.mainScaffold,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.notifications,
                    radius: 32,
                    child: const Icon(
                      Icons.notifications,
                      size: 30,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    'Notifications',
                    style: AppTextStyles.settingsMid,
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.keyboard_arrow_right_rounded,
                        size: 28,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ClipShadowPath _units() {
    return ClipShadowPath(
      shadow: Shadow(
        offset: const Offset(0, 1),
        color: Colors.grey.withOpacity(0.5),
        blurRadius: 10,
      ),
      clipper: SettingsCardClipper(),
      child: Container(
        color: AppColors.mainScaffold,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.units,
                    radius: 32,
                    child: const Icon(
                      Icons.settings,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    'Security',
                    style: AppTextStyles.settingsMid,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Set',
                    style: AppTextStyles.settingsSmall,
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.keyboard_arrow_right_rounded,
                        size: 28,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppColors.appBackgroundGradientDecoration,
        child: SafeArea(
          child: Column(
            children: [
              ClipShadowPath(
                shadow: Shadow(
                  offset: const Offset(0, 0),
                  color: Colors.grey.withOpacity(0.0),
                  blurRadius: 10,
                ),
                clipper: TabClipper(),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Settings',
                      style: AppTextStyles.friendsSmallGrey,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView(
                      children: [
                        const SizedBox(height: 20),
                        _profile(),
                        const SizedBox(height: 10),
                        _units(),
                        const SizedBox(height: 10),
                        _security(),
                      ],
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
}
