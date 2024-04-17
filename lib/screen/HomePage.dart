import 'package:flutter/material.dart';
import 'package:walpaper/controller/Api_operation.dart';
import 'package:walpaper/models/photo_model.dart';
import 'package:walpaper/screen/detail_screen.dart';
import 'package:walpaper/widget/category.dart';
import 'package:walpaper/widget/search_bar.dart';
import 'package:walpaper/widget/upper_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<photo_model> photos = [];
  bool _isLoading = false;

  void load() async {
    setState(() {
      _isLoading = true;
    });

    List<photo_model> photo = await ApiOperation.get();
    photos.addAll(photo);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  void search_data(String query) async {
    setState(() {
      _isLoading = true;
    });

    List<photo_model> photo = await ApiOperation.search_query(query);
    photos.clear();
    photos.addAll(photo);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: upper_text(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            search_bar(onsearch: search_data),
            Category(),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(
                    height: MediaQuery.of(context).size.height * 0.71112,
                    child: GridView.builder(
                      itemCount: photos.length,
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        return photos[index].url.isEmpty
                            ? Center(child: CircularProgressIndicator())
                            : Container(
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
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
