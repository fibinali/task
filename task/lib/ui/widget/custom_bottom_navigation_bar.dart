import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: const BoxDecoration(color: Color(0xFF1F222A)),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        selectedItemColor: Colors.tealAccent,
        unselectedItemColor: Colors.white,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.description_outlined), label: 'Insights'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books_outlined), label: 'Publications'),
          BottomNavigationBarItem(icon: Icon(Icons.mic_none), label: 'Podcasts'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}
