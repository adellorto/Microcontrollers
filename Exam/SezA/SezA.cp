#line 1 "C:/Users/adell/MicroPIC/Esame/SezA/SezA.c"

sbit LCD_RS at LATB4_bit;
sbit LCD_EN at LATB5_bit;
sbit LCD_D4 at LATB0_bit;
sbit LCD_D5 at LATB1_bit;
sbit LCD_D6 at LATB2_bit;
sbit LCD_D7 at LATB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;



unsigned short int value;
unsigned short int adc_flag = 0;

void main() {

char s[7], txt[17];

TRISA = 255;
ANSELA = 255;



ADCON0 = 0b00000001;
ADCON2 = 0b00100001;


INTCON = 0b11000000;
PIE1.ADIE = 1;
PIR1.ADIF = 0;



Lcd_Init();

Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);



ADCON0.GO_NOT_DONE = 1;

while(1){

 if(adc_flag){


 IntToStr((int)value,s);
 s[0] = s[3];
 s[1] = s[4];
 s[2] = s[5];
 s[3] = 0;
 strcpy(txt, s);
 strcat(txt," +   9 = ");


 IntToStr(value+9,s);
 s[0] = ' ';
 s[1] = s[3];
 s[2] = s[4];
 s[3] = s[5];
 s[4] = 0;
 strcat(txt, s);
 Lcd_Out(1,1,txt);


 adc_flag = 0;
 ADCON0.GO_NOT_DONE = 1;
 }

}


}



void interrupt(){

 if(PIR1.ADIF){

 value = ADRESH;
 adc_flag = 1;
 PIR1.ADIF = 0;
 }

}
