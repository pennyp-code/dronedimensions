import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import '../models/drone_dimensions.dart';

class BladeInputs extends StatefulWidget {
  const BladeInputs({super.key});

  @override
  State<BladeInputs> createState() {
    return _BladeInputsState();
  }
}

class _BladeInputsState extends State<BladeInputs> {
  //**calculation Textbutton controllers */
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controllerbodylength = TextEditingController();
  final TextEditingController _controllerbladearmwidth =
      TextEditingController();
  final TextEditingController _controllerbodywidth = TextEditingController();
  final TextEditingController _controllerwallthickness =
      TextEditingController();

// //*input variables**//
  double _inputbladelength = 0;
  double _inputdronebodylength = 0;
  double _inputwallthickness = 0;
  double _inputarmwidth = 0;
  double _inputbodywidth = 0;

//*calculation variables*//
  double _distancebetweenbladecentres = 0.0;
  //** User does not need this dimension */
  double _distancefrombladecentretodronecenter = 0.0;
  double _opposite = 0.0;
  double _adjacent = 0.0;
  double _hypotenuse = 0.0;
  String errormessage = "enter data";
  String? _hypotenuse2;
  double radianstodegrees = (180.0 / pi);
  double _oa = 0.0;
  double _angle = 0.0;
  // double _newangle = 0.0;
  String? _angle2;
  // final String _errortext = "Enter all data";

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _calculate() {
    setState(() {
      _calculatedistancebetweenblades();
      _calculatedistancebetweenbladesanddronecenterpoint();
      _calculateanglerequired();
    });
  }

//** min distance between blades is 1/3 bladelength*/
  void _calculatedistancebetweenblades() {
    setState(() {
      _distancebetweenbladecentres = _inputbladelength * 3;
      if (kDebugMode) {
        print("inputbladelength $_inputbladelength mm");
        print(
            "The distance between blade centers: $_distancebetweenbladecentres mm");
      }
    });
  }

//** user does not need this */
  void _calculatedistancebetweenbladesanddronecenterpoint() {
    setState(() {
      _distancefrombladecentretodronecenter =
          (_inputdronebodylength / 2) + (_distancebetweenbladecentres / 2);
      if (kDebugMode) {
        print("inputdrone body lenght $_inputdronebodylength mm");
        print(
            "The distance from drone centre to blade centre: $_distancefrombladecentretodronecenter mm");
      }
    });
  }

  void _calculateOAT() {
    setState(() {
      _opposite = ((_distancebetweenbladecentres - _inputwallthickness) / 2) -
          (_inputdronebodylength / 2) -
          (_inputarmwidth / 2);
      _adjacent = (_distancebetweenbladecentres - _inputwallthickness / 2) -
          (_inputbodywidth / 2);
      _oa = (_opposite / _adjacent);

      if (kDebugMode) {
        print("arm width $_inputarmwidth mm");
        print("body width: $_inputbodywidth mm");
        print("opposite $_opposite mm");
        print("adjacent: $_adjacent mm");
      }
    });
  }

  void _calculateDroneArmLength() {
    setState(() {
      _hypotenuse = (tan(_opposite / _adjacent) * (180.0 / pi)).roundToDouble();
      _hypotenuse2 = (_hypotenuse + _inputarmwidth / 2).toStringAsFixed(2);
      // _hypotenuse2 = (_hypotenuse.toStringAsFixed(2)) +
      //     (_inputarmwidth / 2).toStringAsFixed(2);

      if (kDebugMode) {
        print("arm length $_hypotenuse2");
      }
    });
  }

