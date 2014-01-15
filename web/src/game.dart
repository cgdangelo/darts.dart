part of darts;

class Game
{
  static const int CROSSHAIR_SIZE = 30;

  CanvasElement gameBoard;
  CanvasRenderingContext2D ctx;

  ImageElement boardTexture;
  ImageElement crosshairTexture;

  Game(CanvasElement gameBoardElement)
  {
    this.gameBoard = gameBoardElement;
    this.ctx = this.gameBoard.getContext('2d');
  }

  void init()
  {
    this.loadTextures();
    this.bindEvents();
  }

  void loadTextures()
  {
    this.crosshairTexture = new ImageElement(src: 'textures/cross-01.png');
  }

  void bindEvents()
  {
    this.gameBoard.onMouseMove.listen((event) => this.handleMouseMove(event));
  }

  void handleMouseMove(MouseEvent event)
  {
    ctx.clearRect(0, 0, 600, 600);
    ctx.drawImageScaled(this.crosshairTexture, event.offset.x - (Game.CROSSHAIR_SIZE / 2), event.offset.y - (Game.CROSSHAIR_SIZE / 2), Game.CROSSHAIR_SIZE, Game.CROSSHAIR_SIZE);
  }
}