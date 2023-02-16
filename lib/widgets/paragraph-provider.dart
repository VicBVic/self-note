import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itec20222/main.dart';
import 'package:itec20222/robertstore.dart';
import 'package:url_launcher/url_launcher.dart';

final StateProvider<int> userCount = StateProvider((ref) => 0);
final StateProvider<int> writes = StateProvider((ref) => 0);

class ParagraphProvider extends ConsumerStatefulWidget {
  final Map? data;
  final double? waveHeight;
  final double? waveLength;
  final double? waveSpeed;
  const ParagraphProvider(
      {Key? key, this.data, this.waveHeight, this.waveLength, this.waveSpeed})
      : super(key: key);

  @override
  ConsumerState<ParagraphProvider> createState() => _ParagraphProviderState();
}

class _ParagraphProviderState extends ConsumerState<ParagraphProvider> {
  void getCountData() async {
    ref.read(userCount.notifier).state =
        await Robertstore.instance.getUserCount();
  }

  void getWrites() async {
    ref.read(writes.notifier).state = await Robertstore.instance.getWrites();
  }

  @override
  void initState() {
    super.initState();
    getCountData();
    getWrites();
  }

  @override
  Widget build(BuildContext context) {
    return decodeData(widget.data);
  }

  Widget decodeData(Map? data) {
    bool isMobile =
        MediaQuery.of(context).size.width < MediaQuery.of(context).size.height;
    const double defHeight = 100;
    var data = widget.data;
    if (data == null) return Container();
    var argb = data['Color'];
    Color bcolor = Color.fromARGB(argb[0], argb[1], argb[2], argb[3]);
    TextStyle h1 = Theme.of(context).textTheme.displayMedium!.copyWith(
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.bold,
        color: bcolor.computeLuminance() > 0.5 ? Colors.black : Colors.white);
    TextStyle h2 = Theme.of(context).textTheme.displayMedium!;
    TextStyle b1 = Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontSize: 22.0,
        color: bcolor.computeLuminance() > 0.5 ? Colors.black : Colors.white);
    //print(data['Type']);
    switch (data['Type']) {
      case "InfoRight":
      case "InfoLeft":
      case "InfoLink":
        {
          return Padding(
            padding: const EdgeInsets.all(8.0),
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
                data['Type'] == "InfoLink"
                    ? Center(
                        child: ElevatedButton(
                            onPressed: () {
                              final Uri toLaunch = Uri(
                                  scheme: data['Link'][0],
                                  host: data['Link'][1],
                                  path: data['Link'][2]);
                              launchUrl(toLaunch);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(data['Button']),
                            )),
                      )
                    : Container(),
              ],
            ),
          );
        }
      case "UserData":
        {
          var children = [
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
                    '${ref.watch(writes)} Users wrote their selfnotes today.',
                    style: b1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                  child: Text(
                    'A total of ${ref.watch(userCount)} people signed up for selfnote.',
                    style: b1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                  child: Text(
                    'A total of {memoryCount} memories have been written.',
                    style: b1,
                  ),
                ),
              ],
            ),
          ];
          //return Text('Salut');
          return FittedBox(
            child: isMobile
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: children)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: children),
          );
        }
    }
    return Container();
  }

  void openStite(Uri url) async {
    //Uri? uri = Uri.tryParse("https://flutter.io");
    if (await canLaunchUrl(url))
      await launchUrl(url);
    else
      throw "Could not launch $url";
  }
}
