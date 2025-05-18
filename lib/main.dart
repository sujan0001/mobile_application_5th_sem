// import 'package:flutter/material.dart';

// void main(){
//   runApp(
//     MaterialApp(
//       home:Scaffold(
//         appBar:AppBar(title:Text("This is my app bar"),
//         centerTitle:true,
//         ),
//         body:Text("Hello world"),

//       ),
//     ),
//   );
// }

// the above process were divided to different class then at different folder for seperation of concerns.


// import 'package:batch34_b/app.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(App());
// }

// import 'package:batch34_b/view/login_view.dart';
import 'package:batch34_b/view/splash_view.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    home: SplashScreenView(),
    debugShowCheckedModeBanner: false,
  ));
}
