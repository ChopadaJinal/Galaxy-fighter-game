
import processing.serial.*;  // Import the Serial library

Serial myPort;  // Serial port for joystick
float playerX, playerY;  // Player position
float playerSize = 40;   // Size of the player's aircraft
boolean isGameOver = false; // Game state flag

ArrayList<Enemy> enemies;  // List of enemies
ArrayList<Bullet> bullets; // List of enemy bullets
ArrayList<PlayerBullet> playerBullets; // List of player bullets
int spawnTimer = 0;        // Timer for spawning enemies

void setup() {
  size(600, 600);  // Game screen size
  myPort = new Serial(this, "COM10", 9600);
  myPort.bufferUntil('\n');

  initializeGame();  // Initialize game variables
}

void draw() {
  if (isGameOver) {
    // Show "Game Over" screen
    background(0);
    fill(255, 0, 0);
    textAlign(CENTER, CENTER);
    textSize(50);
    text("Game Over", width / 2, height / 2);
    textSize(20);
    text("Press button to restart", width / 2, height / 2 + 40);
    return;
  }

  background(0);  // Black background

  // Draw player aircraft
  fill(0, 255, 0);
  noStroke();
  triangle(playerX, playerY, playerX - 20, playerY + 40, playerX + 20, playerY + 40);

  // Update and draw enemies
  for (int i = enemies.size() - 1; i >= 0; i--) {
    Enemy e = enemies.get(i);
    e.update();
    e.show();
    if (e.isOffScreen()) {
      enemies.remove(i);  // Remove enemies that leave the screen
    }
  }

  // Update and draw enemy bullets
  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet b = bullets.get(i);
    b.update();
    b.show();
    if (b.isOffScreen()) {
      bullets.remove(i);  // Remove bullets that leave the screen
    } else if (b.hitsPlayer(playerX, playerY, playerSize)) {
      // Trigger Game Over if bullet hits the player
      isGameOver = true;
      break;  // Exit the loop
    }
  }

  // Update and draw player bullets
  for (int i = playerBullets.size() - 1; i >= 0; i--) {
    PlayerBullet pb = playerBullets.get(i);
    pb.update();
    pb.show();
    // Check if the bullet hits any enemy
    for (int j = enemies.size() - 1; j >= 0; j--) {
      if (pb.hitsEnemy(enemies.get(j))) {
        enemies.remove(j);  // Remove the enemy
        playerBullets.remove(i);  // Remove the player bullet
        break;
      }
    }
    if (pb.isOffScreen()) {
      playerBullets.remove(i);  // Remove player bullets that leave the screen
    }
  }

  // Spawn new enemies periodically
  spawnTimer++;
  if (spawnTimer > 60) {  // Spawn every 60 frames
    enemies.add(new Enemy());
    spawnTimer = 0;
  }
}

void serialEvent(Serial myPort) {
  String data = myPort.readStringUntil('\n');
  data = trim(data);
  if (data != null) {
    String[] values = split(data, ',');
    if (values.length == 3) {  // Ensure data includes X, Y, and button state
      // Update player position based on joystick input
      float xValue = map(float(values[0]), 0, 1023, 0, width);
      float yValue = map(float(values[1]), 0, 1023, height - 100, height);
      int buttonState = int(values[2]);  // Button state (0 = pressed, 1 = released)

      if (isGameOver && buttonState == 0) {
        // Restart the game if button is pressed during Game Over
        initializeGame();
        return;
      }

      if (!isGameOver) {
        playerX = constrain(xValue, 20, width - 20);  // Keep player on-screen
        playerY = constrain(yValue, height - 100, height - 20);

        // Shoot a bullet when the button is pressed
        if (buttonState == 0) {
          playerBullets.add(new PlayerBullet(playerX, playerY));
        }
      }
    }
  }
}

// Initialize or restart the game
void initializeGame() {
  // Reset player position
  playerX = width / 2;
  playerY = height - 60;

  // Clear all enemies and bullets
  enemies = new ArrayList<Enemy>();
  bullets = new ArrayList<Bullet>();
  playerBullets = new ArrayList<PlayerBullet>();

  // Reset game state
  spawnTimer = 0;
  isGameOver = false;
}

// Enemy Class
class Enemy {
  float x, y, size;
  float speed;  // Speed of the enemy

  Enemy() {
    x = random(20, width - 20);
    y = -40;
    size = 40;
    speed = 1;  // Slower vertical speed
  }

  void update() {
    y += speed;  // Move downward
    if (frameCount % 90 == 0) {  // Shoot bullets less frequently
      bullets.add(new Bullet(x, y + size / 2));
    }
  }

  void show() {
    fill(255, 0, 0);
    rectMode(CENTER);
    rect(x, y, size, size);
  }

  boolean isOffScreen() {
    return y > height;
  }
}

// Bullet Class (Enemy Bullets)
class Bullet {
  float x, y, size;

  Bullet(float startX, float startY) {
    x = startX;
    y = startY;
    size = 10;
  }

  void update() {
    y += 5;  // Move downward
  }

  void show() {
    fill(255, 255, 0);
    ellipse(x, y, size, size);
  }

  boolean isOffScreen() {
    return y > height;
  }

  boolean hitsPlayer(float px, float py, float pSize) {
    return dist(x, y, px, py) < (size + pSize) / 2;
  }
}

// PlayerBullet Class
class PlayerBullet {
  float x, y, size;

  PlayerBullet(float startX, float startY) {
    x = startX;
    y = startY;
    size = 8;
  }

  void update() {
    y -= 7;  // Move upward
  }

  void show() {
    fill(0, 0, 255);
    ellipse(x, y, size, size);
  }

  boolean isOffScreen() {
    return y < 0;
  }

  boolean hitsEnemy(Enemy e) {
    return dist(x, y, e.x, e.y) < (size + e.size) / 2;
  }
}
