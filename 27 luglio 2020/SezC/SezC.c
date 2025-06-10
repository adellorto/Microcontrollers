
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

//Variabili da passare alla ISR
unsigned int voltage = 0;
unsigned int el_time = 0;
unsigned int dec = 0;


void main() {


unsigned short int stato_accensione = 0, store_c0 = 0;                                      //Variabili sezione A
unsigned short int velocita_motore = 0, store_c3 = 0, store_c4 = 0;                         //Variabili sezione B
char txt[7], temperature[17];                                                       //Variabili sezione C


TRISC = 255;
ANSELC = 0b11100110;

TRISA = 0b11101111;
ANSELA = 255;
TRISD = 0;


//Setup PWM DRIVER MOTORE
TRISE.TRISE2 = 1;
CCPTMRS1.C5TSEL0 = 1;
CCPTMRS1.C5TSEL1 = 0; //Timer 4
PR4 = 8;
CCP5CON = 0b00000001;
T4CON = 0b00000110;
TRISE.TRISE2 = 0;

//Setup INTERRUPT
INTCON = 0b11100000;

//Setup TIMER0
T0CON = 0b11000111;

//Setup ADC
ADCON0 = 0b00000001;
ADCON2 = 0b00100001;
PIE1.ADIE = 1;
PIR1.ADIF = 0;



// -----------LCD Initialization---------
Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)

Lcd_Cmd(_LCD_CLEAR);    	// Clear display
Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
Lcd_Out(1,1,"SPENTO");
// --------------------------------------




while(1){


//Firmware ACCENSIONE e SPEGNIMENTO
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
        ADCON0.GO_NOT_DONE = 1;
        Lcd_Out(1,1,"ACCESO");
    }
    store_c0 = 1;
}
else if(store_c0 == 1 && PORTC.RC0 == 0)
    store_c0 = 0;




if(stato_accensione){

//Firmware INCREMENTO e DECREMENTO velocità motore
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
//Firmware PWM
CCPR5L = velocita_motore;



//Firmware ADC
if(el_time >= 300){

    voltage = voltage*20;
    dec = voltage%1000;
    voltage = ((voltage/1000)<<3) + 10;
    dec = (dec<<3);
    voltage = voltage + dec/1000;
    dec = (dec%1000)/100;



    IntToStr(voltage, txt);
    temperature[0] = txt[4];
    temperature[1] = txt[5];
    temperature[2] = 0;
    strcat(temperature, ",");
    IntToStr(dec, txt);
    txt[0] = txt[5];
    txt[1] = 0;
    strcat(temperature,txt);
    Lcd_Out(2,1,temperature);

    el_time -= 300;
    ADCON0.GO_NOT_DONE = 1;
}




}


}


void interrupt(){

    if(INTCON.TMR0IF){

        el_time += 32;
        INTCON.TMR0IF = 0;
    }

    if(PIR1.ADIF){


        voltage = ADRESH;
        PIR1.ADIF = 0;
    }




}