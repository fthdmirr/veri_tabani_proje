import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veri_tabani_proje/diet_program/diet_program.dart';
import 'package:veri_tabani_proje/member/members.dart';
import 'package:veri_tabani_proje/professionalty/profession.dart';
import 'package:veri_tabani_proje/trainers/trainers.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'GYM System Managment',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.blue[300]),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/gym.svg',
                height: 200,
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const Members()));
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.blue[200], borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                          child: Text('Members',
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15))),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const Trainers()));
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.red[200], borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                          child: Text('Trainers',
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15))),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const ProfessionView()));
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.green[200], borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                          child: Text(
                        'Profession',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const DietProgram()));
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.orange[200], borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                          child: Text('Diet Program',
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

AppBar globalAppBar({required String title, Widget? icon, Color? colors}) => AppBar(
      title: Text(title),
      backgroundColor: colors,
      actions: [icon ?? const SizedBox.shrink()],
    );
