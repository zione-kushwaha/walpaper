import 'package:flutter/material.dart';
import 'package:walpaper/screen/category_screen.dart';


class Category extends StatelessWidget {
  final List<String> categories = [
    'Nature',
    'Abstract',
    'Animals',
    'Car',
    'Food',
    'Travel',
    'Sports',
    'Machine',
    'Fashion',
    'Music',
  ];

  Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Shuffle the categories list
    categories.shuffle();

    return Container(
      height: 80,
     
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
             
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryScreen(category: categories[index]),
                ),
              );
            },
            child: Container(
             
              width: 100,
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
