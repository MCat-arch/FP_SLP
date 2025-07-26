import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:to_do/pages/home.dart';
import 'package:to_do/pages/input_form.dart';
import 'package:to_do/pages/profile.dart';
import 'package:to_do/provider/todo_provider.dart';

// final GoRouter _route = GoRouter(
//   routes: [
//     GoRoute(path: '/', builder: (context, state) => const HomePage()),
//     GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
//     GoRoute(path: '/inputTodo', builder: (context, state) => const InputTodo()),
//   ],
// );

// void main() {
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(providers: [

//       ],
//       child: MaterialApp.router(
//         debugShowCheckedModeBanner: false,
//         routerConfig: _route,
//       ),
//     );
//   }
// }

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TodoProvider(),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: HomePage(),))
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  List<Widget> widgetOptions = const [Home(), ProfilePage()];

  void onClickNav(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          selectedIndex == 0
              ? AppBar(
                toolbarHeight: 100,
                title: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: 'Todo',
                      style: TextStyle(
                        fontSize: 42,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w700,
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'List',
                          style: TextStyle(
                            fontSize: 42,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              : null,
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.white60,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: selectedIndex,
        onTap: onClickNav,
      ),
      floatingActionButton:
          selectedIndex == 0
              ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Inputform(),
                    ),
                  );
                },
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.add, color: Colors.white),
              )
              : null,
    );
  }
}
