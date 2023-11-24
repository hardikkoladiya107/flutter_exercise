import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../generated/assets.dart';
import '../../other/app_string.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({
    super.key,
    required this.child
  });

  final StatefulNavigationShell child;

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo'),
        ),
        body: SafeArea(
          child: widget.child,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.child.currentIndex,
          onTap: (index) {
            widget.child.goBranch(
              index,
              initialLocation: index == widget.child.currentIndex,
            );
            //setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              label: home,
              icon: Image.asset(
                Assets.iconsHome,
                height: 20,
                width: 20,
                color: widget.child.currentIndex == 0
                    ? Colors.blue
                    : Colors.grey,
              ),
            ),
            BottomNavigationBarItem(
              label: accounts,
              icon: Image.asset(
                Assets.iconsAccount,
                height: 20,
                width: 20,
                color: widget.child.currentIndex == 1
                    ? Colors.blue
                    : Colors.grey,
              ),
            ),
            BottomNavigationBarItem(
              label: services,
              icon: Image.asset(
                Assets.iconsService,
                height: 20,
                width: 20,
                color: widget.child.currentIndex == 2
                    ? Colors.blue
                    : Colors.grey,
              ),
            ),
          ],
        )
    );
  }
}
