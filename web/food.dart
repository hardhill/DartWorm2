part of wormgame;

class Food{
  DivElement _element;
  int _countdown = 0;
  Food(int x,int y){
    _element = new Element.div();
    _element.style.left = "${x}px";
    _element.style.top = "${y}px";
    _element.classes.add('food');
    _element.style.opacity = '0.0';
  }
  void hide(){
    _element.style.opacity = '0.0';
  }
  void show(){
    _element.style.opacity = '1.0';
  }
  void move(int x, int y){
    _element.style.left = '${x}px';
    _element.style.top = '${y}px';
  }
  bool visible(){
    if(_element.style.opacity == '1'){
      return true;
    }
    return false;
  }
  int get countdown => _countdown;
    set countdown(int v) => _countdown = v;
  int decrement() => _countdown--;
  Element get element => _element;
}

