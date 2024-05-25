import 'package:flutter/material.dart';
import 'tela_destino.dart';

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/fontes/images/the book model (1).jpg',
            fit: BoxFit.cover,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 243, 101, 179),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(120, 80),
              ),
              child: Text(
                'Comece aqui',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'JustusOldstyle',
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
