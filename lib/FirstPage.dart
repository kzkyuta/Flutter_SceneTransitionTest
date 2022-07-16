import 'package:flutter/material.dart';
import 'package:flutter_test_application/second_page.dart';
import 'animation.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    void _onPressedFunction() {
      screenTransitionAnimation(context, () {
        print("transition started");
        Navigator.of(context).push(_createRoute());
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.amber.shade200,
      body: const Center(
        child: Text(
          'This is First Page\nYou can transition to next Scene',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressedFunction,
        tooltip: 'Increment',
        child: const Icon(Icons.start),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
      transitionDuration: const Duration(seconds: 1),
      pageBuilder: ((context, animation, secondaryAnimation) =>
          const SecondPage(title: 'Second Page')),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween =
            Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.linear));
        return FadeTransition(
          opacity: animation.drive(tween),
          child: child,
        );
      });
}
