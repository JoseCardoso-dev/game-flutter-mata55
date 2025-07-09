import 'package:game_mata55/core/entities/elemento_cor_entitie.dart';
import 'dart:math';

class RandomGenerator {
  static ElementoCor gerarElementoAleatorio(List<ElementoCor> elementos) {
    final random = Random();
    return elementos[random.nextInt(elementos.length)];
  }
}
