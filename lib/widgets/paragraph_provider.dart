import 'package:flutter/material.dart';
import 'package:itec20222/robertstore.dart';
import 'package:itec20222/widgets/wavy_container.dart';

class ParagraphProvider extends StatefulWidget {
  final Map? data;
  final double? waveHeight;
  final double? waveLength;
  final double? waveSpeed;
  const ParagraphProvider(
      {Key? key, this.data, this.waveHeight, this.waveLength, this.waveSpeed})
      : super(key: key);

  @override
  State<ParagraphProvider> createState() => _ParagraphProviderState();
}

class _ParagraphProviderState extends State<ParagraphProvider> {

  String users = "0";

  Future<void> getData()
  async {
    users = (await Robertstore().Get_user_count()).toString();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle h1 = Theme.of(context).textTheme.headline2!.copyWith(
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.bold,
        color: Colors.white);
    TextStyle h2 = Theme.of(context).textTheme.headline2!;
    TextStyle b1 =
        Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 22.0);

    const double defHeight = 50;
    const double defLen = 350;
    const double defSpeed = 1;
    var data = widget.data;
    if (data == null) return Container();
    var argb = data['Color'];

    print(data['Type']);
    switch (data['Type']) {
      case "InfoRight":
      case "InfoLeft":
        {
          return WavyContainer(
            height: data['Height'],
            width: double.infinity,
            waveHeight: widget.waveHeight ?? defHeight,
            waveLength: widget.waveLength ?? defLen,
            waveSpeed: widget.waveSpeed ?? defSpeed,
            color: Color.fromARGB(argb[0], argb[1], argb[2], argb[3]),
            waveProcent: 1.0 +
                (((widget.waveHeight ?? defHeight) + 8) / (data['Height'])),
            child: Column(
              crossAxisAlignment: data['Type'] == "InfoRight"
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      64, (widget.waveHeight ?? defHeight) + 16, 64, 64),
                  child: Text(
                    data['Title'],
                    style: h1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                  child: Text(
                    data['Content'],
                    style: b1,
                  ),
                ),
              ],
            ),
          );
        }
      case "UserData":
        {
          //return Text('Salut');
          return WavyContainer(
            height: data['Height'],
            width: double.infinity,
            waveHeight: widget.waveHeight ?? defHeight,
            waveLength: widget.waveLength ?? defLen,
            waveSpeed: widget.waveSpeed ?? defSpeed,
            color: Color.fromARGB(argb[0], argb[1], argb[2], argb[3]),
            waveProcent: 1.0 +
                (((widget.waveHeight ?? defHeight) + 8) / (data['Height'])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      64, (widget.waveHeight ?? defHeight) + 16, 64, 64),
                  child: Text(
                    data['Title'],
                    style: h1,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                      child: Text(
                        '$users Users wrote their selfnotes today.',
                        style: b1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                      child: Text(
                        'A total of 405 people signed up for selfnote.',
                        style: b1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                      child: Text(
                        'The average of all happiness recorded globally was 2.33.',
                        style: b1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
    }
    return Container();
  }
}
