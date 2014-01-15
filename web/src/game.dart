part of darts;

class Game
{
  static const int CROSSHAIR_SIZE = 30;
  static const int BOARD_SIZE = 600;

  CanvasElement gameBoard;
  CanvasRenderingContext2D ctx;

  ImageElement boardTexture;
  ImageElement crosshairTexture;

  Point crosshairPosition = new Point((Game.BOARD_SIZE / 2) - (Game.CROSSHAIR_SIZE / 2), (Game.BOARD_SIZE / 2) - (Game.CROSSHAIR_SIZE / 2));

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
    new Timer.periodic(const Duration(milliseconds: 250), (Timer) {
      this.jitter();
      this.drawCrosshair();
    });
  }

  void handleMouseMove(MouseEvent event)
  {
    this.crosshairPosition = new Point(
        event.offset.x - (Game.CROSSHAIR_SIZE / 2),
        event.offset.y - (Game.CROSSHAIR_SIZE / 2)
    );

    this.jitter(event.movement);
    this.drawCrosshair();
  }

  void jitter([Point movement])
  {
    Random rng = new Random();

    if (movement == null) {
      movement = new Point(
        rng.nextInt(4),
        rng.nextInt(4)
      );
    }

    int jitterX = -movement.x * 4 + rng.nextInt((movement.x.abs() + 1) * 4);
    int jitterY = -movement.y * 4 + rng.nextInt((movement.y.abs() + 1) * 4);
    this.crosshairPosition = new Point(
      this.crosshairPosition.x + jitterX,
      this.crosshairPosition.y + jitterY
    );
  }

  void drawCrosshair()
  {
    this.ctx.clearRect(0, 0, 600, 600);
    this.ctx.drawImageScaled(this.crosshairTexture, this.crosshairPosition.x, this.crosshairPosition.y, Game.CROSSHAIR_SIZE, Game.CROSSHAIR_SIZE);
  }
}