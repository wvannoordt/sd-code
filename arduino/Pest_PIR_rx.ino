#include <nRF24L01.h>
#include <RF24_config.h>
#include <SPI.h>
#include <RF24.h>
#include "printf.h"
const int LED1=7;

#define RF_CS 9
#define RF_CSN 10
RF24 radio(RF_CS, RF_CSN);
const uint64_t pipes[2] = { 0xe7e7e7e7e7LL, 0xc2c2c2c2c2LL };

void setup(){
  Serial.begin(9600);
  printf_begin();
  radio.begin();
  radio.openWritingPipe(pipes[1]);    // note that our pipes are the same above, but that
  radio.openReadingPipe(1, pipes[0]); // they are flipped between rx and tx sides.
  radio.startListening();
  radio.printDetails();
  
  pinMode(LED1, OUTPUT);
  digitalWrite(LED1, LOW);
  delay(1000);
}

void loop(){
  if (radio.available()) {
    uint8_t rx_data[32];  // we'll receive a 32 byte packet
    bool done = false;
    while (!done) {
      done = radio.read( &rx_data, sizeof(rx_data) );
    }
    radio.stopListening();

  if(rx_data[0] == 6){
    for(int i=0;i<3;i++){
      digitalWrite(LED1, HIGH);
      delay(200);
      digitalWrite(LED1, LOW);
      delay(200);
    }
  }
     radio.startListening();
  }
}


