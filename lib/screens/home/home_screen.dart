import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.navigationShell});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  final StatefulNavigationShell navigationShell;
}

class _HomeScreenState extends State<HomeScreen> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    void goToBranch(int index) {
      widget.navigationShell.goBranch(index,
          initialLocation: index == widget.navigationShell.currentIndex);
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
            goToBranch(currentIndex);
          },
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.task_alt_sharp), label: "Tasks"),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on), label: "Maps"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: widget.navigationShell,
        ));
  }
}
