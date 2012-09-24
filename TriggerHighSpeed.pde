int Photoresistor = 0; // Photoresistor
bool picture = true;
int IRValue  = 22;      //This Value has to be adjust for your setup
int CameraLED = 10;    // TriggerIRdiode

void setup(){
  pinMode(CameraLED, OUTPUT);
  Serial.begin(9600);
  pinMode(10, OUTPUT);
}

void pulseON(int pulseTime) {
  unsigned long endPulse = micros() + pulseTime;        
  while( micros() < endPulse) {
    digitalWrite(CameraLED, HIGH);                       
    delayMicroseconds(13);                              
    digitalWrite(CameraLED, LOW);                        
    delayMicroseconds(13);                              
  }
}
  
  
  void pulseOFF(unsigned long startDelay) {
  unsigned long endDelay = micros() + startDelay;       
  while(micros() < endDelay);
}

void takePicture() {                                //Timing for IR Led
  for (int i=0; i < 2; i++) {
    pulseON(2000);                                      
    pulseOFF(27850);                                    
    pulseON(390);                                       
    pulseOFF(1580);
    pulseON(410);
    pulseOFF(3580);
    pulseON(400);
    pulseOFF(63200);
  }                                                     
}

void loop(){
  digitalWrite(13, HIGH);
  float voltage = analogRead(Photoresistor);
  // Serial.println(voltage);
    if(voltage < IRValue && picture){                  
     takePicture();
     picture=false;
   }
   if(voltage > IRValue) {
     picture= true;
   }
}


