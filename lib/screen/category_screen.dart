import 'package:flutter/material.dart';
import 'package:walpaper/models/photo_model.dart';
import 'package:walpaper/screen/detail_screen.dart';

import '../controller/Api_operation.dart';

class CategoryScreen extends StatefulWidget {
  final String category;

  CategoryScreen({required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<photo_model> photos = [];
  bool isLoading = true;

  void search_data() async {
    setState(() {
      isLoading = true;
    });

    List<photo_model> photo = await ApiOperation.search_query(widget.category);
    photos.clear();
    photos.addAll(photo);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    search_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: Colors.red,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(5),
              child: GridView.builder(
                itemCount: photos.length,
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemBuilder: ((context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                imageUrl: photos[index].url,
                                photographer: photos[index].photgrapher,
                                description: photos[index].description,
                              ),
                            ),
                          );
                        },
                        child: Image.network(
                          photos[index].url,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  );
                }),
              ),
            ),
    );
  }
}
