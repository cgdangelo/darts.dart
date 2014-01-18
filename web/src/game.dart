part of darts;

class Game
{
  static const int CROSSHAIR_SIZE = 30;
  static const int BOARD_SIZE = 600;

  static const int JITTER = 4;
  static const int FOCUSING_JITTER = 2;

  CanvasElement gameBoard;
  CanvasRenderingContext2D ctx;

  ImageElement boardTexture;
  ImageElement crosshairTexture;

  Point crosshairPosition = new Point((Game.BOARD_SIZE / 2) - (Game.CROSSHAIR_SIZE / 2), (Game.BOARD_SIZE / 2) - (Game.CROSSHAIR_SIZE / 2));

  bool focusing = false;
  bool recentlyFocused = false;

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
    this.gameBoard.onMouseMove.listen((MouseEvent event) => this.handleMouseMove(event));

    new Timer.periodic(const Duration(milliseconds: 250), (Timer) {
      this.jitter();
      this.drawCrosshair();
    });

    document.onKeyDown.listen((KeyboardEvent event) {
      if (event.shiftKey && !this.recentlyFocused) {
        this.startFocusing();
      }
    });

    document.onKeyUp.listen((KeyboardEvent event) {
      if (!event.shiftKey && this.focusing) {
        this.stopFocusing();
      }
    });
  }

  void startFocusing()
  {
    this.focusing = true;
    new Future.delayed(const Duration(seconds: 1), () {
      this.stopFocusing();
    });
  }

  void stopFocusing()
  {
    this.focusing = false;
    this.recentlyFocused = true;
    new Future.delayed(const Duration(seconds: 5), () => this.recentlyFocused = false);
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
    int jitter = this.focusing ? Game.FOCUSING_JITTER : Game.JITTER;

    Random rng = new Random();

    if (movement == null) {
      movement = new Point(
        rng.nextInt(jitter),
        rng.nextInt(jitter)
      );
    }

    int jitterX = -movement.x * jitter + rng.nextInt((movement.x.abs() + 1) * jitter);
    int jitterY = -movement.y * jitter + rng.nextInt((movement.y.abs() + 1) * jitter);
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