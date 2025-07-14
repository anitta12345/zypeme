import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zypeme/pages/gallery.dart';
import 'package:zypeme/pages/progress_bar.dart';

class QuestionPage333 extends StatefulWidget {
  @override
  _QuestionPage333State createState() => _QuestionPage333State();
}

class _QuestionPage333State extends State<QuestionPage333>
    with SingleTickerProviderStateMixin {
  bool showMore = false;

  int currentPage = 6;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'creative fun ',
      'options': [
        'Frelancing',
        'Photography',
        'Sneakers',
        'Cosplay',
        'Poetry',
        'Design',
        'Sports',
        'Writing',
        'Dance',
        'Reading',
        'Drawing',
      ],
      'image': 'assets/images/1.1.jpg',
    },
    {
      'question': 'Adventure',
      'options': [
        'Road Trips',
        'Mountain Biking',
        'Forest Bathing',
        'Freediving',
        'Nature Photography Trips',
        'Ziplining',
        'Horseback Riding',
        'Skydiving',
        'Scuba Diving',
        'Hiking / Trekking',
        'Sailing',
        'Off-roading / Overlanding',
      ],
      'image': 'assets/images/1.2.jpg',
    },
    {
      'question': 'fan favourite',
      'options': [
        'Marvel',
        'DC',
        'Billie Eilish',
        'Anime',
        'The weekend',
        'Game of thrones',
        'Strange things',
        'Tylor swift',
        'GTA',
        'E-football',
        'From',
        'Fortnite',
        'Barbie',
        'Dark',
        'Play Station',
        'Ludo',
        'COD',
        'Interstellar',
        'K-drama',
      ],
      'image': 'assets/images/1.3.jpg',
    },
    {
      'question': 'Food and drink ',
      'options': [
        'Biriyani',
        'Hot & Cheesy',
        'Maggi ',
        'Momo',
        'Burger',
        'Snack Attack',
        'Fries',
        'Pizza',
        'Mocktails',
        'Masala Mood',
        'Drinks & Giggles',
      ],
      'image': 'assets/images/1.4.jpg',
    },
    {
      'question': 'Social & content ',
      'options': [
        'Instagram',
        'Facebook',
        'Snapchat',
        'Twitch',
        'X',
        'Reddit',
        'TikTok',
      ],
      'image': 'assets/images/1.5.jpg',
    },
    {
      'question': 'Music vibe ',
      'options': [
        'Jazz',
        'Rock music',
        'Mj',
        'Classical',
        'K-pop',
        'MaHip-Hop / Rapggi',
        'K-pop',
        'Gospel music',
        'Music Conserts ',
        'Divin music',
      ],
      'image': 'assets/images/1.6.jpg',
    },
    {
      'question': 'TV & movies',
      'options': [
        'Horror',
        'Action',
        'Drama',
        'Comedy',
        'Mistery/investigation',
        'Animated /family',
        'Romance',
        'Sci-fi/fantasy',
        'Thriller/crime',
      ],
      'image': 'assets/images/1.7.jpg',
    },
    {
      'question': 'Values & causes',
      'options': [
        'LGBTQ+ ',
        'Suicide Prevention',
        'Body Positivity',
        'Child safety',
        'Sex  Education',
        'Awareness',
        'Renewable Energy Advocacy',
        'Gender Equality',
        'Water saving',
        'Youth power',
        'Freedom Rights',
        'Anti-Human Trafficking',
      ],
      'image': 'assets/images/1.8.jpg',
    },
    {
      'question': 'Fitness and healing',
      'options': [
        'Fitness',
        'Self-Care Routines',
        'Sleep Hygiene',
        'Yoga Healing',
        'Mental  Awareness',
        'Eco-Style',
        'Inner peace',
        'Healthy Eating',
      ],
      'image': 'assets/images/1.9.jpg',
    },
    {
      'question': 'Sports and games',
      'options': [
        'Cricket',
        'Cards',
        'Darts',
        'Football',
        'Hockey',
        'Golf',
        'Snakes and Ladders',
        'Ludo',
        'Video Games',
        'Kick-Boxing',
        'Rugby',
        'Jenga',
        'Tennis',
        'Skating',
        'Uno',
        'Cycling',
        'Table Tennis',
        'Billiards / Pool',
        'Volleyball',
        'Pool',
        'Race',
        'Basketball',
        'Strike and Pocket',
        'Tag Wrestling',
        'Badminton',
        'Baseball',
        'Running',
      ],
      'image': 'assets/images/1.10.jpg',
    },
  ];

  late List<Set<String>> selectedOptions; // Allow multiple selections

  double _imageOffsetX = 0.0;
  late AnimationController _controller;

  void selectOption(int questionIndex, String option) {
    setState(() {
      if (selectedOptions[questionIndex].contains(option)) {
        selectedOptions[questionIndex].remove(option); // deselect
      } else {
        selectedOptions[questionIndex].add(option); // select
      }
    });
    if (totalSelectedCount >= 10) {
      _onlne();
    }
  }

  void _onlne() {
    if (totalSelectedCount == 10) {
      setState(() {
        currentPage = 7;
      });
    }
  }

  int get totalSelectedCount =>
      selectedOptions.fold(0, (sum, set) => sum + set.length);

  @override
  void initState() {
    super.initState();
    selectedOptions = List.generate(questions.length, (_) => <String>{});
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..forward();
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Skip",
                  style: TextStyle(
                    fontSize: screenW * 0.038,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: ProgressBar(currentPage: currentPage, totalPages: 10),
            ),
            SizedBox(height: screenH * 0.02),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: screenW * 0.08,
                vertical: screenH * 0.03,
              ),
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    "Mention Your Interests?",
                    style: GoogleFonts.ptSerifCaption(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: screenW * 0.055,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: screenH * 0.01),
                ],
              ),
            ),
            Divider(color: const Color(0xFFE9E7E7), thickness: 5),

            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: screenH * 0.02),
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: screenW * 0.04,
                      vertical: screenH * 0.01,
                    ),
                    padding: EdgeInsets.all(screenW * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                question['image'],
                                height: screenW * 0.1,
                                width: screenW * 0.1,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: screenW * 0.025),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: screenH * 0.01),
                                child: Text(
                                  question['question'],
                                  style: TextStyle(
                                    fontSize: screenW * 0.045,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenH * 0.015),
                        Wrap(
                          spacing: screenW * 0.01,
                          runSpacing: screenH * 0.015,
                          children:
                              (question['options'] as List<String>)
                                  .asMap()
                                  .entries
                                  .where((entry) => showMore || entry.key < 5)
                                  .map((entry) {
                                    final option = entry.value;
                                    bool isSelected = selectedOptions[index]
                                        .contains(option);

                                    return GestureDetector(
                                      onTap: () => selectOption(index, option),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: screenW * 0.01,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: screenW * 0.04,
                                          vertical: screenH * 0.015,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              isSelected
                                                  ? Color(0xFFFBBBF8)
                                                  : Colors.white,
                                          border: Border.all(
                                            color:
                                                isSelected
                                                    ? Color(0xFFF321C9)
                                                    : Color(0xFFEB69D7),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            19,
                                          ),
                                        ),
                                        child: Text(
                                          option,
                                          style: TextStyle(
                                            fontSize: screenW * 0.035,
                                            color:
                                                isSelected
                                                    ? Colors.white
                                                    : Color(0xFFEB69D7),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                                  .toList(),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {
                              setState(() => showMore = !showMore);
                            },
                            child: Container(
                              padding: EdgeInsets.all(screenW * 0.02),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 249, 247, 247),
                              ),
                              child: Text(
                                showMore ? 'Show Less' : 'Show More>',
                                style: TextStyle(
                                  fontSize: screenW * 0.03,
                                  color: const Color.fromARGB(
                                    255,
                                    212,
                                    10,
                                    189,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            GestureDetector(
              onTap: () {
                if (totalSelectedCount == 10) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Add()),
                  );
                }
              },
              child: Container(
                width: screenW * 0.8,
                height: screenH * 0.07,
                margin: EdgeInsets.only(bottom: screenH * 0.02),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(388),
                  gradient:
                      totalSelectedCount >= 10
                          ? LinearGradient(
                            colors: [Color(0xFFE863D6), Color(0xFFEEB0ED)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                          : null,
                  color: totalSelectedCount < 10 ? Color(0xFFF4F1F1) : null,
                  border: Border.all(
                    color:
                        totalSelectedCount < 10
                            ? Color.fromARGB(128, 237, 231, 237)
                            : Colors.transparent,
                    width: 1,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: screenW * 0.04),
                child: Center(
                  child: Text(
                    "$totalSelectedCount/10 Click to continue",
                    style: TextStyle(
                      fontSize: screenW * 0.04,
                      fontWeight: FontWeight.bold,
                      color:
                          totalSelectedCount >= 10
                              ? Colors.white
                              : Color.fromARGB(255, 188, 185, 185),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
