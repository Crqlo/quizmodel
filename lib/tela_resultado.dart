import 'package:flutter/material.dart';

class TelaResultado extends StatelessWidget {
  final int score;
  final int totalPerguntas;
  final Function resetQuiz;

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
      appBar: null,
      body: Stack(
        children: [
          Image.asset(
            'assets/fontes/images/vogue-brasil-setembro-2020-capa_4.webp',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
            width: double.infinity,
            height: double.infinity,
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
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, color: Colors.purple),
                    SizedBox(width: 10),
                    Text(
                      'Resultado',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              mensagem,
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pointy',
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Text(
                  'Pontuação: $score / $totalPerguntas',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: 'Pointy',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    resetQuiz();
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    ),
                  ),
                  child: Text(
                    "Recomeçar",
                    style: TextStyle(
                      color: Colors.purple,
                      fontFamily: 'Pointy',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
