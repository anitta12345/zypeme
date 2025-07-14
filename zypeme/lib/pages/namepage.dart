import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:zypeme/pages/datepage.dart';
import 'package:zypeme/pages/progress_bar.dart';

class NamePage1 extends StatefulWidget {
  final String email;
  final String phone;
  const NamePage1({required this.email, required this.phone, super.key});
  @override
  NamePage1State createState() => NamePage1State();
}

class NamePage1State extends State<NamePage1>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int currentPage = 0;

  String textField1 = '';
  TextEditingController _name = TextEditingController();
  bool _isValid = false;
  double _imageOffsetX = 0.0;

  void _validateTextField() {
    setState(() {
      _isValid = _formKey.currentState!.validate();
    });
  }

  late AnimationController _controller;

  Future<void> sendAllDataToApi(String phone, String email, String name) async {
    final url = Uri.parse(
      'https://your-domain.com/api/submit',
    ); // 🔁 Replace with your API URL

    try {
      final response = await http.post(
        url,
        body: {'phone': phone, 'email': email, 'name': name},
      );

      if (response.statusCode == 200) {
        print('✅ Data submitted successfully');
        // Optionally, parse response.body if needed
      } else {
        print('❌ Failed to submit data. Status: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('🚨 Error submitting data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
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
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
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
                          margin: EdgeInsets.only(
                            top: h * 0.13,
                            bottom: h * 0.035,
                            left: w * 0.09,
                            right: w * 0.13,
                          ),
                          width: double.infinity,
                          child: Text(
                            "What’s the NAME\nbehind that smile?",
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
                          margin: EdgeInsets.only(bottom: h * 0.02),
                          alignment: Alignment.center,
                          child: Container(
                            width: w * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFF6F1F1),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: h * 0.015,
                              horizontal: w * 0.05,
                            ),
                            child: TextFormField(
                              controller: _name,
                              style: TextStyle(
                                color: Color(0xFF806F6F),
                                fontSize: w * 0.04,
                              ),
                              onChanged: (value) {
                                final isValid =
                                    _formKey.currentState?.validate() ?? false;

                                setState(() {
                                  textField1 = value;
                                  _isValid = isValid;
                                  currentPage =
                                      isValid
                                          ? 1
                                          : 0; // ✅ change progress if valid only
                                });
                              },

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Name cannot be empty";
                                } else if (value.length < 3) {
                                  return "Name must be at least 3 letters long";
                                } else if (!RegExp(
                                  r"^[a-zA-Z]+$",
                                ).hasMatch(value)) {
                                  return "Only letters are allowed";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Name",
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: w * 0.1,
                            right: w * 0.09,
                          ),

                          child: Text(
                            "Name on your profile . Can Change after\n6 month",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: w * 0.035,
                            ),
                          ),
                        ),
                        SizedBox(height: h * 0.1),
                        Container(
                          margin: EdgeInsets.only(bottom: h * 0.05),
                          alignment: Alignment.center,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            child:
                                _isValid
                                    ? Container(
                                      width: w * 0.8,
                                      height: h * 0.075,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          388,
                                        ),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 232, 99, 214),
                                            Color.fromARGB(255, 238, 176, 237),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: w * 0.03,
                                        vertical: h * 0.01,
                                      ),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onHorizontalDragUpdate: (details) {
                                              setState(() {
                                                _imageOffsetX +=
                                                    details.primaryDelta!;
                                              });
                                            },
                                            onHorizontalDragEnd: (
                                              details,
                                            ) async {
                                              if (_imageOffsetX > w * 0.4) {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            DatePage1(),
                                                  ),
                                                );
                                                await sendAllDataToApi(
                                                  widget.phone,
                                                  widget.email,
                                                  _name.text,
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
                                                    color: Color.fromARGB(
                                                      255,
                                                      141,
                                                      3,
                                                      120,
                                                    ),
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
                                    )
                                    : Container(
                                      width: w * 0.8,
                                      height: h * 0.075,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(
                                          255,
                                          244,
                                          241,
                                          241,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          388,
                                        ),
                                        border: Border.all(
                                          color: Color.fromARGB(
                                            128,
                                            237,
                                            231,
                                            237,
                                          ),
                                          width: 1,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: w * 0.03,
                                        vertical: h * 0.01,
                                      ),
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
                                                left: w * 0.025,
                                                top: w * 0.015,
                                                child: Icon(
                                                  Icons.chevron_right,
                                                  size: w * 0.08,
                                                  color: Color.fromARGB(
                                                    255,
                                                    151,
                                                    149,
                                                    149,
                                                  ),
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
                                                color: Color.fromARGB(
                                                  255,
                                                  188,
                                                  185,
                                                  185,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
