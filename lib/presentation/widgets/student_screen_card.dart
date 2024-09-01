// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../core/utils/app_color.dart';
// import '../../core/utils/styles.dart';
// import '../students/add_student_screen.dart';
// import '../students/model/student_model.dart';
//
// class StudentScreenCard extends StatelessWidget {
//   final StudentModel student;
//
//   const StudentScreenCard(this.student, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(18.0),
//       child: Container(
//         width: Get.width,
//         decoration: BoxDecoration(boxShadow: const [
//           BoxShadow(
//             color: AppColors.shadow,
//             blurRadius: 10,
//             spreadRadius: 0.1,
//             offset: Offset(0, 10),
//           )
//         ], color: AppColors.white, borderRadius: BorderRadius.circular(10)),
//         padding:
//             const EdgeInsets.only(bottom: 25, top: 10, right: 20, left: 20),
//         child: Wrap(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       student.studentName!.toUpperCase(),
//                       overflow: TextOverflow.clip,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Container(
//                       alignment: Alignment.topRight,
//                       child: IconButton(
//                         onPressed: () {
//                           Get.toNamed(
//                             AddStudentScreen.routeName,
//                             arguments: student,
//                           );
//                         },
//                         icon: const Icon(
//                           Icons.edit,
//                           color: Colors.blue,
//                           // size: 35,
//                         ),
//                       ),
//                     ),
//                     // Obx(
//                     //   () => Container(
//                     //     alignment: Alignment.topRight,
//                     //     child: CustomerController.instance.isEditLoading.value
//                     //         ? const CircularProgressIndicator()
//                     //         : IconButton(
//                     //             onPressed: () {
//                     //               CustomerController.instance
//                     //                   .deleteCustomer(student);
//                     //             },
//                     //             icon: const Icon(
//                     //               Icons.delete,
//                     //               color: Colors.blue,
//                     //               // size: 35,
//                     //             ),
//                     //           ),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(text: ('College Name:- '), style: subtitleStyle),
//                       TextSpan(
//                           text: (student.collegeName), style: subtitleStyle2),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 7,
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(text: ('Stream:- '), style: subtitleStyle),
//                       TextSpan(text: student.stream, style: subtitleStyle2),
//                     ],
//                   ),
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(text: ('Email:- '), style: subtitleStyle),
//                       TextSpan(
//                           text: student.studentEmail, style: subtitleStyle2),
//                     ],
//                   ),
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(text: ('Mobile:- '), style: subtitleStyle),
//                       TextSpan(text: student.studentNum, style: subtitleStyle2),
//                     ],
//                   ),
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(text: ('Gender:- '), style: subtitleStyle),
//                       TextSpan(text: student.gender, style: subtitleStyle2),
//                     ],
//                   ),
//                 ),
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(text: ('Gifts:- '), style: subtitleStyle),
//                       TextSpan(text: (student.gifts), style: subtitleStyle2),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
