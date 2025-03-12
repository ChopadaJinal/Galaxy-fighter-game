const int xPin = A0;  // X-axis
const int yPin = A1;  // Y-axis
const int buttonPin = 7;  // Joystick button

void setup() {
    Serial.begin(9600);  // Start serial communication
    pinMode(buttonPin, INPUT_PULLUP);  // Set button pin as input with pull-up resistor
}

void loop() {
    int xValue = analogRead(xPin);  // Read X-axis
    int yValue = analogRead(yPin);  // Read Y-axis
    int buttonState = digitalRead(buttonPin);  // Read button state

    Serial.print(xValue);
    Serial.print(",");
    Serial.print(yValue);
    Serial.print(",");
    Serial.println(buttonState);  // Send values as CSV format

    delay(100);  // Small delay for stability
}
