import 'package:flutter/material.dart';

class upper_text extends StatelessWidget {
  const upper_text({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(text: TextSpan(text: 'Walpaper  ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),
    children: [
      TextSpan(text: 'World!',style: TextStyle(fontStyle: FontStyle.italic,color: Colors.blue))
    ]));
  }
}