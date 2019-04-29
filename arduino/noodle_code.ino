const int PIR1=2;   //PIR sensor pins
const int PIR2=3;
const int PIR3=4;
const int PIR4=5;
const int PIR5=6;

const int num_PIR=5;    //Current number of PIR sensors used, affects array size
int PIR[num_PIR]={PIR1, PIR2, PIR3, PIR4, PIR5};    //Array containing all PIR sensor pins

int PIR_data[num_PIR];    //Array holding results of PIR scan, all elements either 0 or 1
int sum_data=0;   //Sum of PIR data, anything above 0 means motion detected somewhere

const int limitA_latch=8;   //Limit switches
const int limitA_arm=9;
const int limitB_latch=A2;
const int limitB_arm=A3;

int latchA=0;     //Variables for loop when latching/unlatching
int latchB=0;

const int PWM_A=10;   //Motor speed variables, need PWM pins
const int PWM_B=11;
const int A_dir1=12;  //Motor direction pins, one must be high and other low to move
const int A_dir2=13;
const int B_dir1=A0;
const int B_dir2=A1;

const int rotate=1000;  //Delay for spinning in reverse affter atch or unlatch, may need to be altered

void setup(){
pinMode(PIR1, INPUT);
pinMode(PIR2, INPUT);
pinMode(PIR3, INPUT);
pinMode(PIR4, INPUT);
pinMode(PIR5, INPUT);
//pinMode(PIR6, INPUT);
pinMode(limitA_latch, INPUT_PULLUP);    //Limit switches need pullup resistors
pinMode(limitA_arm, INPUT_PULLUP);
pinMode(limitB_latch, INPUT_PULLUP);
pinMode(limitB_arm, INPUT_PULLUP);
pinMode(PWM_A, OUTPUT);
pinMode(PWM_B, OUTPUT);
pinMode(A_dir1, OUTPUT);
pinMode(A_dir2, OUTPUT);
pinMode(B_dir1, OUTPUT);
pinMode(B_dir2, OUTPUT);
Serial.begin(9600);     //Begin serial monitor for debugging

latch();    //Latch arm to know starting position
delay(100);
prep("unlatch");
delay(10000);    //10 sec delay to warm up PIR sensors
}

void loop(){
  scan_PIR();   //Check each of the PIR sensors, set sum_data to number triggered
  
  if (sum_data>1){  //need more than 1 sensor triggered to move arms
    Serial.println("MOTORS ON");
    unlatch();
    delay(1000);
    prep("latch");
    delay(2000);
    latch();
    delay(100);
    prep("unlatch");
    delay(1000);
  }
}



void scan_PIR(){
  for (int i=0; i<num_PIR; i++){
    PIR_data[i]=digitalRead(PIR[i]);
    Serial.print(PIR_data[i]);
    Serial.print("    ");
  }
  Serial.println("");
  delay(10);

  sum_data=0;
  for (int j=0; j<num_PIR; j++){
    sum_data=sum_data+PIR_data[j];
  }
  Serial.print("Sum data: ");
  Serial.println(sum_data);
}



void latch(){   //Relies on limit switch on arm only
  set_dir("latch");
  Serial.println("Latching");
  digitalWrite(PWM_A, 255);
  digitalWrite(PWM_B, 255);
  latchA=0;
  latchB=0;
  while(latchA==0 || latchB==0){
    if(digitalRead(limitA_arm)==0){
      latchA=1;
      digitalWrite(PWM_A, 0);
    }
    if(digitalRead(limitB_arm)==0){
      latchB=1;
      digitalWrite(PWM_B, 0);
    }
  }
}



void unlatch(){   //Relies on limit switch on latch only, add timer later
  set_dir("unlatch");
  Serial.println("Unlatching");
  digitalWrite(PWM_A, 255);
  digitalWrite(PWM_B, 255);
  latchA=0;
  latchB=0;
  while(latchA==0 || latchB==0){
    if(digitalRead(limitA_latch)==0){
      latchA=1;
      digitalWrite(PWM_A, 0);
    }
    if(digitalRead(limitB_latch)==0){
      latchB=1;
      digitalWrite(PWM_B, 0);
    }
  }
}



void prep(String motor_dir){
  set_dir(motor_dir);
  digitalWrite(PWM_A, 255);
  digitalWrite(PWM_B, 255);
  delay(rotate);
  digitalWrite(PWM_A, 0);
  digitalWrite(PWM_B, 0);
}



void set_dir(String dir){
  if(dir=="latch"){
    digitalWrite(A_dir1, HIGH);
    digitalWrite(A_dir2, LOW);
    digitalWrite(B_dir1, HIGH);
    digitalWrite(B_dir2, LOW);
  }
  else if(dir=="unlatch"){
    digitalWrite(A_dir1, LOW);
    digitalWrite(A_dir2, HIGH);
    digitalWrite(B_dir1, LOW);
    digitalWrite(B_dir2, HIGH);
  }
}
