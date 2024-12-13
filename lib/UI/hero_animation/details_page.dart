import 'package:animations/UI/hero_animation/hero_animation.dart';
import 'package:animations/UI/implicit_animation.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final Person person;

  const DetailsPage({
    super.key,
    required this.person,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
            flightShuttleBuilder: (flightContext, animation, flightDirection,
                fromHeroContext, toHeroContext) {
              switch (flightDirection) {
                case HeroFlightDirection.push:
                  return Material(
                      color: Colors.transparent,
                      child: ScaleTransition(
                          scale: animation.drive(
                            Tween<double>(
                              begin: 0.0,
                              end: 1.0,
                            ).chain(CurveTween(curve: Curves.fastOutSlowIn)),
                          ),
                          child: toHeroContext.widget));

                case HeroFlightDirection.pop:
                  return Material(
                      color: Colors.transparent, child: fromHeroContext.widget);
              }
            },
            tag: widget.person.emoji,
            child: Material(
                color: Colors.transparent,
                child: Text(
                  widget.person.emoji,
                  style: TextStyle(fontSize: 50),
                ))),
        centerTitle: true,
        backgroundColor: Colors.grey.shade500,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.person.name,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "${widget.person.age} years old",
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImplicitAnimation(),
                      ));
                },
                child: Text("Next"))
          ],
        ),
      ),
    );
  }
}
