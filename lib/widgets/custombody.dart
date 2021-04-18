import 'package:flutter/material.dart';

class BaseBodyLayout extends StatelessWidget {
  final Widget child;
  final String asset;

  BaseBodyLayout({required this.child, required this.asset});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.2), BlendMode.dstATop),
          image: AssetImage(this.asset),
          fit: BoxFit.cover,
        ),
      ),
      child: this.child /* add child content here */,
    );
  }
}
