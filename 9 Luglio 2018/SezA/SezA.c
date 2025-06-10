// Lcd module connections
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
// End Lcd module connections

unsigned int el_time = 0;

void main() {

unsigned short int timer_value = 10;
char timer[15];

TRISD = 0;
TRISE.RE2 = 0;

INTCON = 0b10100000;
T0CON = 0b11000111;


Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)

Lcd_Cmd(_LCD_CLEAR);    	// Clear display
Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF

IntToStr((int) timer_value, timer);
strcat(timer, " secondi");
Lcd_Out(1,1, timer);

while(1){

    
    //delay_ms(300);

    if(el_time >= 1000){

        if(timer_value >0){
            timer_value--;
            IntToStr((int) timer_value, timer);
            strcat(timer, " secondi");
            Lcd_Out(1,1, timer);
        }
        if(timer_value == 0)
            LATE.RE2 = 1;

        LATD = timer_value;
        el_time -= 1000;
    }
    
    
    

}



}

void interrupt(){

    if(INTCON.TMR0IF){

        el_time += 32;

        INTCON.TMR0IF = 0;
    }

}