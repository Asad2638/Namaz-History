import 'package:flutter/material.dart';

void main() {
  runApp(const NamazHistoryApp());
}

class NamazHistoryApp extends StatelessWidget {
  const NamazHistoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namaz History',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const NamazTrackerScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NamazTrackerScreen extends StatefulWidget {
  const NamazTrackerScreen({super.key});

  @override
  State<NamazTrackerScreen> createState() => _NamazTrackerScreenState();
}

class _NamazTrackerScreenState extends State<NamazTrackerScreen> {
  final Map<String, bool> _namazStatus = {
    'Fajr': false,
    'Dhuhr': false,
    'Asr': false,
    'Maghrib': false,
    'Isha': false,
  };

  void _toggleNamaz(String namazName) {
    setState(() {
      _namazStatus[namazName] = !_namazStatus[namazName]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Namaz History Tracker'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today\'s Progress',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: _namazStatus.keys.map((namaz) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6.0),
                    child: CheckboxListTile(
                      title: Text(
                        namaz,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      value: _namazStatus[namaz],
                      onChanged: (bool? value) {
                        _toggleNamaz(namaz);
                      },
                      activeColor: Colors.teal,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Progress saved successfully!'),
                    ),
                  );
                },
                icon: const Icon(Icons.save),
                label: const Text('Save Record'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
