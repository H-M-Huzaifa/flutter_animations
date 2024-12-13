import 'package:animations/UI/hero_animation/details_page.dart';
import 'package:flutter/material.dart';

@immutable
class Person {
  final String name;
  final int age;
  final String emoji;

  const Person({required this.name, required this.age, required this.emoji});
}

const people = [
  Person(name: "Ali", age: 25, emoji: "👦🏻"),
  Person(name: "Zahid", age: 21, emoji: "👦"),
  Person(name: "Maryam", age: 19, emoji: "👧🏻"),
];

class HeroAnimation extends StatefulWidget {
  const HeroAnimation({super.key});

  @override
  State<HeroAnimation> createState() => _HeroAnimationState();
}

class _HeroAnimationState extends State<HeroAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("People"),
        centerTitle: true,
        backgroundColor: Colors.grey.shade500,
      ),
      body: Expanded(child: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder:  (context) => DetailsPage(person: person,)));
            },
            child: ListTile(
              title: Text(person.name),
              subtitle: Text("${person.age} years old"),
              leading: Hero(
                tag: person.emoji,
                child: Text(
                  person.emoji,
                  style: TextStyle(fontSize: 40),
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          );
        },
      )),
    );
  }
}
