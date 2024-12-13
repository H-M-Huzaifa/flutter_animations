import 'package:animations/UI/tween_circle.dart';
import 'package:flutter/material.dart';

class ImplicitAnimation extends StatefulWidget {
  const ImplicitAnimation({super.key});

  @override
  State<ImplicitAnimation> createState() => _ImplicitAnimationState();
}

  const defaultWidth=100.0;

class _ImplicitAnimationState extends State<ImplicitAnimation> {


  var _isZoomedIn=false;
  var _buttonTitle="Zoom In";
  var _width = defaultWidth;
  var _curve=Curves.bounceOut;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Implicit Animation"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => TweenCircle(),));

          }, icon: Icon(Icons.arrow_forward_ios))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 370 ),
                width: _width,
                curve: _curve,
                child: Image.asset('assets/images/myimage.jpg')
              )),
          SizedBox(height: 20,),


          TextButton(onPressed: (){
            setState(() {
              _isZoomedIn =!_isZoomedIn;
              _buttonTitle = _isZoomedIn ?"Zoom Out"  : "Zoom In";
              _width= _isZoomedIn ? MediaQuery.of(context).size.width : defaultWidth;
            });
          }, child: Text(_buttonTitle))
        ],
      ),
    );
  }
}
