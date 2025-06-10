#line 1 "C:/Users/adell/MicroPIC/TdE - Reprise/27 luglio 2020/SezB/SezB.c"


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
unsigned short int velocita_motore = 0, store_c3 = 0, store_c4 = 0;


TRISC = 255;
ANSELC = 0b11100110;

TRISA = 0b11101111;
TRISD = 0;



TRISE.TRISE2 = 1;
CCPTMRS1.C5TSEL0 = 1;
CCPTMRS1.C5TSEL1 = 0;
PR4 = 8;
CCP5CON = 0b00001111;
T4CON = 0b00000110;
TRISE.TRISE2 = 0;




Lcd_Init();

Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);
Lcd_Out(1,1,"SPENTO");



while(1){



if(store_c0 == 0 && PORTC.RC0 == 1){
 if(stato_accensione){
 stato_accensione = 0;
 LATA.RA4 = 0;
 velocita_motore = 0;
 LATD = 0;
 Lcd_Out(1,1,"SPENTO");
 }
 else{
 stato_accensione = 1;
 LATA.RA4 = 1;
 velocita_motore = 1;
 Lcd_Out(1,1,"ACCESO");
 }
 store_c0 = 1;
}
else if(store_c0 == 1 && PORTC.RC0 == 0)
 store_c0 = 0;




if(stato_accensione){


if(store_c3 == 0 && PORTC.RC3 == 1){
 if(velocita_motore<8)
 velocita_motore++;
 store_c3 = 1;
}
else if(store_c3 == 1 && PORTC.RC3 == 0)
 store_c3 = 0;

if(store_c4 == 0 && PORTC.RC4 == 1){
 if(velocita_motore>1)
 velocita_motore--;
 store_c4 = 1;
}
else if(store_c4 == 1 && PORTC.RC4 == 0)
 store_c4 = 0;

LATD = (1<<velocita_motore) - 1;


}

CCPR5L = velocita_motore;


}


}