  void _calculateanglerequired() {
    setState(() {
      _calculateOAT();

      _angle = (atan(_oa) * (180.0 / pi));
      if (_angle <= 0.0) {
        _angle = 0.0;
      } else {
        _angle = _angle;
      }

      // if (_angle <= 0.0){ _angle = 0.0} else{ _angle = _angle};
      _angle2 = _angle.toStringAsFixed(2);

      _calculateDroneArmLength();
      // inverseTangent * (_Opposite/Adjacent);
      // = atan (_Opposite/_Adjacent)

      // Tangent theta = (_OA);

      if (kDebugMode) {
        print("The value of o: $_opposite mm");
        print("The value of a: $_adjacent mm");
        print("The value of atan(o/a): $_angle Degrees");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //**variables to hold controller values */
    double newValue1 = 0.0;
    double newValue2 = 0.0;
    double newValue2a = 0.0;
    double newValue3 = 0.0;
    double newValue4 = 0.0;
//** variables for screen sizeing */
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Blade/ Rotor Length'),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                    width: width / 1.8,
                    child: TextField(
                        controller: _controller,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(
                          fillColor: Colors.black,
                          hintText: 'Enter Blade Length (mm)',
                        ),
                        // onChanged: _inputLengthx,
                        onChanged: (value) {
                          setState(() {
                            newValue1 = double.parse(value);
                            _inputbladelength = newValue1;
                          });
                        }
                        // _calculatedistancebetweenblades();
                        ),
                  ),
                ],
              ),
              // ElevatedButton(
              //   onPressed: _calculatedistancebetweenblades,
              //   child:
              //       const Text('Calculate Min Distance Between Blade Centres'),
              // ),
              // Text(
              //     '$_inputbladelength: min distance between rotor blade center points: $_distancebetweenbladecentres'),
              //*****calculate distance between blade/rotor center point and drone body center point.
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Body Length'),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                    width: width / 1.8,
                    child: TextField(
                        controller: _controllerbodylength,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(
                          fillColor: Colors.black,
                          hintText: 'Enter Drone Body Length(mm)',
                        ),
                        onChanged: (value) {
                          setState(() {
                            newValue2 = double.parse(value);
                            _inputdronebodylength = newValue2;
                          });
                        }),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                    width: width / 1.8,
                    child: TextField(
                        controller: _controllerwallthickness,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(
                          fillColor: Colors.black,
                          hintText: 'Enter WallThickness',
                        ),
                        onChanged: (value) {
                          setState(() {
                            newValue2a = double.parse(value);
                            _inputwallthickness = newValue2a;
                          });
                        }),
                  ),
                ],
              ),
              // ElevatedButton(
              // //   onPressed: _calculatedistancebetweenbladesanddronecenterpoint,
              // //   child: const Text(
              // //       'Calculate distance between drone center and blade centre point'),
              // // ),
              // Text(
              //     '$_inputdronebodylength distance from drone center to blade center: $_distancefrombladecentretodronecenter'),
              //** Input Blade Arm Width */
              const Text('Blade Arm Width'),
              SizedBox(
                height: 50,
                width: width / 1.8,
                child: TextField(
                  controller: _controllerbladearmwidth,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    hintText: 'Enter Drone Arm Width (mm)',
                  ),
                  onChanged: (value) {
                    setState(() {
                      newValue3 = double.parse(value);
                      _inputarmwidth = newValue3;
                    });
                  },
                ),
              ),
              // ElevatedButton(
              //   onPressed: _calculatedistancebetweenbladesanddronecenterpoint,
              //   child: const Text('Calculate'),
              // ),
//** Input Drone Body Width - Calculate Angle of Arm and length of arm (- width arm / 2)  */
              const Text('Body Width'),
              SizedBox(
                height: 50,
                width: width / 1.8,
                child: TextField(
                  controller: _controllerbodywidth,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    hintText: 'Enter Drone Body Length (mm)',
                  ),
                  onChanged: (value) {
                    setState(() {
                      newValue4 = double.parse(value);
                      _inputbodywidth = newValue4;
                    });
                  },
                ),
              ),

              ElevatedButton(
                  onPressed: _calculate,
                  child: const Text('Calculate Drone Dimensions and Angle')),

              // ElevatedButton(
              //   onPressed: _calculatedistancebetweenblades,
              //   child:
              //       const Text('Calculate Min Distance Between Blade Centres'),
              // ),
              Text(
                  '$_inputbladelength: min distance between rotor blade center points: $_distancebetweenbladecentres'),
              // ElevatedButton(
              //   onPressed: _calculatedistancebetweenbladesanddronecenterpoint,
              //   child: const Text(
              //       'Calculate distance between drone center and blade centre point'),
              // ),
              Text(
                  '$_inputdronebodylength distance from drone center to blade center: $_distancefrombladecentretodronecenter'),
              Text('$_inputwallthickness (mm) wall thickness'),
              // ElevatedButton(
              //   onPressed: _calculateanglerequired,
              //   child: const Text('anglerequired'),
              // ),
              //  )),
              Text(
                  'arm width = $_inputarmwidth mm, \n body with = $_inputbodywidth, \n angle of arm $_angle2 Degree \n length of arm $_hypotenuse2 mm'),
              // )

              // ElevatedButton(
              //   onPressed: _calculateanglerequired,
              //   child: const Text('Calculate'),
              // ),
              // //  )),
              // Text('$_inputarmwidth required arm angle: $_angle Degrees'),
              // // )
            ],
          ),
        ),
      ),
    );
  }
}
