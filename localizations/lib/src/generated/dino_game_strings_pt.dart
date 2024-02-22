import 'dino_game_strings.dart';

/// The translations for Portuguese (`pt`).
class DinoGameStringsPt extends DinoGameStrings {
  DinoGameStringsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'Dino Game';

  @override
  String get score => 'Score: ';

  @override
  String get high => 'High: ';

  @override
  String get play => 'Jogar';

  @override
  String get settings => 'Configurações';

  @override
  String get resume => 'Retornar';

  @override
  String get restart => 'Recomeçar';

  @override
  String get exit => 'Sair';

  @override
  String get music => 'Música';

  @override
  String get effects => 'Efeitos';

  @override
  String get gameOver => 'Game Over';

  @override
  String get yourScore => 'Seu Score: ';
}
