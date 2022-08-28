import 'package:animation_in_flutter/helpers/custom_route.dart';
import 'package:animation_in_flutter/second_screen.dart';
import 'package:animation_in_flutter/third_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CustomPageTransitionBuilder(),
            TargetPlatform.iOS: IOSCustomPageTransitionBuilder(),
          },
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double _cubeSize = 150;
  bool _isIncrease = true;
  Color color = Colors.orange;
  double _fontSize = 0;

  late AnimationController _animationController;
  late Animation<Size> _cubeSizeAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
    _cubeSizeAnimation = Tween<Size>(
      begin: const Size(150, 150),
      end: const Size(300, 300),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
    _opacityAnimation = Tween<double>(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    // _cubeSizeAnimation.addListener(() => setState(() {}));
  }

  void _toggleSize() {
    setState(() {
      if (_isIncrease) {
        _cubeSize = 300;
        _isIncrease = false;
        _animationController.forward();
        color = Colors.blue;
        _fontSize = 30;
      } else {
        _cubeSize = 150;
        _isIncrease = true;
        _animationController.reverse();
        color = Colors.orange;
        _fontSize = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const ThirdScreen(),
            ),
          ),
          child: Card(
            elevation: 10,
            child: AnimatedContainer(
              // width: _cubeSizeAnimation.value.width,
              // height: _cubeSizeAnimation.value.height,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
              width: 300,
              height: 300,
              color: color,
              child: Center(
                child: FadeTransition(
                  opacity: _opacityAnimation,
                  child: const Hero(
                    tag: "demoId",
                    child: FadeInImage(
                      placeholder: AssetImage('assets/images/car.jpg'),
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1503376780353-7e6692767b70?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
                      ),
                      fit: BoxFit.cover,
                      width: 300,
                      height: 300,
                    ),
                  ),

                  // AnimatedDefaultTextStyle(
                  //   duration: const Duration(milliseconds: 300),
                  //   style: TextStyle(
                  //     fontSize: _fontSize,
                  //     color: Colors.white,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  //   child: const Text(
                  //     "Salom Box!",
                  //   ),
                  // ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const SecondScreen(),
            ),
          );
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
