import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Animation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState(){
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 80.0, end: 100.0).animate(CurvedAnimation(parent: _controller , curve: Curves.elasticOut));

    _animation.addListener((){
      //print("animation ${_animation.value}" );
      setState(() { 
      });
    });

    _animation.addStatusListener((status){
      print(status);
      if(status == AnimationStatus.completed){
        _controller.reverse();
      }else if(status == AnimationStatus.dismissed){
        _controller.forward();
      }
    });

    Timer(Duration(milliseconds: 1000), (){
      //print("start animation ${_animation.value}" );
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.favorite , color:Colors.red , size: _animation.value.toDouble(),)
          ],
        ),
      ),
      
    );
  }
}
