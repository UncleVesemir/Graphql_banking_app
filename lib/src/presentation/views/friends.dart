import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/clippers.dart';
import 'package:banking/src/presentation/widgets/custom_clip.dart';
import 'package:flutter/material.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  Widget _tabController() {
    return TabBar(
      onTap: (value) {
        setState(() {
          selectedTab = value;
        });
      },
      enableFeedback: true,
      indicatorColor: Colors.transparent,
      overlayColor: MaterialStateProperty.all(Colors.red),
      controller: tabController,
      tabs: [
        Text('Friends',
            style: selectedTab == 0
                ? AppTextStyles.friendsSmallBlack
                : AppTextStyles.friendsSmallGrey),
        Text('Subscribers',
            style: selectedTab == 1
                ? AppTextStyles.friendsSmallBlack
                : AppTextStyles.friendsSmallGrey),
        Text('Subscriptions',
            style: selectedTab == 2
                ? AppTextStyles.friendsSmallBlack
                : AppTextStyles.friendsSmallGrey),
      ],
    );
  }

  Widget _friend() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: ClipShadowPath(
        clipper: SettingsCardClipper(),
        shadow: Shadow(
          offset: const Offset(0, 0),
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 10,
        ),
        child: Container(
          height: 120,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Text('Gabe Newell',
                        style: AppTextStyles.loginBlackSemi),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15),
                    primary: Colors.white,
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          height: 120,
        ),
        ClipShadowPath(
          clipper: TabClipper(),
          shadow: Shadow(
            offset: const Offset(0, 0),
            color: Colors.grey.withOpacity(0.0),
            blurRadius: 10,
          ),
          child: Container(
            color: Colors.white,
            height: 50,
            child: _tabController(),
          ),
        ),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 15, bottom: 24),
            child: TabBarView(
              controller: tabController,
              children: [
                MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    children: [
                      _friend(),
                    ],
                  ),
                ),
                MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    children: [
                      _friend(),
                    ],
                  ),
                ),
                MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    children: [
                      _friend(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
