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
      'assets/fontes/images/LV.jpg',
    ),
    Question(
      'Qual marca de luxo usa um logotipo de duplo "G"?',
      ['A) Gucci', 'B) Chanel', 'C) Prada', 'D) Burberry'],
      'A) Gucci',
      'assets/fontes/images/GUCCI.jpg',
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
      'assets/fontes/images/CHANEL.jpg',
    ),
    Question(
      'Qual dessas marcas de luxo foi fundada na Itália?',
      ['A) Louis Vuitton', 'B) Versace', 'C) Hermes', 'D) Cartier'],
      'B) Versace',
      'assets/fontes/images/versace-s21-031.webp',
    ),
    Question(
      'Qual é o produto mais famoso da marca Hermès?',
      ['A) Relógios', 'B) Perfumes', 'C) Bolsas Birkin', 'D) Óculos de sol'],
      'C) Bolsas Birkin',
      'assets/fontes/images/HERMES.webp',
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
      'assets/fontes/images/LOBUTAN.jpg',
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
      'assets/fontes/images/GIVENCHI.jpg',
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
      'assets/fontes/images/VERSACE-FALL-1997-COUTURE-DETAIL-154-NAOMI-CAMPBELL-CN10046939.webp',
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
          image: DecorationImage(
            image: AssetImage('assets/fontes/images/folha.jpg'),
            fit: BoxFit.cover,
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.only(right: 20.0, top: 10.0),
                          child: Text(
                            formatTime(timeLeft),
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'JustusOldstyle',
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Pergunta ${questionIndex + 1} de ${questions.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'JustusOldstyle',
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              questions[questionIndex].imagePath,
                              width: 300,
                              height: 300,
                              fit: BoxFit.cover,
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
                              color: Color.fromARGB(255, 243, 101, 179),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'JustusOldstyle',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (questionIndex < questions.length)
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: questions[questionIndex]
                          .options
                          .sublist(0, 2)
                          .map((option) {
                        return ElevatedButton(
                          onPressed: () => checkAnswer(option),
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 255, 255, 255),
                            ),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          child: Text(
                            option,
                            style: TextStyle(
                              color: Color.fromARGB(255, 243, 101, 179),
                              fontFamily: 'JustusOldstyle',
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: questions[questionIndex]
                          .options
                          .sublist(2, 4)
                          .map((option) {
                        return ElevatedButton(
                          onPressed: () => checkAnswer(option),
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 255, 255, 255),
                            ),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          child: Text(
                            option,
                            style: TextStyle(
                              color: Color.fromARGB(255, 243, 101, 179),
                              fontFamily: 'JustusOldstyle',
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
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
  final String imagePath;

  Question(this.questionText, this.options, this.correctAnswer, this.imagePath);
}
