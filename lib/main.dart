import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: LogoApp()));

class AnimatedLogo extends AnimatedWidget {
  // Constructor
  const AnimatedLogo({super.key, required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: animation.value,
        height: animation.value,
        child: const Text(
          'DA',
          textDirection: TextDirection.rtl,
          style: TextStyle(
              fontSize: 100, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  const LogoApp({super.key});

  @override
  State<LogoApp> createState() {
    return _LogoAppState();
  }
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 500).animate(controller)
      ..addStatusListener((status) => {
            if (status == AnimationStatus.completed)
              {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Auth()),
                )
              }
            else if (status == AnimationStatus.dismissed)
              {print("dismissed")}
          });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buktikan Dirimu'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              controller: myController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your pin',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (myController.text == 'daffavcd') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Notes()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('You are Autorized.')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Incorrect Pin.')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secret Notes'),
      ),
      body: Column(
        children: <Widget>[
          TextFormField(
            controller: myController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (myController.text == '123') {
                  print('correct');
                } else {
                  print('incorrect');
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
