library darts;

import 'dart:html';
import 'dart:async';
import 'dart:math';

part 'game.dart';

void main()
{
  Game g = new Game(querySelector('#game'));
  g.init();
}