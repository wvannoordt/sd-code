#include <nRF24L01.h>
#include <RF24_config.h>
#include <SPI.h>
#include <RF24.h>
#include "printf.h"

#define RF_CS 9
#define RF_CSN 10
RF24 radio(RF_CS, RF_CSN);
const uint64_t pipes[2] = { 0xe7e7e7e7e7LL, 0xc2c2c2c2c2LL };
uint8_t data[32];


const int PIR1=2;
const int PIR2=3;
int val1=0;
int val2=0;
int val3=0;
int val4=0;
int val5=0;
int val6=0;

int trig=1;

int tx_val=6;

void setup(){
  Serial.begin(9600);
  pinMode(PIR1,INPUT);
  pinMode(PIR2,INPUT);
  printf_begin();
  radio.begin();
  radio.openWritingPipe(pipes[0]);
  radio.openReadingPipe(1, pipes[1]);
  radio.printDetails();
}

void loop(){
  val1=digitalRead(PIR1);
//  val2=digitalRead(PIR2);
//  val3=digitalRead(PIR3);
//  val4=digitalRead(PIR4);
//  val5=digitalRead(PIR5);
//  val6=digitalRead(PIR6);

  if(val1 == trig || val2 == trig || val3 == trig || val4 == trig || val5 == trig || val6 == trig){
    data[0] = tx_val;
    radio.write( &data, sizeof(data) );
    Serial.println(tx_val);
    delay(4000);
  }
  delay(5);
}














