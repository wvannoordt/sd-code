#define stp 4 
#define dir 2
#define MS1 8
#define MS2 6
#define EN  5

const int button1=3;
int x=0;


//************EDIT THESE CONTROLS************

int num_steps=400;    //200 steps/full rotation (1.8 deg step) *8 for microstepping mode, /4 for 90 degrees.  200*8/4=400
int spd=2;            //This is the millisecond delay between steps. Smaller number=faster rotation.
int open_time=5000;       //Duration the peacock stays open.

//************END OF CONTROLS************



void setup()
{
  pinMode(button1, INPUT_PULLUP);
  pinMode(stp, OUTPUT);
  pinMode(dir, OUTPUT);
  pinMode(MS1, OUTPUT);
  pinMode(MS2, OUTPUT);
  pinMode(EN, OUTPUT);
  resetEDPins(); //Set step, direction, microstep and enable pins to default states
  digitalWrite(MS1, HIGH);  //Pull MS1, and MS2 high to set logic to 1/8th microstep resolution
  digitalWrite(MS2, HIGH);
  digitalWrite(EN, LOW);
}

void loop(){
  if(digitalRead(button1)==LOW){
    x=0;
    digitalWrite(dir, HIGH); //Pull direction pin high to move "backward"
    while(x<num_steps){
      digitalWrite(stp,HIGH); //Trigger one step forward
      delay(spd);
      digitalWrite(stp,LOW); //Pull step pin low so it can be triggered again
      delay(spd);
      x=x+1;
    }
    
    delay(open_time);

    x=0;
    digitalWrite(dir, LOW); //Pull direction pin low to move "forward"
    while(x<num_steps){
      digitalWrite(stp,HIGH); //Trigger one step
      delay(spd);
      digitalWrite(stp,LOW); //Pull step pin low so it can be triggered again
      delay(spd);
      x=x+1;
    }
  }
  delay(10);
}




void resetEDPins(){   //Reset Easy Driver pins to default states
  digitalWrite(stp, LOW);
  digitalWrite(dir, LOW);
  digitalWrite(MS1, LOW);
  digitalWrite(MS2, LOW);
  digitalWrite(EN, HIGH);
}
