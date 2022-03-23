import 'package:banking/src/presentation/blocs/friends/friends_bloc.dart';
import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/clippers.dart';
import 'package:banking/src/presentation/widgets/custom_clip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FriendsPage extends StatefulWidget {
  final String? searchText;
  const FriendsPage({
    required this.searchText,
    Key? key,
  }) : super(key: key);

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
      length: 2,
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
      unselectedLabelColor: Colors.grey,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(30), // Creates border
        color: Colors.greenAccent,
      ),
      enableFeedback: true,
      indicatorColor: Colors.transparent,
      controller: tabController,
      tabs: const [
        Text(
          'Friends',
        ),
        Text(
          'Requests',
        ),
      ],
    );
  }

  Widget _friend(String name) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: ClipShadowPath(
        clipper: SettingsCardClipper(),
        shadow: Shadow(
          offset: const Offset(0, 0),
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 10,
        ),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 4,
                  child: Row(
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
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Flexible(
                        child: Text(
                          name,
                          style: AppTextStyles.loginBlackSemi,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                      primary: Colors.white,
                    ),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _requestFriend(String name) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: ClipShadowPath(
        clipper: SettingsCardClipper(),
        shadow: Shadow(
          offset: const Offset(0, 0),
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 10,
        ),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Flexible(
                        child: Text(
                          name,
                          style: AppTextStyles.loginBlackSemi,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(10),
                          primary: Colors.white,
                        ),
                        child: const Icon(
                          Icons.done,
                          color: Colors.greenAccent,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(10),
                          primary: Colors.white,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loading() {
    return const SpinKitWave(color: Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          height: 150,
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
            width: double.infinity,
            child: widget.searchText == null
                ? _tabController()
                : const Center(
                    child: Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: BlocBuilder<FriendsBloc, FriendsState>(
              builder: (context, state) {
                if (widget.searchText == null) {
                  return TabBarView(
                    controller: tabController,
                    children: [
                      state is FriendsLoadedState
                          ? MediaQuery.removePadding(
                              removeTop: true,
                              context: context,
                              child: ListView.builder(
                                itemCount: state.friends != null
                                    ? state.friends!.length
                                    : 0,
                                itemBuilder: (BuildContext ctx, int i) {
                                  return _friend(state.friends![i].info.name);
                                },
                              ),
                            )
                          : _loading(),
                      state is FriendsLoadedState
                          ? MediaQuery.removePadding(
                              removeTop: true,
                              context: context,
                              child: ListView.builder(
                                itemCount: state.requests != null
                                    ? state.requests!.length
                                    : 0,
                                itemBuilder: (BuildContext ctx, int i) {
                                  return _requestFriend(
                                      state.requests![i].info.name);
                                },
                              ),
                            )
                          : _loading(),
                    ],
                  );
                } else {
                  return state is FriendsLoadedState &&
                          state.search != null &&
                          state.search!.isNotEmpty
                      ? MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView.builder(
                            itemCount:
                                state.search != null ? state.search!.length : 0,
                            itemBuilder: (BuildContext ctx, int i) {
                              if (state.search![i].status == 'confirmed') {
                                return _friend(state.search![i].info.name);
                              } else {
                                return _requestFriend(
                                    state.search![i].info.name);
                              }
                            },
                          ),
                        )
                      : state is FriendsLoadedState &&
                              state.search != null &&
                              state.search!.isEmpty
                          ? Container()
                          : _loading();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
