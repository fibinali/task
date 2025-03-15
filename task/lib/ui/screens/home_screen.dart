import 'package:flutter/material.dart';
import '../widget/custom_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<int> _navigationHistory = [0];

  final List<Widget> _pages = [
    const HomeTab(),
    const InsightsTab(),
    const PublicationsTab(),
    const PodcastsTab(),
    const MoreTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_navigationHistory.isEmpty || _navigationHistory.last != index) {
        _navigationHistory.add(index); // Track navigation history
      }
    });
  }

  Future<bool> _onWillPop() async {
    if (_navigationHistory.length > 1) {
      setState(() {
        _navigationHistory.removeLast(); // Remove current tab
        _selectedIndex = _navigationHistory.last; // Go to previous tab
      });
      return false; // Prevent the app from exiting
    }
    return true; // Exit if only one entry (Home tab)
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _navigationHistory.length <= 1,
      onPopInvoked: (didPop) async {
        if (!didPop && _navigationHistory.length > 1) {
          setState(() {
            _navigationHistory.removeLast();
            _selectedIndex = _navigationHistory.last;
          });
        }
      },
      child: Scaffold(
        body: Container(
          color: const Color(0xFF181A20),
          child: IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }

}


class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Welcome to Our App',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

class InsightsTab extends StatefulWidget {
  const InsightsTab({super.key});

  @override
  State<InsightsTab> createState() => _InsightsTabState();
}

class _InsightsTabState extends State<InsightsTab> {
  String selectedCategory = "All Topics";

  final List<Map<String, String>> insights = [
    {"title": "How Türkiye's Arms Industry Leverages Defense Fairs", "date": "20 JAN 2025", "category": "FOREIGN POLICY AND INTERNATIONAL RELATIONS", "imagePath": "lib/ui/assets/turkey_defense.jpeg"},
    {"title": "The U.S.-China trade war: China's challenge in navigating U.S...", "date": "15 JAN 2025", "category": "FOREIGN POLICY AND INTERNATIONAL RELATIONS", "imagePath": "lib/ui/assets/us_china_trade.jpeg"},
    {"title": "Machine Learning for Endangered Language Preservation", "date": "15 JAN 2025", "category": "AI AND ADVANCED TECHNOLOGY", "imagePath": "lib/ui/assets/machine_learning.jpeg"},
    {"title": "Advances in Renewable Energy Integration", "date": "10 JAN 2025", "category": "RENEWABLE ENERGY", "imagePath": "lib/ui/assets/renewable_energy.jpeg"},
    {"title": "How Türkiye's Arms Industry Leverages Defense Fairs", "date": "20 JAN 2025", "category": "FOREIGN POLICY AND INTERNATIONAL RELATIONS", "imagePath": "lib/ui/assets/turkey_defense.jpeg"},
    {"title": "The U.S.-China trade war: China's challenge in navigating U.S...", "date": "15 JAN 2025", "category": "FOREIGN POLICY AND INTERNATIONAL RELATIONS", "imagePath": "lib/ui/assets/us_china_trade.jpeg"},
    {"title": "Machine Learning for Endangered Language Preservation", "date": "15 JAN 2025", "category": "AI AND ADVANCED TECHNOLOGY", "imagePath": "lib/ui/assets/machine_learning.jpeg"},
    {"title": "Advances in Renewable Energy Integration", "date": "10 JAN 2025", "category": "RENEWABLE ENERGY", "imagePath": "lib/ui/assets/renewable_energy.jpeg"},
  ];

  List<String> categories = [
    "All Topics",
    "FOREIGN POLICY AND INTERNATIONAL RELATIONS",
    "AI AND ADVANCED TECHNOLOGY",
    "RENEWABLE ENERGY"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181A20),
      appBar: AppBar(
        backgroundColor: Color(0xFF181A20),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).maybePop();
            },
        ),
        title: Text(
          "Insights",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),

      body: Column(
        children: [
          Container(
            height: 32,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = categories[index];
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedCategory == categories[index] ? Colors.teal : Colors.grey,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8.0),
              children: insights
                  .where((insight) => selectedCategory == "All Topics" || insight["category"] == selectedCategory)
                  .map((insight) => _buildInsightItem(
                insight["title"]!,
                insight["date"]!,
                insight["category"]!,
                insight["imagePath"]!,
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(String title, String date, String category, String imagePath) {
    return Container(

      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color(0xFF181A20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            child: Image.asset(imagePath, width: 120, height: 120, fit: BoxFit.cover),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date, style: TextStyle(color: Colors.grey, fontSize: 12)),
                SizedBox(height: 20),
                Text(category, style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 12)),
                SizedBox(height: 2),
                Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PublicationsTab extends StatelessWidget {
  const PublicationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Publications',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class PodcastsTab extends StatelessWidget {
  const PodcastsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Podcasts',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class MoreTab extends StatelessWidget {
  const MoreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'More',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}