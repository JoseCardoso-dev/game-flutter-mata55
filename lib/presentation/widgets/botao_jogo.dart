import 'package:flutter/material.dart';
import 'package:game_mata55/core/entities/elemento_cor_entitie.dart';

class BotaoJogo extends StatefulWidget {
  final ElementoCor elemento;
  final VoidCallback onPressed;
  final BorderRadius borderRadius;
  final AlignmentGeometry alignment;

  const BotaoJogo({
    required this.elemento,
    required this.onPressed,

    required this.borderRadius,
    required this.alignment,
    super.key,
  });

  @override
  State<BotaoJogo> createState() => _BotaoJogoState();
}

class _BotaoJogoState extends State<BotaoJogo> {
  @override
  void initState() {
    super.initState();
    widget.elemento.piscarNotifier.addListener(_onPiscarChanged);
  }

  void _onPiscarChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.elemento.piscarNotifier.removeListener(_onPiscarChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isPiscar = widget.elemento.piscarNotifier.value;

    return Align(
      alignment: widget.alignment,
      child: GestureDetector(
        onTap: () {
          widget.elemento.executar();
          widget.onPressed();
        },
        child: AnimatedContainer(
          width: MediaQuery.sizeOf(context).width * 0.28,
          height: MediaQuery.sizeOf(context).width * 0.28,
          duration: const Duration(milliseconds: 100),
          margin: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color:
                isPiscar
                    ? widget.elemento.colorValue.withValues(alpha: 0.5)
                    : widget.elemento.colorValue,
            borderRadius: widget.borderRadius,
            boxShadow:
                isPiscar
                    ? [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.6),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ]
                    : [],
          ),
        ),
      ),
    );
  }
}
