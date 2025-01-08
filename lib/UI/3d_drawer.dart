import 'package:animations/UI/animated_prompt.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class MyDrawer extends StatefulWidget {
  final Widget child;
  final Widget drawer;

  const MyDrawer({super.key, required this.child, required this.drawer});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {
  late AnimationController _xControllerForChild;
  late Animation<double> _yRotationAnimationForChild;

  late AnimationController _xControllerForDrawer;
  late Animation<double> _yRotationAnimationForDrawer;

  @override
  void initState() {
    super.initState();
    _xControllerForChild =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _yRotationAnimationForChild = Tween<double>(
      begin: 0,
      end: -pi / 2,
    ).animate(_xControllerForChild);

    _xControllerForDrawer =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _yRotationAnimationForDrawer = Tween<double>(
      begin: pi / 2.7,
      end: 0,
    ).animate(_xControllerForDrawer);
  }

  @override
  void dispose() {
    _xControllerForDrawer.dispose();
    _xControllerForChild.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxDrag = screenWidth * 0.8;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        final delta = details.delta.dx / maxDrag;
        _xControllerForChild.value += delta;
        _xControllerForDrawer.value += delta;
      },
      onHorizontalDragEnd: (details) {
        if (_xControllerForChild.value < 0.5) {
          _xControllerForChild.reverse();
          _xControllerForDrawer.reverse();
        } else {
          _xControllerForChild.forward();
          _xControllerForDrawer.forward();
        }
      },
      child: AnimatedBuilder(
        animation: Listenable.merge(
          [_xControllerForChild, _xControllerForDrawer],
        ),
        builder: (context, child) {
          return Stack(
            children: [
              Container(
                color: Colors.indigoAccent.withOpacity(0.2),
              ),
              Transform(
                  alignment: Alignment.centerLeft,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..translate(_xControllerForChild.value * maxDrag)
                    ..rotateY(_yRotationAnimationForChild.value),
                  child: widget.child),
              Transform(
                  alignment: Alignment.centerRight,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..translate(
                        -screenWidth + _xControllerForDrawer.value * maxDrag)
                    ..rotateY(_yRotationAnimationForDrawer.value),
                  child: widget.drawer),
            ],
          );
        },
      ),
    );
  }
}

class Drawer3D extends StatelessWidget {
  const Drawer3D({super.key});

  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      drawer: Material(
        child: Container(
          color: Colors.green.withOpacity(0.25),
          child: ListView.builder(
            padding: EdgeInsets.only(left: 100, top: 100),
            itemCount: 20,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("Item $index"),
              );
            },
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Drawer"),
        ),
        body: Container(
          color: Colors.black,
          child: Center(child: ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AnimatedPrompt(),));
          }, child: Text("Next"))),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'dart:math';
//
//
//
// class MyDrawer extends StatefulWidget {
//   final Widget child;
//   final Widget drawer;
//
//   const MyDrawer({super.key, required this.child, required this.drawer});
//
//   @override
//   State<MyDrawer> createState() => _MyDrawerState();
// }
//
// class _MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {
//   late AnimationController _xControllerForChild;
//   late Animation<double> _yRotationAnimationForChild;
//
//   late AnimationController _xControllerForDrawer;
//   late Animation<double> _yRotationAnimationForDrawer;
//
//   @override
//   void initState() {
//     super.initState();
//     _xControllerForChild =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 500));
//     _yRotationAnimationForChild = Tween<double>(
//       begin: 0,
//       end: -pi / 2,
//     ).animate(_xControllerForChild);
//
//     _xControllerForDrawer =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 500));
//     _yRotationAnimationForDrawer = Tween<double>(
//       begin: 0,
//       end: -pi / 2,
//     ).animate(_xControllerForDrawer);
//   }
//
//   @override
//   void dispose() {
//     _xControllerForChild.dispose();
//     _xControllerForDrawer.dispose();
//     super.dispose();
//   }
//
//
// }
//
//
//
// class App extends StatelessWidget {
//   const App({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MyDrawer(
//       drawer: Material(
//         child: Container(
//           color: Color(0xff24283b),
//           child: ListView.builder(
//             padding: EdgeInsets.only(left: 80, top: 100),
//             itemCount: 20,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text("Tile $index"),
//               );
//             },
//           ),
//         ),
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("3D Drawer,"),
//           centerTitle: true,
//         ),
//       ),
//     );
//   }
//
// }
//
