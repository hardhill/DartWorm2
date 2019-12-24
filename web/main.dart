library wormgame;

import 'dart:html';
import 'dart:math';
import 'dart:async';

part 'food.dart';
part 'wormbody.dart';

Timer actionTimer;
Random random = new Random();
List<Food> listFood = new List<Food>();
Worm worm;


void main() {
  var board = querySelector('#board');
  worm = Worm(board,40,40,Worm.EAST);

  for(int i=0;i<10;i++){
    Food food = new Food(random.nextInt(800-20), random.nextInt(600-20));
    board.children.add(food.element);
    food.show();
    listFood.add(food);
  }

  actionTimer = Timer.periodic(Duration(milliseconds: 1000),handleTimer);
  worm.redraw(null);
}

void handleTimer(Timer t){
  for(Food f in listFood){
    f.move(random.nextInt(800-20), random.nextInt(600-20));
  }
}

