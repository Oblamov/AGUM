import 'package:comp202/pages/DetailPages/ReservationDetailPage.dart';
import 'package:comp202/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:comp202/pages/DetailPages/CampusMapDetailPage.dart';
import 'package:comp202/pages/DetailPages/EventsDetailPage.dart';
import 'package:comp202/pages/DetailPages/LunchDetailPage.dart';
import 'package:comp202/pages/settingspage.dart';
import 'Models/exercise.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];

  List<Exercises> exerciseList = [
    Exercises(
      title: 'Lunch',
      color: Colors.orange[800]!,
      icon: const Icon(Icons.restaurant, color: Colors.white),
    ),
    Exercises(
      title: 'Events',
      color: Colors.blue[500]!,
      icon: const Icon(Icons.event, color: Colors.white),
    ),
    Exercises(
      title: 'Campus Map',
      color: Colors.green[300]!,
      icon: const Icon(Icons.map_outlined, color: Colors.white),
    ),
    Exercises(
      title: 'Reservation',
      color: Colors.deepPurple[400]!,
      icon: const Icon(Icons.assignment, color: Colors.white),
    ),
  ];

  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String dateText = "${date.day} ${months[date.month - 1]}, ${date.year}";

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.asset(
              'assets/photos/library.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'AGUM',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 9),
                            Text(
                              dateText,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Color.fromRGBO(207, 226, 243, 1),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        selectedIconTheme: IconThemeData(color: Colors.grey), // Seçilen icon rengi
        unselectedIconTheme: IconThemeData(color: Colors.grey), // Seçilmeyen icon rengi
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          }
        },
      ),

      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (
            context,
            ) =>
            Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(207, 226, 243, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.45,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0, right: 25, left: 25),
                child: Column(
                  children: [
                    // Title
                    Title(
                      title: 'Titles',
                      onPressed: () {},
                      color: Colors.black,
                    ),

                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: exerciseList.length,
                        itemBuilder: (context, index) {
                          Exercises e = exerciseList[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: ExercisesCard(
                              icon: e.icon,
                              title: e.title,
                              color: e.color,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => getDetailPage(e.title),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
      ),
    );
  }

  Widget getDetailPage(String title) {
    switch (title) {
      case "Lunch":
        return RunMyApp();
      case "Events":
        return EventCreatorApp();
      case "Reservation":
        return ReservationDetailPage();
      case "Campus Map":
        return CampusMapDetailPage();
      default:
        return Container();
    }
  }
}

class ExercisesCard extends StatelessWidget {
  final Icon icon;
  final Color color;
  final String title;
  final VoidCallback onTap;

  const ExercisesCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 1),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 0.8, color: Colors.white),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: color,
              ),
              child: icon,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
class Title extends StatelessWidget {
  final String title;
  final Color? color;
  final VoidCallback onPressed;
  final double? titleFontSize;

  const Title({
    Key? key,
    required this.title,
    required this.onPressed,
    this.color = Colors.white,
    this.titleFontSize = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: color,
            fontSize: titleFontSize,
          ),
        ),
      ],
    );
  }
}
