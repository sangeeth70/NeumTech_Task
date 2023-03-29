import 'package:flutter/material.dart';
import 'User_list.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  double _AnimeHeight = 300;
  double _AnimeWidth = 300;
  @override
  void initState() {
    count();
    // TODO: implement initState
    super.initState();
  }

  count() {
    Future.delayed(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 1400),
            pageBuilder: (context, animation, secondaryAnimation) {
              return User_list();
            },
          )),
    );
    Future.delayed(Duration(milliseconds: 300)).then((value) =>
    {
      print("object"),
    setState(() {
    _AnimeHeight = 100;
    _AnimeWidth = 100;
    })
    });

  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: _width,
            height: _height,
            color: Color.fromARGB(
              255,
              62,
              64,
              139,
            ),
          ),
          Center(
            child: AnimatedContainer(

              duration: Duration(seconds: 3),
              curve: Curves.decelerate,
              height: _AnimeHeight,
              width: _AnimeWidth,
              child: Image.asset('assets/neum.jpeg',),
            ),
          ),
        ],
      ),
    );
  }
}
