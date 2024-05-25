import 'package:flutter/material.dart';

class TelaResultado extends StatelessWidget {
  final int score;
  final int totalPerguntas;
  final VoidCallback resetQuiz;

  TelaResultado({
    required this.score,
    required this.totalPerguntas,
    required this.resetQuiz,
  });

  @override
  Widget build(BuildContext context) {
    String mensagem =
        score >= (totalPerguntas / 2) ? 'Parabéns!' : 'Tente novamente';

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/fontes/images/the book model (2).jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    mensagem,
                    style: TextStyle(
                      fontSize: 40,
                      color: Color.fromARGB(255, 230, 99, 160),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'JustusOldstyle',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Pontuação: $score / $totalPerguntas',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 230, 99, 160),
                      fontFamily: 'JustusOldstyle',
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      resetQuiz();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 230, 99, 160),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    ),
                    child: Text(
                      "Recomeçar",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'JustusOldstyle',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back,
                        color: Color.fromARGB(255, 230, 99, 160)),
                    SizedBox(width: 10),
                    Text(
                      'Resultado',
                      style: TextStyle(
                        color: Color.fromARGB(255, 230, 99, 160),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
