import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veri_tabani_proje/member/member_model.dart';
import 'package:veri_tabani_proje/sql/member_sql.dart';
import 'package:veri_tabani_proje/sql/trainer_sql.dart';

import '../main.dart';

class AddMembers extends StatefulWidget {
  const AddMembers({super.key, required this.membersDatabase});

  final MemberDatabase membersDatabase;

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  static List<String> dropdownValues = [];
  String dropdownValue = dropdownValues.isNotEmpty ? dropdownValues.first : '';
  final trainersDatabase = TrainerDatabase();

  final formKey = GlobalKey<FormState>();

  getTrainers() async {
    final trainers = (await trainersDatabase.getAllTrainer());
    dropdownValues = trainers.map((e) => e.name).toList();
    setState(() {});
  }

  Future<void> _addMember(Member member) async {
    await widget.membersDatabase.insert(member);

    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    getTrainers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(title: 'Add Member', colors: Colors.blue[200]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Name'),
                  hintText: 'Please enter your name',
                ),
                validator: (value) =>
                    (value?.length ?? 0) < 3 ? 'Name length must be greater than 2' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  controller: weightController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Weight'),
                    hintText: 'Please enter your Weight',
                  ),
                  validator: (value) {
                    if (value == null) return 'Enter something';
                    int weight = int.tryParse(value) ?? 0;
                    if (weight < 20) return 'Weight must be greater 20';
                    return null;
                  }),
              const SizedBox(height: 8),
              TextFormField(
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  controller: heightController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Height'),
                    hintText: 'Please enter your Height',
                  ),
                  validator: (value) {
                    if (value == null) return 'Enter something';
                    int height = int.tryParse(value) ?? 0;
                    if (height < 20) return 'Height must be greater 20';
                    return null;
                  }),
              const SizedBox(height: 8),
              TextFormField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                keyboardType: TextInputType.number,
                controller: phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Phone'),
                  hintText: 'Please enter your Phone',
                ),
                validator: (value) =>
                    value != null ? validateMobile(value) : 'please enter something',
              ),
              const SizedBox(height: 8),
              DropdownButton<String>(
                isExpanded: true,
                value: dropdownValue.isNotEmpty ? dropdownValue : null,
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
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
                  if (!formKey.currentState!.validate()) return;
                  _addMember(Member(nameController.text, weightController.text,
                      heightController.text, phoneController.text, dropdownValue));
                },
                icon: const Icon(Icons.done),
                label: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }

  String? validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}
