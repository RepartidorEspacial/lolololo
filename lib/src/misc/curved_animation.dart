// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:ui';
import 'package:flutter/rendering.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
class CurvedAnimationDemo extends StatefulWidget {
  static const String routeName = '/misc/curved_animation';

  @override
  _CurvedAnimationDemoState createState() => _CurvedAnimationDemoState();
}

class CurveChoice {
  final Curve curve;
  final String name;
  const CurveChoice({this.curve, this.name});
}

class _CurvedAnimationDemoState extends State<CurvedAnimationDemo>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animationRotation;
  Animation<Offset> animationTranslation;
  static const _duration = Duration(seconds: 4);
  List<CurveChoice> curves = [
    CurveChoice(curve: Curves.bounceIn, name: 'Bounce In'),
    CurveChoice(curve: Curves.bounceOut, name: 'Bounce Out'),
    CurveChoice(curve: Curves.easeInCubic, name: 'Ease In Cubic'),
    CurveChoice(curve: Curves.easeOutCubic, name: 'Ease Out Cubic'),
    CurveChoice(curve: Curves.easeInExpo, name: 'Ease In Expo'),
    CurveChoice(curve: Curves.easeOutExpo, name: 'Ease Out Expo'),
    CurveChoice(curve: Curves.elasticIn, name: 'Elastic In'),
    CurveChoice(curve: Curves.elasticOut, name: 'Elastic Out'),
    CurveChoice(curve: Curves.easeInQuart, name: 'Ease In Quart'),
    CurveChoice(curve: Curves.easeOutQuart, name: 'Ease Out Quart'),
    CurveChoice(curve: Curves.easeInCirc, name: 'Ease In Circle'),
    CurveChoice(curve: Curves.easeOutCirc, name: 'Ease Out Circle'),
  ];
  CurveChoice selectedForwardCurve, selectedReverseCurve;
  CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: _duration,
      vsync: this,
    );
    selectedForwardCurve = curves[2];
    selectedReverseCurve = curves[2];
    curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: selectedForwardCurve.curve,
      reverseCurve: selectedReverseCurve.curve,
    );
    animationRotation = Tween<double>(
      begin: -5,
      end: 0,
    ).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //controller.reverse();
        }
      });
    animationTranslation = Tween<Offset>(
      begin: Offset(-2, 0),
      end: Offset(0, 0),
    ).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
        //  controller.reverse();
        }
      });
      controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; 
    final str =  'assets/watermelon.svg';
    final Widget svg =  SvgPicture.asset(str  );
       
     //                        str,
                             //bundle: BlendMode,
                            // bundle: AssetBundlePictureKey(bundle:, name:"assets/watermelon.svg",)
                            // colorBlendMode: BlendMode.clear ,
                            // width: size.width,

                            // allowDrawingOutsideViewBox: true ,
       //                     );
    return Scaffold(
      backgroundColor: Color(0xFF028090),
      drawerScrimColor: Colors.blue,
      body:Center(child:  
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          FractionalTranslation(
            translation: animationTranslation.value,
            child: Container(
              
              child: /* FlutterLogo(
                size: size.width,
              )*/
               svg 
              
              // SvgPicture.asset(
              //                 'assets/watermelon.svg',
              //                width: size.width,
              //                allowDrawingOutsideViewBox: true ,
              //               )
               )
              ),
            
        ],
      ),
      )
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
