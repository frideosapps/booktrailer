enum Language { english, italian }

enum AssetsImages {
  cover,
  black,
  rain,
  smoke,
  city,
  man,
  alone,
  tunnel,
  eyes,
  coverPhoto,
}

enum AnimationType {
  fadeOut,
  fadeIn,
  mov,
  scale,
  grow,
  color,
  transition,
}

enum TextAnimationType { scale, mov, split }

enum TransitionType { horizontal, vertical, circular, linear, spiral }

enum TrailerScene { first, second, third, fourth, fifth, sixth }

final imageFilenames = {
  AssetsImages.cover: 'assets/images/cover.png',
  AssetsImages.black: 'assets/images/black.png',
  AssetsImages.rain: 'assets/images/rain.png',
  AssetsImages.smoke: 'assets/images/smoke.png',
  AssetsImages.alone: 'assets/images/alone.png',
  AssetsImages.city: 'assets/images/city.png',
  AssetsImages.eyes: 'assets/images/eyes.png',
  AssetsImages.man: 'assets/images/man.png',
  AssetsImages.tunnel: 'assets/images/tunnel.png',
  AssetsImages.coverPhoto: 'assets/images/cover_photo.png',
};

final textsScenes = {
  TrailerScene.first: {
    Language.italian: [
      'Un\'anonima giornata iniziata',
      'come tutte le altre...'
    ],
    Language.english: ['It was just an ordinary', 'day like many others...']
  },
  TrailerScene.first: {
    Language.italian: [
      'Un\'anonima giornata iniziata',
      'come tutte le altre...'
    ],
    Language.english: ['It was just an ordinary', 'day like many others...']
  },
  TrailerScene.second: {
    Language.italian: [
      'Poi un oggetto antico, la voce',
      'di uno sconosciuto...'
    ],
    Language.english: ['Then a weird box, the voice', 'of an unknown man...']
  },
  TrailerScene.third: {
    Language.italian: ['...l\'inizio di un mistero.'],
    Language.english: ['...the beginning of a mistery.'],
  },
  TrailerScene.fourth: {
    Language.italian: [
      'Maledette coincidenze, ossessioni...',
      'Semplice follia o assurda realtà?'
    ],
    Language.english: [
      'Cursed coincidences, obsessions...',
      'Just madness or illogical reality?'
    ],
  },
  TrailerScene.fifth: {
    Language.italian: [
      'E poi bramar la notte solo',
      'per poter rivedere i suoi occhi.'
    ],
    Language.english: [
      'And then hardly looking forward',
      'the night, just to see her eyes...'
    ],
  },
  TrailerScene.sixth: {
    Language.italian: ['E se fosse tutto vero?'],
    Language.english: ['What if was it real?']
  },
};
