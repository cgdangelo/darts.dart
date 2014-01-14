part of darts;

class Game
{
  CanvasElement gameBoard;
  CanvasRenderingContext2D ctx;
  
  Game(CanvasElement gameBoardElement)
  {
    this.gameBoard = gameBoardElement;
    this.ctx = this.gameBoard.getContext('2d');
  }
  
  void init()
  {
    this.loadBoard();
  }
  
  void loadBoard()
  {
    ImageElement board = new ImageElement(src: 'textures/dartboard.jpg');
    Future.wait([board.onLoad.first]).then((_) => ctx.drawImageScaled(board, 0, 0, 600, 600));
  }
}