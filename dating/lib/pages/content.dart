import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zypeme/pages/contentquiz.dart';
import 'package:zypeme/pages/intresttt.dart';
import 'package:zypeme/pages/progress_bar.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({super.key});
  @override
  ContentPageState createState() => ContentPageState();
}

class ContentPageState extends State<ContentPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<int> selectedOptions = List.filled(8, -1);
  List<List<int>> optionCounts = List.generate(8, (_) => List.filled(15, 0));

  int get answeredCount => selectedOptions.where((index) => index != -1).length;

  late AnimationController _controller;

  int currentPage = 5;

  void _handleOptionSelected(int questionIndex, int selectedOptionIndex) {
    setState(() {
      selectedOptions[questionIndex] = selectedOptionIndex;
    });

    if (answeredCount > 7) {
      _onlne();
    }
  }

  void _onlne() {
    if (answeredCount == 8) {
      setState(() {
        currentPage = 6;
      });
    }
  }

  final List<List<String>> options = [
    ['Social Smoker', 'Smoke When Drinking', 'Smoker', 'Non Smoker'],
    ['Not for me', 'On special occasions', 'Sober', 'Socially on weekends'],
    ['Never', 'Everyday', 'Sometimes', 'Often'],
    [
      'Cat',
      'Dog',
      'Fish',
      'Hamster',
      'Birds',
      'Turtle',
      'Hate Pets',
      'Reptile',
      'Pet Free',
      'Want a pet',
      'Others',
    ],
    [
      'Whats up only',
      'Texter',
      'Caller',
      'Slow Answer',
      'Video caller',
      'Bad Texter',
    ],
    [
      'Compliments',
      'Thoughtfull gesture',
      'Presents',
      'Touch',
      'Time together',
      'Others',
    ],
    [
      'Trade School',
      'Bachelors',
      'PhD',
      'High school',
      'In College',
      'Masters',
    ],
    [
      'Taurus',
      'Capricorn',
      'Aquarius',
      'Gemini',
      'Aries',
      'Cancer',
      'Virgo',
      'Leo',
    ],
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
    )..repeat(reverse: true);
    optionCounts = List.generate(8, (_) => List.filled(15, 0));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ProgressBar(currentPage: currentPage, totalPages: 10),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(
                          top: screenH * 0.015,
                          right: screenW * 0.04,
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Skip",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: screenW * 0.038,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: screenH * 0.02,
                          bottom: screenH * 0.01,
                          left: screenW * 0.09,
                          right: screenW * 0.08,
                        ),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "What's Your daily habit\nsaying about you?",
                              style: GoogleFonts.ptSerifCaption(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenW * 0.058,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: screenH * 0.01),
                            Padding(
                              padding: EdgeInsets.only(left: screenW * 0.02),
                              child: Text(
                                "Do their habits Swipe Yours? Let's hope they shower daily. you go first",
                                style: GoogleFonts.ptSerifCaption(
                                  textStyle: TextStyle(
                                    fontSize: screenW * 0.032,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: const Color.fromARGB(255, 233, 231, 231),
                        thickness: 5,
                      ),
                      Expanded(
                        child: QuestionPage(
                          onOptionSelected: _handleOptionSelected,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: screenW * 0.08,
                          bottom: screenH * 0.04,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            if (answeredCount > 7) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuestionPage333(),
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: screenW * 0.8,
                            height: screenH * 0.07,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(388),
                              gradient:
                                  answeredCount > 7
                                      ? const LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 232, 99, 214),
                                          Color.fromARGB(255, 238, 176, 237),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )
                                      : null,
                              color:
                                  answeredCount < 8
                                      ? const Color.fromARGB(255, 244, 241, 241)
                                      : null,
                              border: Border.all(
                                color:
                                    answeredCount < 8
                                        ? const Color.fromARGB(
                                          128,
                                          237,
                                          231,
                                          237,
                                        )
                                        : Colors.transparent,
                                width: 1,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: screenW * 0.04,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "$answeredCount/8 Click to continue",
                                  style: TextStyle(
                                    fontSize: screenW * 0.042,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        answeredCount > 7
                                            ? Colors.white
                                            : const Color.fromARGB(
                                              255,
                                              188,
                                              185,
                                              185,
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
            ],
          ),
        ),
      ),
    );
  }
}
