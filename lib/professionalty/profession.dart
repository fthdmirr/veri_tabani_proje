import 'package:flutter/material.dart';
import 'package:veri_tabani_proje/main.dart';

class ProfessionView extends StatefulWidget {
  const ProfessionView({super.key});

  @override
  State<ProfessionView> createState() => _ProfessionViewState();
}

class _ProfessionViewState extends State<ProfessionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(title: 'Profession', colors: Colors.green[200]),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: const Text('Socker'),
              trailing: const Text('1'),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/socker.jpeg',
                  height: 50,
                  width: 50,
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Gymnastics'),
              trailing: const Text('2'),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/gymnastics.jpeg',
                  height: 50,
                  width: 50,
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Tennis'),
              trailing: const Text('3'),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/tennis.jpeg',
                  height: 50,
                  width: 50,
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Pilates'),
              trailing: const Text('4'),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/pilates.jpeg',
                  height: 50,
                  width: 50,
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Yoga'),
              trailing: const Text('5'),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/yoga.jpeg',
                  height: 50,
                  width: 50,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
