import 'package:flutter/material.dart';
import 'dart:async';
import 'tela_resultado.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int questionIndex = 0;
  int score = 0;
  Timer? timer;
  int timeLeft = 15;

  List<Question> questions = [
    Question(
      'Qual é o logotipo da Louis Vuitton?',
      [
        'A) Uma flor de lírio',
        'B) Uma coroa',
        'C) Um monograma "LV"',
        'D) Uma águia'
      ],
      'C) Um monograma "LV"',
    ),
    Question(
      'Qual marca de luxo usa um logotipo de duplo "G"?',
      ['A) Gucci', 'B) Chanel', 'C) Prada', 'D) Burberry'],
      'A) Gucci',
    ),
    Question(
      'Quem fundou a marca de luxo Chanel?',
      [
        'A) Coco Chanel',
        'B) Giorgio Armani',
        'C) Ralph Lauren',
        'D) Christian Dior'
      ],
      'A) Coco Chanel',
    ),
    Question(
      'Qual dessas marcas de luxo foi fundada na Itália?',
      ['A) Louis Vuitton', 'B) Versace', 'C) Hermes', 'D) Cartier'],
      'B) Versace',
    ),
    Question(
      'Qual é o produto mais famoso da marca Hermès?',
      ['A) Relógios', 'B) Perfumes', 'C) Bolsas Birkin', 'D) Óculos de sol'],
      'C) Bolsas Birkin',
    ),
    Question(
      'Qual dessas marcas é mais conhecida por seus sapatos vermelhos de sola?',
      [
        'A) Jimmy Choo',
        'B) Manolo Blahnik',
        'C) Christian Louboutin',
        'D) Salvatore Ferragamo'
      ],
      'C) Christian Louboutin',
    ),
    Question(
      'Qual dessas marcas é mais conhecida por sua alta-costura?',
      [
        'A) Givenchy',
        'B) Yves Saint Laurent',
        'C) Fendi',
        'D) Dolce & Gabbana'
      ],
      'A) Givenchy',
    ),
    Question(
      'Qual é o nome da linha de alta-costura da marca italiana Versace?',
      [
        'A) Versace Couture',
        'B) Versace Collection',
        'C) Versace Versus',
        'D) Versace Atelier'
      ],
      'A) Versace Couture',
    ),
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer?.cancel();
    setState(() {
      timeLeft = 15;
    });
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          timer.cancel();
          nextQuestion();
        }
      });
    });
  }

  void checkAnswer(String selectedOption) {
    String correctAnswer = questions[questionIndex].correctAnswer;
    setState(() {
      if (selectedOption == correctAnswer) {
        score++;
      }
    });
    nextQuestion();
  }

  void nextQuestion() {
    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
      });
      startTimer();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TelaResultado(
            score: score,
            totalPerguntas: questions.length,
            resetQuiz: resetQuiz,
          ),
        ),
      );
    }
  }

  void resetQuiz() {
    setState(() {
      questionIndex = 0;
      score = 0;
    });
    startTimer();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 231, 210, 89),
              Color.fromARGB(255, 228, 98, 233),
              Color.fromARGB(255, 14, 84, 141),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 10.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            if (questionIndex < questions.length)
              Expanded(
                flex: 5,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            formatTime(timeLeft),
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pointy',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.symmetric(horizontal: 24.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          questions[questionIndex].questionText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Color.fromARGB(255, 150, 21, 150),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'JustusOldstyle',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (questionIndex < questions.length)
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: questions[questionIndex]
                          .options
                          .sublist(0, 2)
                          .asMap()
                          .entries
                          .map((entry) {
                        int idx = entry.key;
                        String option = entry.value;
                        return ElevatedButton(
                          onPressed: () => checkAnswer(option),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              idx == 0
                                  ? const Color.fromARGB(255, 199, 121, 212)
                                  : const Color.fromARGB(255, 148, 87, 165),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          child: Text(
                            option,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'JustusOldstyle',
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: questions[questionIndex]
                          .options
                          .sublist(2, 4)
                          .asMap()
                          .entries
                          .map((entry) {
                        int idx = entry.key;
                        String option = entry.value;
                        return ElevatedButton(
                          onPressed: () => checkAnswer(option),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              idx == 0
                                  ? const Color.fromARGB(255, 117, 65, 182)
                                  : const Color.fromARGB(255, 147, 103, 167),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          child: Text(
                            option,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'JustusOldstyle',
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            if (questionIndex >= questions.length)
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TelaResultado(
                            score: score,
                            totalPerguntas: questions.length,
                            resetQuiz: resetQuiz,
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    child: Text(
                      'VEJA O RESULTADO',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'JustusOldstyle',
                        color: Colors.white,
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

class Question {
  final String questionText;
  final List<String> options;
  final String correctAnswer;

  Question(this.questionText, this.options, this.correctAnswer);
}
