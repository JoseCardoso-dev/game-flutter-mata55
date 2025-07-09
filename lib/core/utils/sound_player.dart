import 'package:flutter/material.dart';
import 'package:game_mata55/core/interfaces/play_sound_interface.dart';
import 'package:just_audio/just_audio.dart';

class JustAudioPlayer implements ISoundPlayer {
  final _player = AudioPlayer();

  @override
  Future<void> play(String path) async {
    try {
      final audioSource = AudioSource.asset(path);
      await _player.setAudioSource(audioSource);
      await _player.play();
    } catch (e) {
      debugPrint('Erro ao reproduzir o som: $e');
    }
  }
}
