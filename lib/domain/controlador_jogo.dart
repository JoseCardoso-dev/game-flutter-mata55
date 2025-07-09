import 'package:game_mata55/core/entities/elemento_cor_entitie.dart';
import 'package:game_mata55/core/entities/jogador_entitie.dart';
import 'package:game_mata55/core/entities/sequencia_entitie.dart';
import 'package:game_mata55/core/utils/random_generator.dart';

class ControladorJogo {
  final Sequencia _sequencia = Sequencia();
  final Jogador _jogador;
  final Function onUpdate;
  final Function onGameOver;

  List<ElementoCor> botoes;
  int _indiceAtual = 0;
  bool _esperandoJogador = false;

  ControladorJogo({
    required Jogador jogador,
    required this.botoes,
    required this.onUpdate,
    required this.onGameOver,
  }) : _jogador = jogador;

  void iniciar() {
    _sequencia.resetar();
    _jogador.resetar();
    _novaRodada();
  }

  void _novaRodada() {
    final novo = RandomGenerator.gerarElementoAleatorio(botoes);
    _sequencia.adicionar(novo);
    _indiceAtual = 0;
    _esperandoJogador = false;
    onUpdate(_sequencia.elementos);
  }

  void verificarJogada(int index) {
    if (!_esperandoJogador) return;

    final esperado = _sequencia.elementos[_indiceAtual];
    final selecionado = botoes[index];

    if (esperado != selecionado) {
      onGameOver();
      return;
    }

    _indiceAtual++;

    if (_indiceAtual >= _sequencia.elementos.length) {
      _jogador.aumentarPontuacao();
      Future.delayed(Duration(seconds: 1), _novaRodada);
    }
  }

  Jogador get jogador => _jogador;

  void permitirJogada() => _esperandoJogador = true;
}
