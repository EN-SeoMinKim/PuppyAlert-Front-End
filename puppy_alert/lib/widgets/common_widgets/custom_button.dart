// import 'package:flutter/material.dart';
//
// class CustomButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   final String text;
//   final double? width;
//   final double? height;
//   final EdgeInsetsGeometry? margin;
//   final Color borderColor;
//   final Color textColor;
//   final Color backgroundColor;
//
//   CustomButton({
//     super.key,
//     required this.onPressed,
//     required this.text,
//     this.width,
//     this.height,
//     this.margin,
//     required this.borderColor ,
//     required this.textColor ,
//     required this.backgroundColor ,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: margin,
//       width: width,
//       height: height,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: backgroundColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             side: BorderSide(color: borderColor),
//           ),
//         ),
//         onPressed: onPressed,
//         child: Text(
//           text,
//           style: TextStyle(
//             color: textColor,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Widget whiteButton(){
//   return CustomButton(
//       onPressed: () {},
//       text: TextInputType.text,
//       borderColor: borderColor,
//       textColor: textColor, backgroundColor: backgroundColor)
// }