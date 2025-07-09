import 'package:flutter/material.dart';
import 'package:game_mata55/core/entities/elemento_cor_entitie.dart';
import 'package:game_mata55/core/entities/jogador_entitie.dart';
import 'package:game_mata55/core/interfaces/play_sound_interface.dart';
import 'package:game_mata55/core/utils/sound_player.dart';
import 'package:game_mata55/domain/controlador_jogo.dart';
import '../widgets/botao_jogo.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late ControladorJogo controlador;
  List<ElementoCor> botoes = [];
  List<ElementoCor> sequenciaAtual = [];
  final ISoundPlayer soundPlayer = JustAudioPlayer();

  @override
  void initState() {
    super.initState();
    botoes = [
      ElementoCor(
        cor: CorElemento.azul,
        somPath: 'assets/sounds/blue.mp3',
        soundPlayer: soundPlayer,
      ),
      ElementoCor(
        cor: CorElemento.verde,
        somPath: 'assets/sounds/green.mp3',
        soundPlayer: soundPlayer,
      ),
      ElementoCor(
        cor: CorElemento.vermelho,
        somPath: 'assets/sounds/red.mp3',
        soundPlayer: soundPlayer,
      ),
      ElementoCor(
        cor: CorElemento.amarelo,
        somPath: 'assets/sounds/yellow.mp3',
        soundPlayer: soundPlayer,
      ),
    ];

    controlador = ControladorJogo(
      jogador: Jogador("José Roberto Cardoso"),
      botoes: botoes,
      onUpdate: (List<ElementoCor> novaSequencia) async {
        setState(() => sequenciaAtual = novaSequencia);

        for (final e in novaSequencia) {
          await Future.delayed(Duration(milliseconds: 500));
          e.executar();
        }
        controlador.permitirJogada();
      },
      onGameOver: () {
        showDialog(
          context: context,
          builder:
              (_) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.sentiment_very_dissatisfied,
                        size: 60,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Game Over!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Sua pontuação foi:",
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${controlador.jogador.pontuacao}",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          controlador.iniciar();
                        },
                        icon: Icon(Icons.replay),
                        label: Text("Recomeçar"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        );
      },
    );

    controlador.iniciar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Simon Musical")),
      body: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.6,
          height: MediaQuery.sizeOf(context).width * 0.6,
          child: Stack(
            alignment: Alignment.center,
            children: [
              BotaoJogo(
                alignment: Alignment.topLeft,
                elemento: botoes[0],
                onPressed:
                    () =>
                        controlador.verificarJogada(botoes.indexOf(botoes[0])),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(150),
                ),
              ),

              BotaoJogo(
                alignment: Alignment.topRight,
                elemento: botoes[1],
                onPressed:
                    () =>
                        controlador.verificarJogada(botoes.indexOf(botoes[1])),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(150),
                ),
              ),

              BotaoJogo(
                alignment: Alignment.bottomRight,
                elemento: botoes[2],
                onPressed:
                    () =>
                        controlador.verificarJogada(botoes.indexOf(botoes[2])),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(150),
                ),
              ),

              BotaoJogo(
                alignment: Alignment.bottomLeft,
                elemento: botoes[3],
                onPressed:
                    () =>
                        controlador.verificarJogada(botoes.indexOf(botoes[3])),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(150),
                ),
              ),

              Container(
                width: MediaQuery.sizeOf(context).width * 0.26,
                height: MediaQuery.sizeOf(context).width * 0.26,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade800, width: 4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Jogada",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Text(
                      controlador.jogador.pontuacao.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          'Desenvolvido por José Roberto Cardoso',
          style: TextStyle(
            color: Colors.grey.shade300,
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
