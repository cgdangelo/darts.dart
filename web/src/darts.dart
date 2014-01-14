library darts;

import 'dart:html';
import 'dart:async';

part 'game.dart';

void main()
{
  Game g = new Game(querySelector('#game'));
  g.init();
}