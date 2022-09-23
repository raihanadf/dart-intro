import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main(List<String> args) {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> gambar = [
    "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
    "https://c.tenor.com/Rz19D5EE6QoAAAAC/dank-meme.gif",
    "https://media1.giphy.com/media/8m4R4pvViWtRzbloJ1/200w.gif?cid=82a1493biapxotzqld66hsvzjup8uxt5yg7bcm3i0lzs7cju&rid=200w.gif&ct=g",
    "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
    "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
    "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
    "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
    "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
  ];

  static const Map<String, Color> colors = {
    "one": Color(0xFF2DB569),
    "two": Color(0xFF2DB569),
    "three": Color(0xFF2DB569),
    "four": Color(0xFF2DB569),
    "five": Color(0xFF2DB569),
    "six": Color(0xFF2DB569),
    "seven": Color(0xFF2DB569),
    "eight": Color(0xFF2DB569),
  };

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.purpleAccent, Colors.deepPurple],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter)),
        child: PageView.builder(
          controller: PageController(viewportFraction: 0.8),
          itemCount: gambar.length,
          itemBuilder: (BuildContext context, int i) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 50.0),
              child: Material(
                elevation: 8.0,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                        tag: gambar[i],
                        child: Material(
                          child: InkWell(
                            child: Flexible(
                              flex: 1,
                              child: Container(
                                color: colors.values.elementAt(i),
                                child: Image.network(
                                  gambar[i],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => Halamandua(
                                        gambar: gambar[i],
                                        colors: colors.values.elementAt(i)))),
                          ),
                        ))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Halamandua extends StatefulWidget {
  const Halamandua({super.key, required this.gambar, required this.colors});
  final String gambar;
  final Color colors;

  @override
  State<Halamandua> createState() => _HalamanduaState();
}

class _HalamanduaState extends State<Halamandua> {
  Color warna = Colors.grey;

  void _pilihannya(Pilihan pilihan) {
    setState(() {
      warna = pilihan.warna;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BT21"),
        backgroundColor: Colors.purpleAccent,
        actions: [
          PopupMenuButton<Pilihan>(
              onSelected: _pilihannya,
              itemBuilder: (BuildContext context) {
                return listPilihan.map((Pilihan x) {
                  return PopupMenuItem(value: x,child: Text(x.teks),);
                }).toList();
              })
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: RadialGradient(
                    center: Alignment.center,
                    colors: [Colors.purple, Colors.white, Colors.deepPurple])),
          ),
          Center(
            child: Hero(
                tag: widget.gambar,
                child: ClipOval(
                  child: SizedBox(
                    width: 200.0,
                    height: 200.0,
                    child: Material(
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Flexible(
                            child: Flexible(
                                flex: 1,
                                child: Container(
                                  color: widget.colors,
                                  child: Image.network(widget.gambar,
                                      fit: BoxFit.cover),
                                ))),
                      ),
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}

class Pilihan {
  const Pilihan({required this.teks, required this.warna});
  final String teks;
  final Color warna;
}

List<Pilihan> listPilihan = const <Pilihan>[
  const Pilihan(teks: "Red", warna: Colors.red),
  const Pilihan(teks: "Green", warna: Colors.green),
  const Pilihan(teks: "Blue", warna: Colors.blue),
];
