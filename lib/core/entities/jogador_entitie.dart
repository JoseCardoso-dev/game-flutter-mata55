import 'package:game_mata55/core/interfaces/entidade_jogo_interface.dart';

class Jogador extends EntidadeJogo {
  final String nome;
  int _pontuacao = 0;

  Jogador(this.nome);

  void aumentarPontuacao() => _pontuacao++;

  int get pontuacao => _pontuacao;

  @override
  void resetar() {
    _pontuacao = 0;
  }
}
