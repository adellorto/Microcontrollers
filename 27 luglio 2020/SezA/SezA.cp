#line 1 "C:/Users/adell/MicroPIC/TdE - Reprise/27 luglio 2020/SezA/SezA.c"


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



void main() {

unsigned short int stato_accensione = 0, store_c0 = 0;

TRISC = 255;
ANSELC = 0b11111110;

TRISE = 0b11111011;
TRISA = 0b11101111;


Lcd_Init();

Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);
Lcd_Out(1,1,"SPENTO");



while(1){

if(store_c0 == 0 && PORTC.RC0 == 1){
 if(stato_accensione){
 stato_accensione = 0;
 LATA.RA4 = 0;
 LATE.RE2 = 0;
 Lcd_Out(1,1,"SPENTO");
 }
 else{
 stato_accensione = 1;
 LATA.RA4 = 1;
 LATE.RE2 = 1;
 Lcd_Out(1,1,"ACCESO");
 }
 store_c0 = 1;
}
else if(store_c0 == 1 && PORTC.RC0 == 0)
 store_c0 = 0;


}


}
