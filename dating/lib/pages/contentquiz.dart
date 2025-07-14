import 'package:flutter/material.dart';

class QuestionPage extends StatefulWidget {
  final Function(int, int) onOptionSelected;

  const QuestionPage({super.key, required this.onOptionSelected});

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final List<String> questions = [
    'Cigarettes, incense, or just vibes ?',
    'Drink drink, or ‘just one glass’ that turns into five?',
    'How do you flex — in the gym or in life?',
    'Do you have any pets ?',
    'Mention your communication skills ?',
    'How do you receive love',
    'Your education level ?',
    'Your zodiac sign ?',
  ];

  final List<IconData> questionIcons = [
    Icons.smoking_rooms,
    Icons.liquor,
    Icons.fitness_center,
    Icons.pets,
    Icons.message,
    Icons.favorite,
    Icons.school,
    Icons.star,
  ];

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

  late List<int> selectedIndex;
  late List<List<int>> counts;

  @override
  void initState() {
    super.initState();
    selectedIndex = List.generate(questions.length, (_) => -1);
    counts = List.generate(questions.length, (_) => List.filled(15, 0));
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, questionIndex) {
          return Padding(
            padding: EdgeInsets.only(
              left: screenW * 0.06,
              right: screenW * 0.04,
              top: screenH * 0.015,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      questionIcons[questionIndex],
                      color: Colors.black,
                      size: screenW * 0.055,
                    ),
                    SizedBox(width: screenW * 0.02),
                    Expanded(
                      child: Text(
                        questions[questionIndex],
                        style: TextStyle(
                          fontSize: screenW * 0.045,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenH * 0.015),
                Wrap(
                  spacing: screenW * 0.03,
                  runSpacing: screenH * 0.01,
                  children: List.generate(options[questionIndex].length, (
                    optionIndex,
                  ) {
                    final isSelected =
                        selectedIndex[questionIndex] == optionIndex;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (!isSelected) {
                            counts[questionIndex][optionIndex]++;
                            selectedIndex[questionIndex] = optionIndex;
                            widget.onOptionSelected(questionIndex, optionIndex);
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: screenH * 0.012,
                          horizontal: screenW * 0.04,
                        ),
                        margin: EdgeInsets.only(bottom: screenH * 0.005),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                isSelected
                                    ? const Color.fromARGB(255, 232, 131, 198)
                                    : const Color.fromARGB(255, 219, 68, 168),
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color:
                              isSelected
                                  ? const Color.fromARGB(255, 236, 181, 216)
                                  : Colors.white,
                        ),
                        child: Text(
                          options[questionIndex][optionIndex],
                          style: TextStyle(
                            fontSize: screenW * 0.038,
                            color:
                                isSelected
                                    ? Colors.white
                                    : const Color.fromARGB(255, 201, 50, 163),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: screenH * 0.02),
              ],
            ),
          );
        },
      ),
    );
  }
}
