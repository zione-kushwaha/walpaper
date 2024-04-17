import 'package:flutter/material.dart';

class search_bar extends StatelessWidget {
  final Function(String) onsearch;
  const search_bar({super.key, required this.onsearch});
 

  @override
  Widget build(BuildContext context) {
     TextEditingController text_controller=TextEditingController();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children:[ Expanded(
          child: TextField(
            controller: text_controller,
            decoration: InputDecoration(
              border: InputBorder.none,
                hintText: 'Search Any Walpaper'
              
            ),
          ),
        ),
        IconButton(onPressed: (){
            onsearch(text_controller.text);
        }, icon: Icon(Icons.search))
        ]
      ),
      decoration: BoxDecoration(
        border: Border.all(),
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15)
      ),
    );
  }
}