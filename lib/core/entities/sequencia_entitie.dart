import 'package:game_mata55/core/entities/elemento_cor_entitie.dart';
import 'package:game_mata55/core/interfaces/entidade_jogo_interface.dart';

class Sequencia extends EntidadeJogo {
  final List<ElementoCor> _elementos = [];

  List<ElementoCor> get elementos => _elementos;

  void adicionar(ElementoCor elemento) => _elementos.add(elemento);

  @override
  void resetar() {
    _elementos.clear();
  }
}
