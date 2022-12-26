import 'package:flutter/material.dart';
import 'package:veri_tabani_proje/main.dart';

class DietProgram extends StatefulWidget {
  const DietProgram({super.key});

  @override
  State<DietProgram> createState() => _DietProgramState();
}

class _DietProgramState extends State<DietProgram> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(title: 'Diet Programs', colors: Colors.orange[200]),
      body: Column(
        children: const [
          ListTile(
            title: Text('Gain in Weight'),
            subtitle: Text('Fat and calorie diet program.'),
            trailing: Text('1'),
          ),
          ListTile(
            title: Text('Health'),
            subtitle: Text('Vegetable-based program.'),
            trailing: Text('2'),
          ),
          ListTile(
            title: Text('Burn Fat'),
            subtitle: Text('program based on lean food.'),
            trailing: Text('3'),
          ),
        ],
      ),
    );
  }
}
