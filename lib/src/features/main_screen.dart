import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _controller = TextEditingController();
  Future<String>? _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              spacing: 32,
              children: [
                TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Postleitzahl",
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _future = getCityFromZip(_controller.text);
                    });
                  },
                  child: const Text("Suche"),
                ),
                FutureBuilder(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          Text("Lädt."),
                        ],
                      );
                    }
                    if (snapshot.hasError) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.error_outlined,
                            color: Colors.red,
                            size: 32,
                          ),
                          Text(
                            "Ergebnis: Fehler : ${snapshot.error}",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      );
                    }
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_box_outlined,
                            color: Colors.green,
                            size: 32,
                          ),
                          Text(
                            "Ergebnis: Die Stadt ist : ${snapshot.data}",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        Icon(
                          Icons.info_outlined,
                          color: Colors.black,
                          size: 32,
                        ),
                        Text(
                          "Es wurde noch nicht gesucht.",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<String> getCityFromZip(String zip) async {
    // simuliere Dauer der Datenbank-Anfrage
    await Future.delayed(const Duration(seconds: 3));
    // throw Exception("Fehler selbst gemacht!");
    switch (zip) {
      case "06536":
        return "Südharz";
      case "10115":
        return 'Berlin';
      case "20095":
        return 'Hamburg';
      case "80331":
        return 'München';
      case "50667":
        return 'Köln';
      case "60311":
      case "60313":
        return 'Frankfurt am Main';
      default:
        return 'Unbekannte Stadt';
    }
  }
}
