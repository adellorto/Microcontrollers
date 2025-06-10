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

//Variabili Globali
unsigned int el_time = 0;               //Sezione A
unsigned int Ta = 0, Tb = 0;            //Sezione C

void main() {

unsigned short int timer_value = 30;    //Sezione A
char timer[15];
unsigned store_a0 = 0, store_a1 = 0, store_a2 = 0, store_a3 = 0, start = 0;    //Sezione B
unsigned int delta = 0;                                                        //Sezione C

//Buffer digitali sezione A
TRISD = 0;
TRISE.RE2 = 0;

//Buffer digitali sezione B
TRISA = 255;
ANSELA = 0b11110000;

//Buffer digitali sezione C
TRISC = 0b10111111;
ANSELC = 0b11111011;

//Interrupt
INTCON = 0b11100000;

//TIMER0
T0CON = 0b01000111;

//CCP Compare
CCP1CON = 0b00000101;
CCPTMRS0.C1TSEL0 = 0;
CCPTMRS0.C1TSEL1 = 0;
PIE1.CCP1IE = 1;
PIR1.CCP1IF = 0;
T1CON = 0b00010011;


Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)

Lcd_Cmd(_LCD_CLEAR);    	// Clear display
Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF

LATC.RC6 = 1;

while(1){

    
    if(store_a0 == 0 && PORTA.RA0 == 1){
        T0CON.TMR0ON = 1;    
        start = 1;
        store_a0 = 1;
    }
    else if(store_a0 == 1 && PORTA.RA0 == 0)
        store_a0 = 0;

    if(store_a1 == 0 && PORTA.RA1 == 1){
        T0CON.TMR0ON = 0;
        el_time = 0;    
        start = 0;
        store_a1 = 1;
    }
    else if(store_a1 == 1 && PORTA.RA1 == 0)
        store_a1 = 0;

    if(store_a2 == 0 && PORTA.RA2 == 1){
        if(timer_value<250)
            timer_value += 5;
        store_a2 = 1;
    }
    else if(store_a2 == 1 && PORTA.RA2 == 0)
        store_a2 = 0;

    if(store_a3 == 0 && PORTA.RA3 == 1){
        if(timer_value > 0)
            timer_value -= 5;
        store_a3 = 1;
    }
    else if(store_a3 == 1 && PORTA.RA3 == 0)
        store_a3 = 0;

    

    if(el_time >= 1000){

        if(timer_value >0 && start){
            timer_value--;
        }
        if(timer_value == 0)
            LATE.RE2 = 1;

        LATD = timer_value;
        el_time -= 1000;
    }

    delta = Tb - Ta;

    if(delta>1000){
        start = 0;
        Lcd_Out(1,1,"   Aborted    ");
    }
    else{
        IntToStr((int) timer_value, timer);
        strcat(timer, " secondi");
        Lcd_Out(1,1, timer);
    }
    
    

}



}

void interrupt(){

    if(INTCON.TMR0IF){

        el_time += 32;

        INTCON.TMR0IF = 0;
    }

    if(PIR1.CCP1IF){

        if(CCP1CON.CCP1M0){
            Ta = (CCPR1H<<8) + CCPR1L; 
            CCP1CON.CCP1M0 = 0;
        }
        else{
            Tb = (CCPR1H<<8) + CCPR1L; 
            CCP1CON.CCP1M0 = 1;
        }

        PIR1.CCP1IF = 0;
    }

}