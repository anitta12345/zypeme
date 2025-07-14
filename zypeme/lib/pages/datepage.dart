import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:zypeme/pages/gender.dart';
import 'package:zypeme/pages/progress_bar.dart';

class DatePage1 extends StatefulWidget {
  const DatePage1({super.key});
  @override
  DatePage1State createState() => DatePage1State();
}

class DatePage1State extends State<DatePage1>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double _imageOffsetX = 0.0;
  int currentPage = 1;

  DateTime _secondSelectedDate = DateTime(2007, 1, 1);
  DateTime _minDate = DateTime(1980, 1, 1);
  DateTime _maxDate = DateTime(2025, 12, 31);
  DateTime _validMaxDate = DateTime(2007, 12, 31);
  String? _errorMessage;

  int _calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  void _validateDate(DateTime value) {
    setState(() {
      if (value.isBefore(_minDate) || value.isAfter(_validMaxDate)) {
        _errorMessage =
            "Please select a date between \${_minDate.year} and \${_validMaxDate.year}";
      } else {
        _errorMessage = null;
        _secondSelectedDate = value;
      }
    });
  }

  bool isChecked = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    currentPage = 2;
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: w,
          height: h,
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: ProgressBar(
                          currentPage: currentPage,
                          totalPages: 10,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          w * 0.09,
                          h * 0.13,
                          w * 0.13,
                          h * 0.01,
                        ),
                        width: double.infinity,
                        child: Text(
                          "Date of ARRIVAL \non Earth?",
                          style: GoogleFonts.ptSerifCaption(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: w * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: w * 0.05),
                        width: w * 0.9,
                        height: h * 0.13,
                        child: ScrollDatePicker(
                          scrollViewOptions: DatePickerScrollViewOptions(),
                          maximumDate: _maxDate,
                          minimumDate: _minDate,
                          selectedDate: _secondSelectedDate,
                          locale: Locale('en'),
                          onDateTimeChanged: _validateDate,
                        ),
                      ),
                      if (_errorMessage != null)
                        Padding(
                          padding: EdgeInsets.only(
                            top: h * 0.01,
                            left: w * 0.05,
                          ),
                          child: Text(
                            _errorMessage!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: w * 0.03,
                            ),
                          ),
                        ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          w * 0.045,
                          0,
                          w * 0.1,
                          h * 0.08,
                        ),
                        width: double.infinity,
                        child: CheckboxListTile(
                          title: Text(
                            "Dont show your age on your profile",
                            style: TextStyle(
                              fontSize: w * 0.035,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: isChecked,
                          onChanged: (bool? newValue) {
                            setState(() {
                              isChecked = newValue!;
                            });
                          },
                          activeColor: Color.fromARGB(255, 178, 25, 137),
                          checkColor: Colors.white,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: h * 0.1),
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          child:
                              _errorMessage == null
                                  ? _buildValidSwipeButton(w, h)
                                  : _buildInvalidSwipeButton(w, h),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValidSwipeButton(double w, double h) {
    return Container(
      width: w * 0.8,
      height: h * 0.075,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(388),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 232, 99, 214),
            Color.fromARGB(255, 238, 176, 237),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.01),
      child: Row(
        children: [
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                _imageOffsetX += details.primaryDelta!;
              });
            },
            onHorizontalDragEnd: (details) {
              if (_imageOffsetX > w * 0.4) {
                int age = _calculateAge(_secondSelectedDate);
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 30,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "You’r $age",
                              style: TextStyle(
                                fontSize: w * 0.06,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: h * 0.015),
                            Text(
                              "Make sure date of birth you Enter is correct",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: w * 0.035,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: h * 0.035),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Confirm Button
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Close dialog
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const GenderPage1(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(
                                      255,
                                      207,
                                      132,
                                      206,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: w * 0.08,
                                      vertical: h * 0.015,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                  child: Text(
                                    "Confirm",
                                    style: TextStyle(
                                      fontSize: w * 0.04,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                // Cancel Button
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Just close dialog
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const DatePage1(),
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: Color.fromARGB(255, 157, 155, 157),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: w * 0.08,
                                      vertical: h * 0.015,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      fontSize: w * 0.04,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                setState(() {
                  _imageOffsetX = 0.0;
                });
              }
            },

            child: Transform.translate(
              offset: Offset(_imageOffsetX, 0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  FadeTransition(
                    opacity: _controller,
                    child: Image.network(
                      "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/4f13f915-b4a9-41b1-8ff1-8f257803adae",
                      width: w * 0.13,
                      height: w * 0.13,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: w * 0.13,
                    color: Color.fromARGB(255, 141, 3, 120),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: w * 0.04),
          Text(
            "Swipe to Continue",
            style: TextStyle(
              fontSize: w * 0.045,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvalidSwipeButton(double w, double h) {
    return Container(
      width: w * 0.8,
      height: h * 0.075,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 244, 241, 241),
        borderRadius: BorderRadius.circular(388),
        border: Border.all(color: Color.fromARGB(128, 237, 231, 237), width: 1),
      ),
      padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.01),
      child: Row(
        children: [
          Stack(
            children: [
              Image.network(
                "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/9236cc21-1a33-4f90-9d51-c57046764bf6",
                width: w * 0.13,
                height: w * 0.13,
                fit: BoxFit.fill,
              ),
              Positioned(
                left: w * 0.035,
                top: w * 0.025,
                child: Icon(
                  Icons.chevron_right,
                  size: w * 0.08,
                  color: Color.fromARGB(255, 151, 149, 149),
                ),
              ),
            ],
          ),
          SizedBox(width: w * 0.04),
          Expanded(
            child: Text(
              "Swipe to continue",
              style: TextStyle(
                fontSize: w * 0.038,
                color: Color.fromARGB(255, 188, 185, 185),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
