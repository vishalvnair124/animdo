import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double _borderRadius = 100;

  final Tween<double> _backgroundScale = Tween<double>(begin: 0.0, end: 1.0);

  AnimationController? _starIconAnimationController;

  @override
  void initState() {
    super.initState();

    _starIconAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _starIconAnimationController!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _pageBackground(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [_circularAnimationButton(), _iconStar()],
            )
          ],
        ),
      ),
    );
  }

  Widget _pageBackground() {
    return TweenAnimationBuilder(
      curve: Curves.fastOutSlowIn,
      tween: _backgroundScale,
      duration: const Duration(seconds: 2),
      builder: (_context, double _scale, _child) {
        return Transform.scale(
          scale: _scale,
          child: _child,
        );
      },
      child: Container(
        color: Colors.blue,
      ),
    );
  }

  Widget _circularAnimationButton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _borderRadius = _borderRadius == 200 ? 100 : 200;
          });
        },
        child: AnimatedContainer(
          curve: Curves.bounceInOut,
          duration: const Duration(seconds: 2),
          width: _borderRadius,
          height: _borderRadius,
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          child: Center(
            child: AnimatedDefaultTextStyle(
              curve: Curves.bounceInOut,
              duration: const Duration(seconds: 2),
              style: TextStyle(
                color: Colors.white,
                fontSize: (_borderRadius * 0.2).clamp(10.0, 40.0),
              ),
              child: const Text("Click Me"),
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconStar() {
    return AnimatedBuilder(
      animation: _starIconAnimationController!.view,
      builder: (_buildContext, _child) {
        return Transform.rotate(
          angle: _starIconAnimationController!.value * 2 * pi,
          child: _child,
        );
      },
      child: const Icon(
        Icons.star,
        size: 100,
        color: Colors.white,
      ),
    );
  }
}
