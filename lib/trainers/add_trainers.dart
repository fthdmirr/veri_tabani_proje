import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veri_tabani_proje/main.dart';
import 'package:veri_tabani_proje/sql/trainer_sql.dart';
import 'package:veri_tabani_proje/trainers/trainer_model.dart';

class AddTrainers extends StatefulWidget {
  const AddTrainers({super.key, required this.trainersDatabase});

  final TrainerDatabase trainersDatabase;

  @override
  State<AddTrainers> createState() => _AddTrainersState();
}

class _AddTrainersState extends State<AddTrainers> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  static List<String> dropdownValues = ['Fitness', 'Socker', 'Gymnastics', 'Tennis'];

  String dropdownValue = dropdownValues.first;

  Future<void> _addTrainer(Trainer trainer) async {
    await widget.trainersDatabase.insert(trainer);

    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(title: 'Add Trainer', colors: Colors.red[200]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              validator: (value) =>
                  (value?.length ?? 0) < 3 ? 'Name length must be greater than 2' : null,
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Name'),
                hintText: 'Please enter your name',
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              controller: salaryController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Salary'),
                hintText: 'Please enter your Weight',
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                controller: yearController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Year'),
                  hintText: 'Please enter your years of experience year',
                ),
                validator: (value) {
                  if (value == null) return 'Enter something';
                  if (int.parse(value) < 20) return 'Experience cannot be greater than 50';
                  return null;
                }),
            const SizedBox(height: 8),
            DropdownButton<String>(
              isExpanded: true,
              value: dropdownValue,
              elevation: 16,
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: dropdownValues.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                _addTrainer(
                    Trainer(nameController.text, salaryController.text, yearController.text,dropdownValue));
              },
              icon: const Icon(Icons.done),
              label: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
