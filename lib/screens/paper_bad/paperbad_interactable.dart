import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PaperBadInteractable extends StatefulWidget {
  const PaperBadInteractable({Key? key}) : super(key: key);

  @override
  State<PaperBadInteractable> createState() => _PaperBadInteractableState();
}

class _PaperBadInteractableState extends State<PaperBadInteractable> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "textures/dummy-no-royalty.jpg",
      fit: BoxFit.cover,
    );
  }
}
