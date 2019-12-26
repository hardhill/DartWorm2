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
Element gameBoard, scoreElement;


void main() {
  document.onKeyPress.listen(keyPressed);
  gameBoard = querySelector('#board');
  scoreElement = querySelector('#score');
  worm = Worm(gameBoard,40,40,Worm.EAST);

  for(int i=0;i<10;i++){
    Food food = new Food(random.nextInt(800-20), random.nextInt(600-20));
    gameBoard.children.add(food.element);
    food.show();
    listFood.add(food);
  }

  startActionTimer();
  
}

void startActionTimer(){
  actionTimer = Timer.periodic(Duration(milliseconds: 700),onTimer);
}

void reset(){
  if(actionTimer.isActive){
    actionTimer.cancel();
  }
  for(Element element in gameBoard.children){
    if(element.id =='worm' || element.id=='announcement'|| element.classes.contains('body')){
      gameBoard.children.remove(element);
    }
  }
  worm = new Worm(gameBoard, 40, 40, Worm.EAST);
  startActionTimer();
}

void keyPressed(KeyboardEvent event){
  String key = new String.fromCharCode(event.charCode);
  switch (key){
    case 'w':{
      worm.turnNorth();
      break;
    }
    case 'a':{
      worm.turnWest();
      break;
    }
    case 's':{
      worm.turnSouth();
      break;
    }
    case 'd':{
      worm.turnEast();
      break;
    }
    case 'p':{
      if(actionTimer.isActive){
        actionTimer.cancel();
      }else{
        startActionTimer();
      }
      break;
    }
    case 'r':{
      reset();
      break;
    }
    default:{

    }
  }
}

void onTimer(Timer t){
  worm.redraw(null);
  if(worm.intersectsWithItSelf()||worm.outOfBoard()){
    gameOver();
  }
  for(Food f in listFood){
    if(worm.intersectsWith(f.element)){
      worm.flicker();
      worm.growBody(3);
      f.hide();
      f.move(random.nextInt(800-20), random.nextInt(600-20));
      f.show();
      worm.score += 1;
      scoreElement.text = worm.score.toString();
    }else{

    }
  }
  if(worm.score>=25){
    youWin();
  }
  
}

void gameOver(){
  if(actionTimer.isActive){
    actionTimer.cancel();
  }
  gameBoard.children.clear();
  Element e = Element.p();
  e.id = 'announcement';
  e.text = 'GAME OVER';
  gameBoard.append(e);
}

void youWin(){
  if(actionTimer.isActive){
    actionTimer.cancel();
  }
  gameBoard.children.clear();
  var element = Element.p();
  element.id = 'announcement';
  element.text = 'You Win!';
  gameBoard.append(element);
}

