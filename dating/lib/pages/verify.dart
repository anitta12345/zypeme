// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:zypeme/connect.dart';

// class VerifyPage extends StatefulWidget {
//   const VerifyPage({super.key});
//   @override
//   VerifyPageState createState() => VerifyPageState();
// }

// class VerifyPageState extends State<VerifyPage> {
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           width: screenWidth,
//           height: screenHeight,
//           color: Colors.white,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Container(
//                   width: screenWidth,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: screenHeight * 0.18), // replaces 140
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(32),
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.25),
//                               blurRadius: 13,
//                               offset: Offset(6, 6),
//                             ),
//                           ],
//                         ),
//                         padding: EdgeInsets.symmetric(
//                           vertical: screenHeight * 0.03,
//                         ),
//                         margin: EdgeInsets.symmetric(
//                           horizontal: screenWidth * 0.1,
//                           vertical: screenHeight * 0.1,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                     top: screenHeight * 0.006,
//                                     left: screenWidth * 0.013,
//                                   ),
//                                   child: FaIcon(
//                                     FontAwesomeIcons.solidCircleCheck,
//                                   ),
//                                 ),
//                                 SizedBox(width: screenWidth * 0.05),
//                                 Text(
//                                   "You’re In",
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: screenWidth * 0.1,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: screenHeight * 0.05),
//                             Container(
//                               margin: EdgeInsets.all(
//                                 screenWidth * 0.04,
//                               ), // replaces 15
//                               child: Text(
//                                 "You are verified and your account is all set",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: screenWidth * 0.05,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                             SizedBox(height: screenHeight * 0.05),
//                             InkWell(
//                               onTap: () {
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => LetsConnect(),
//                                   ),
//                                 );
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(25),
//                                   gradient: LinearGradient(
//                                     begin: Alignment(-1, 1),
//                                     end: Alignment(1, 1),
//                                     colors: [
//                                       const Color.fromARGB(255, 225, 185, 213),
//                                       Color.fromRGBO(230, 102, 200, 1),
//                                     ],
//                                   ),
//                                 ),
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: screenWidth * 0.2,
//                                   vertical: screenHeight * 0.02,
//                                 ),
//                                 child: Text(
//                                   "OK",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: screenWidth * 0.05,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
