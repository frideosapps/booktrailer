import 'package:frideos/frideos.dart';

import 'package:frideos_core/frideos_core.dart';

import 'package:booktrailer/models/models.dart';
import 'package:booktrailer/particles/models/particles_system.dart';

class AppState extends AppStateModel {
  factory AppState() => _singletonAppState;

  AppState._internal();

  static final AppState _singletonAppState = AppState._internal();

  // STREAM
  final isPlaying = StreamedValue<bool>(initialData: false);

  // PlayingScenes widget key
  String playScenesKey = DateTime.now().toString();

  Language lang = Language.english;


  final particlesSystem = ParticlesSystem();
  bool isParticleSystemInitialized = false;


  void goToMenu() {
    isPlaying.value = false;
  }

  void play() {
    playScenesKey =
        DateTime.now().toString(); // Change the key to force the rebuild
    isPlaying.value = true;
  }

  @override
  void init() {}

  @override
  void dispose() {
    isPlaying.dispose();
  }
}

final appState = AppState();
