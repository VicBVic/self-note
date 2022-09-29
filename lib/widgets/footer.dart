import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      height: 200,
      child: Text(
        'Contact us!',
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}
