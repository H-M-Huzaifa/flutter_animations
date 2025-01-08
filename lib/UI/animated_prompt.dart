import 'package:flutter/material.dart';

class myanimation extends StatefulWidget {
  final String title;

  final String subTitle;
  final Widget child;

  const myanimation(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.child});

  @override
  State<myanimation> createState() => _myanimationState();
}

class _myanimationState extends State<myanimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _containerScaleAnimation;
  late Animation<Offset> _yAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _yAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, -0.23),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _iconScaleAnimation = Tween<double>(
      begin: 7,
      end: 6,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _containerScaleAnimation = Tween<double>(
      begin: 2.4,
      end: 0.4,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller
      ..reset()
      ..forward();
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.yellow.shade200,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3)),
            ]),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 200,
            minHeight: 200,
            maxWidth: MediaQuery.of(context).size.width * 0.8,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 160,
                    ),
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      widget.subTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                  child: SlideTransition(
                position: _yAnimation,
                child: ScaleTransition(
                    scale: _containerScaleAnimation,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green
                    ),
                    child: ScaleTransition(
                        scale: _iconScaleAnimation,
                      child: widget.child,
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedPrompt extends StatelessWidget {
  const AnimatedPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.withOpacity(0.25),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Animated Prompt"),
      ),
      body: Center(
        child: myanimation(
          title: 'Thank you for your order!',
          subTitle: 'Your order will be delivered within 2 hours.',
          child: Icon(Icons.check),
        ),
      ),
    );
  }
}
