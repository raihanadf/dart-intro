import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Named Routes Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const MyApp(),
        '/second': (context) => const SecondApp(),
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget upperSection = Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Expanded(
                  child: Text(
                      "ketik 1 jika anda capek, yahahahah jamsut fristel hehe ku kira takkan ada kendala ku kira lorem ipsum dolor sit jamett",
                      softWrap: true)),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: const [Icon(Icons.place), Text("ligma")],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: const [Icon(Icons.access_alarm), Text("sayang")],
                ),
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/second");
                  },
                  child: Icon(Icons.abc))
            ],
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.dashboard),
        title: const Text("Belajar melepaskan dirinya"),
        actions: [
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.search),
              )
            ],
          )
        ],
        backgroundColor: Colors.blue[500],
      ),
      body: Column(
        children: [
          Image.network(
            "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
            width: 600,
            fit: BoxFit.cover,
          ),
          const FavoriteWidget(),
          upperSection,
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.blue, shape: BoxShape.circle),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.blue, shape: BoxShape.circle),
                    ),
                  ],
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.redAccent),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.redAccent),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.redAccent),
                ),
                Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.blue, shape: BoxShape.circle),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.blue, shape: BoxShape.circle),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print("hehe"),
        backgroundColor: Colors.pink[500],
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({Key? key}) : super(key: key);

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 69;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: (_isFavorited
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: SizedBox(child: Text('$_favoriteCount')),
        )
      ],
    );
  }
}

class SecondApp extends StatelessWidget {
  const SecondApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("lol kids"))),
      appBar: AppBar(
        leading: Icon(Icons.dashboard),
        title: const Text("Belajar melepaskan dirinya"),
        actions: [
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.search),
              )
            ],
          )
        ],
        backgroundColor: Colors.blue[500],
      ),
    );
  }
}
