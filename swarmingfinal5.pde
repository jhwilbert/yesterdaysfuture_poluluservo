#include <SoftwareSerial.h>

#define RXPIN 4
#define TXPIN 3

int threshold;
int mySensVals[4]; 
int val_sensor0;
int val_sensor1;
int val_sensor2;
int val_sensor3;

int runningRandom;

int running[4];

SoftwareSerial pololu(RXPIN, TXPIN);

void setup() {
  Serial.begin(9600);
  pololu.begin(9600);   
  pinMode(RXPIN, OUTPUT);  
  pinMode(TXPIN, OUTPUT);
  digitalWrite(TXPIN, HIGH); 
}

void loop() {
 controlInteraction(0,0,10); // screen 1
 controlInteraction(1,1,10); // screen 2
 controlInteraction(2,2,10); // screen 3
 controlInteraction(3,3,10); // screen 4
}

/*
void startCounter(int time, int sensor) {
  
  for (int i=0; i <= time; i++){
       i++;
      // Serial.println("count 0:");
      //  Serial.print(i);
    //  Serial.println("sensor:");
    //  Serial.println(sensor);
       running[sensor] = 1;
       Serial.print("running"); 
       Serial.println(running[sensor]); 
      } 
      running[sensor] = 0;
        Serial.print("running"); 
        Serial.println(running[sensor]);
}
*/

void SetServo(int servo, int position) {
  position = constrain(position, 0, 254);
  servo = constrain (servo, 0, 15);
  pololu.print(255, BYTE);
  pololu.print(servo, BYTE);
  pololu.println(position, BYTE);
}


void controlInteraction (int sensor, int servo, int threshold) {
  
  val_sensor0 = analogRead(sensor);
  val_sensor1 = analogRead(sensor);
  val_sensor2 = analogRead(sensor);
  val_sensor3 = analogRead(sensor);
   
  mySensVals[0] = val_sensor0;
  mySensVals[1] = val_sensor1;
  mySensVals[2] = val_sensor2;
  mySensVals[3] = val_sensor3;
  delay(50);
  
 
  Serial.print("0==");
  Serial.println(mySensVals[0]);
  
    
  Serial.print("1==");
  Serial.println(mySensVals[1]);
  
  Serial.print("2==");
  Serial.println(mySensVals[2]);
  
  Serial.print("3==");
  Serial.println(mySensVals[3]);
  
 // int average = ((mySensVals[0]+mySensVals[1]+mySensVals[2]+mySensVals[3])/4);
  if( mySensVals[0] > threshold && mySensVals[1] > threshold && mySensVals[2] > threshold && mySensVals[3] > threshold) {
          SetServo(servo,255);
   //     startCounter(1000,sensor);
   delay(1000);
        Serial.print("antenna");
        Serial.print(sensor);
        Serial.println("up"); 
  } else {
        Serial.print("antenna");
        Serial.print(sensor);
        Serial.println("down"); 
       SetServo(servo,0);
  }
 
} 

