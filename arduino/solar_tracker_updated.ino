//Ingeimaks
#include <Servo.h>
//definiamo i servomotori orizzontale e verticale
Servo servohori;
int servoh = 0;
int servohLimitHigh = 160;
int servohLimitLow = 60;

Servo servoverti; 
int servov = 0; 
int servovLimitHigh = 160;
int servovLimitLow = 60;
//Pin fotoresistenze
int ldrtopl = 0; //top left 
int ldrtopr = 1; //top right 
int ldrbotl = 2; // bottom left 
int ldrbotr = 3; // bottom right 

 void setup () 
 {
  servohori.attach(10);
  servohori.write(60);
  servoverti.attach(9);
  servoverti.write(60);
  Serial.begin(9600);
  delay(500);
  
 }

void loop()
{
  servoh = servohori.read();
  servov = servoverti.read();
  //Valore Analogico delle fotoresistenza
  int topl = analogRead(ldrtopl);
  int topr = analogRead(ldrtopr);
  int botl = analogRead(ldrbotl);
  int botr = analogRead(ldrbotr);
  // Calcoliamo una Media
  int avgtop = (topl + topr) ; //average of top 
  int avgbot = (botl + botr) ; //average of bottom 
  int avgleft = (topl + botl) ; //average of left 
  int avgright = (topr + botr) ; //average of right
   
  int top_bottom_diff = abs(avgtop - avgbot);
  int left_right_diff = abs(avgleft - avgright);
  Serial.println(top_bottom_diff);

  Serial.println(left_right_diff);

  Serial.println("-----------------------------");

  if (avgtop < avgbot && top_bottom_diff > 15)
  {
    servoverti.write(servov +1);
    if (servov > servovLimitHigh) 
     { 
      servov = servovLimitHigh;
     }
    delay(10);
  }
  else if (avgbot < avgtop && top_bottom_diff > 15)
  {
    servoverti.write(servov -1);
    if (servov < servovLimitLow)
  {
    servov = servovLimitLow;
  }
    delay(10);
  }
  else 
  {
    servoverti.write(servov);
  }
  
  if (avgleft > avgright && left_right_diff > 15)
  {
    servohori.write(servoh +1);
    if (servoh > servohLimitHigh)
    {
    servoh = servohLimitHigh;
    }
    delay(10);
  }
  else if (avgright > avgleft && left_right_diff > 15)
  {
    servohori.write(servoh -1);
    if (servoh < servohLimitLow)
     {
     servoh = servohLimitLow;
     }
    delay(10);
  }
  else 
  {
    servohori.write(servoh);
  }
  delay(200);
}
