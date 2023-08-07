// import 'package:flutter/material.dart';

// class calculateButton extends StatefulWidget {
//   @override
//   _calculateButtonState createState() => _calculateButtonState();
// }

// class _calculateButtonState extends State<calculateButton> {
//   final TextEditingController _controller = TextEditingController();
//   double _result = 0.0;

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _calculate() {
//     setState(() {
//       double input = double.tryParse(_controller.text) ?? 0.0;
//       _result = input * 3.0;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       // children: [
//       //   MyTextField(controller: _controller),
//         SizedBox(height: 20),
//         RaisedButton(
//           onPressed: _calculate,
//           child: Text('Calculate'),
//         ),
//         SizedBox(height: 20),
//         Text('Result: $_result'),
//       ],
//     );
//   }
// }
