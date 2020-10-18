//https://maker.pro/arduino/tutorial/how-to-make-arduino-and-processing-ide-communicate#:~:text=Processing%20is%20a%20great%20source,works%20for%20a%20micro%2Dcontroller.&text=It%20has%20setup%20functions%20and,Arduino%20IDE%20through%20serial%20communication.
char val; // Data received from the serial port
int ledPin = 13; // Set the pin to digital I/O 13


void setup() {
   pinMode(ledPin, OUTPUT); // Set pin as OUTPUT
   Serial.begin(9600); // Start serial communication at 9600 bps
 }

void loop() {
  //digitalWrite(ledPin, HIGH); // turn the LED on
   if (Serial.available()) 
   { // If data is available to read,
     val = Serial.read(); // read it and store it in val
   }
   if (val == '1') 
   { // If 1 was received
     digitalWrite(ledPin, HIGH); // turn the LED on
   } else {
     digitalWrite(ledPin, LOW); // otherwise turn it off
   }
   delay(10); // Wait 10 milliseconds for next reading
}
