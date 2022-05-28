import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntermediateTexts extends StatelessWidget {
  IntermediateTexts({Key? key}) : super(key: key);
  String intermTexts = '';

  @override
  Widget build(BuildContext context) {
    rootBundle.loadString('strings/paperbad-desc.txt').then((value) {
      intermTexts = value;
    });
    return Center(
      child: Text(intermTexts),
    );
  }
}
