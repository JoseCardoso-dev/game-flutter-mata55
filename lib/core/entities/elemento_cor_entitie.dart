import 'package:flutter/material.dart';
import 'package:game_mata55/core/interfaces/play_sound_interface.dart';

enum CorElemento { azul, verde, vermelho, amarelo }

class ElementoCor {
  final CorElemento cor;
  final String somPath;
  final ISoundPlayer soundPlayer;
  final ValueNotifier<bool> piscarNotifier = ValueNotifier(false);

  ElementoCor({
    required this.cor,
    required this.somPath,
    required this.soundPlayer,
  });

  Color get colorValue {
    switch (cor) {
      case CorElemento.azul:
        return Colors.blue;
      case CorElemento.verde:
        return Colors.green;
      case CorElemento.vermelho:
        return Colors.red;
      case CorElemento.amarelo:
        return Colors.yellow;
    }
  }

  Future<void> executar() async {
    await soundPlayer.play(somPath);

    piscarNotifier.value = true;
    await Future.delayed(const Duration(milliseconds: 300));
    piscarNotifier.value = false;
  }
}
