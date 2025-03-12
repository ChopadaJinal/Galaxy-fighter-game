# Galaxy Fighter Game using Joystick and Arduino Uno

## Overview
Galaxy Fighter is an interactive game controlled using a joystick and powered by an Arduino Uno. The game enables players to control a spaceship, navigate through obstacles, and engage in battles using joystick movements. The game output is displayed using Processing on a computer.

## Components Required
- Arduino Uno
- Joystick Module (XY Analog + Button)
- Computer with Arduino IDE
- Processing Software
- Wires and Breadboard

## Installation and Setup
### Step 1: Install Arduino IDE
Download and install the Arduino IDE from [Arduino's official website](https://www.arduino.cc/en/software).

### Step 2: Install Processing
Download and install Processing from [Processing's official website](https://processing.org/download/).

### Step 3: Connect the Hardware
Follow the wiring instructions below to connect the joystick module to the Arduino Uno.

#### Joystick Module to Arduino Uno Connections:
| Joystick Pin | Arduino Uno Pin |
|-------------|----------------|
| VCC         | 5V             |
| GND         | GND            |
| VRX         | A0             |
| VRY         | A1             |
| SW (Button) | D2             |

### Step 4: Upload the Arduino Code
1. Open Arduino IDE.
2. Connect your Arduino Uno to the computer using a USB cable.
3. Open the provided `.ino` file (e.g., `sketch_jan30a.ino`).
4. Select the correct board: **Arduino Uno**.
5. Select the correct port.
6. Click **Upload**.

### Step 5: Run the Processing Code
1. Open Processing.
2. Open the provided `.pde` file (e.g., `sketch_250218a.pde`).
3. Run the Processing script.
4. The game will display on your computer screen.

## How to Play
- Move the joystick to navigate the spaceship in different directions.
- Press the joystick button to shoot.
- Avoid obstacles and destroy enemies to earn points.
- The game will display the score and updates on the Processing window.

## Troubleshooting
- If the joystick does not respond correctly, check the wiring.
- Ensure the correct port and board are selected in Arduino IDE.
- Verify that the Processing script is correctly receiving data from Arduino.

## Future Improvements
- Add more levels and difficulty modes.
- Implement sound effects using a buzzer.
- Improve graphics using advanced Processing features.

## License
This project is open-source and can be modified or extended for educational purposes.

