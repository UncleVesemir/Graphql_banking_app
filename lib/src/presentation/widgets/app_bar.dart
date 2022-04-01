import 'package:banking/src/presentation/blocs/cards/cards_bloc.dart';
import 'package:banking/src/presentation/blocs/sign_in_register/sign_in_register_bloc.dart';
import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/func_utils.dart';
import 'package:banking/src/presentation/widgets/add_card_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatefulWidget {
  final int index;
  final Function(String? text) onSearch;
  const CustomAppBar({
    required this.onSearch,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

enum HistoryStatus { sended, received, all }

class _CustomAppBarState extends State<CustomAppBar> {
  final TextEditingController _controller = TextEditingController();
  bool isSearch = false;
  HistoryStatus historyStatus = HistoryStatus.all;

  void _changeStatus() {
    setState(() {
      if (historyStatus == HistoryStatus.sended) {
        historyStatus = HistoryStatus.received;
        return;
      }
      if (historyStatus == HistoryStatus.received) {
        historyStatus = HistoryStatus.all;
        return;
      }
      if (historyStatus == HistoryStatus.all) {
        historyStatus = HistoryStatus.sended;
        return;
      }
    });
  }

  void _showCardDialog(CardsState state) {
    showDialog(
      context: context,
      builder: (context) {
        return AddCardDialog(state: state);
      },
    );
  }

  List<Widget> _home(CardsState cardState) {
    return [
      Row(
        children: [
          GestureDetector(
            onTap: () async => _showCardDialog(cardState),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 0.85,
                  colors: [
                    Colors.yellowAccent.withOpacity(0.6),
                    Colors.deepOrange.withOpacity(1),
                  ],
                ),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 15),
            ),
          ),
          const SizedBox(width: 15),
        ],
      )
    ];
  }

  List<Widget> _settings(CardsState cardState) {
    return [
      Row(
        children: [
          GestureDetector(
            onTap: () async {},
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 0.85,
                  colors: [
                    Colors.white.withOpacity(0.6),
                    Colors.purple.withOpacity(1),
                  ],
                ),
              ),
              child: const Icon(Icons.dark_mode, color: Colors.white, size: 15),
            ),
          ),
          const SizedBox(width: 15),
        ],
      )
    ];
  }

  List<Widget> _history(CardsState cardState) {
    return [
      Row(
        children: [
          GestureDetector(
            onTap: () {
              _changeStatus();
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 0.85,
                  colors: [
                    Colors.white.withOpacity(0.6),
                    Colors.black.withOpacity(1),
                  ],
                ),
              ),
              child: Icon(
                historyStatus == HistoryStatus.sended
                    ? Icons.arrow_upward
                    : historyStatus == HistoryStatus.received
                        ? Icons.arrow_downward
                        : Icons.compare_arrows_sharp,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
          const SizedBox(width: 15),
        ],
      )
    ];
  }

  Widget _searchField() {
    return SizedBox(
      height: 50,
      width: 150,
      child: TextFormField(
        controller: _controller,
        onChanged: (text) {
          if (text == '') {
            widget.onSearch(null);
          } else {
            widget.onSearch(text);
          }
        },
        maxLines: 1,
        cursorColor: Colors.greenAccent,
        cursorWidth: 2,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          hintText: 'Search people',
          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.4)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Colors.greenAccent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.4),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.greenAccent,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _friends(CardsState cardState) {
    return [
      Row(
        children: [
          isSearch ? _searchField() : Container(),
          const SizedBox(width: 15),
          GestureDetector(
            onTap: () {
              setState(() => isSearch = !isSearch);
              widget.onSearch(null);
              _controller.text = '';
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 0.85,
                  colors: [
                    Colors.white.withOpacity(0.6),
                    Colors.greenAccent.withOpacity(1),
                  ],
                ),
              ),
              child: Icon(
                isSearch ? Icons.close : Icons.search,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
          const SizedBox(width: 15),
        ],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    var userState = BlocProvider.of<SignInRegisterBloc>(context).state
        as SignInRegisterLoadedState;
    var cardState = BlocProvider.of<CardsBloc>(context).state;

    return AppBar(
      toolbarHeight: 80,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: null,
      automaticallyImplyLeading: false,
      actions: widget.index == 0
          ? _home(cardState)
          : widget.index == 1
              ? _friends(cardState)
              : widget.index == 2
                  ? _settings(cardState)
                  : _history(cardState),
      centerTitle: false,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(FuncUtils.getCurrentDateFormatted(),
              style: AppTextStyles.loginGrey),
          Text('Hey, ${userState.user.name}!',
              style: AppTextStyles.boldMediumValueBlack),
        ],
      ),
    );
  }
}
