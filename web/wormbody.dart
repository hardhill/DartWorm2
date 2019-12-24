part of wormgame;



class Worm{

  static const int NORTH = 0;
  static const int EAST = 1;
  static const int SOUTH = 2;
  static const int WEST = 3;

  Element _parent;
  DivElement _head;
  int _currentDirection = Worm.EAST;
  int _x = 0;
  int _y = 0;
  int _width=0;
  int _height=0;
  bool _alive = true;
  int _score=0;
  List<Element> _body = new List<Element>();
  Worm(Element parent, int x, int y, int direction){
    _parent = parent;
    _head = new DivElement();
    _head.id = 'worm';
    _x=x;
    _y=y;
    _head.style.left = '${_x}px';
    _head.style.top = '${_y}px';
    _currentDirection = direction;
    _parent.children.add(_head);
    String widthString = _head.getComputedStyle().width;
    String heghtString = _head.getComputedStyle().height;
    _height = int.parse(heghtString.substring(0,heghtString.indexOf(new RegExp(r'\D'))));
    _width = int.parse(widthString.substring(0,widthString.indexOf(new RegExp(r'\D'))));
    growNody(3);
  }

  void turnNorth(){
    if(_currentDirection==Worm.SOUTH){
      return;
    }
    _currentDirection = Worm.NORTH;
  }

  void turnSouth(){
    if(_currentDirection==Worm.NORTH){
      return;
    }
    _currentDirection = Worm.SOUTH;
  }
  void turnEast(){
    if(_currentDirection==Worm.WEST){
      return;
    }
    _currentDirection = Worm.EAST;
  }
  void turnWest(){
    if(_currentDirection==Worm.EAST){
      return;
    }
    _currentDirection = Worm.WEST;
  }

  void growNody(int count) {
    for(int i=0;i<count;i++){
      DivElement bodyElement = new DivElement();
      bodyElement.classes.add('body');
      if(_body.length>0){
        bodyElement.style.left = _body.last.style.left;
        bodyElement.style.top = _body.last.style.top;
      }else{
        bodyElement.style.left = _head.style.left;
        bodyElement.style.top = _head.style.top;
      }
      _body.add(bodyElement);
      _parent.children.add(bodyElement);
    }
  }

  void redraw(Event e){
    String tempX, tempY,lastX, lastY;
    lastX = _head.style.left;
    lastY = _head.style.top;
    if(_currentDirection==Worm.NORTH){
      _y -= _height;
    }else if(_currentDirection==Worm.EAST){
      _x += _width;
    }else if(_currentDirection==Worm.SOUTH){
      _y += _height;
    }else if(_currentDirection==Worm.WEST){
      _x -= _width;
    }else{
      print('Unknown direction turn on East');
      _currentDirection = Worm.WEST;
    }
    _head.style.left = '${_x}px';
    _head.style.top = '${_y}px';
    //update the body element
    for(DivElement e in _body){
      tempX = e.style.left;
      tempY = e.style.top;
      e.style.left = lastX;
      e.style.top = lastY;
      lastX = tempX;
      lastY = tempY;
    }

  }
  bool intersectsWith(Element e){
    return _head.borderEdge.intersects(e.borderEdge);
  }
  bool intersectsWithWorm(Worm s){
    if(this.intersectsWith(s._head)){
      return true;
    }
    for(DivElement e in s._body){
      if(this.intersectsWith(e)){
        return true;
      }
    }
    return false;
  }
  bool intersectsWithItSelf(){
    for(DivElement e in _body){
      if(_head.borderEdge.containsRectangle(e.borderEdge)){
        return true;
      }
    }
    return false;
  }

}