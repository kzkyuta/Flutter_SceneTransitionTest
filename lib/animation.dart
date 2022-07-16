import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void screenTransitionAnimation(BuildContext context, Function screenTransFunc) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    pageBuilder: (context, animation, secondAnimation) {
      return Center(
        child: _LottieAnimation(onAinimCompleted: () {
          screenTransFunc();
        }),
      );
    },
  );
}

class _LottieAnimation extends StatefulWidget {
  const _LottieAnimation({Key? key, required this.onAinimCompleted})
      : super(key: key);
  final Function onAinimCompleted;

  @override
  State<_LottieAnimation> createState() => _LottieAnimationState();
}

class _LottieAnimationState extends State<_LottieAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)
      ..value = 0
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        print(status);
        if (status == AnimationStatus.completed) {
          widget.onAinimCompleted();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: <Widget>[
        Lottie.asset(
          'assets/LottieLogo1.json',
          controller: _controller,
          onLoaded: (composition) {
            setState(() {
              _controller.duration = composition.duration;
            });
            _controller.forward();
          },
        ),
        Text(_controller.value.toStringAsFixed(2)),
      ]),
    );
  }
}
