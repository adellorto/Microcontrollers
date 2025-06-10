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
unsigned short int adc_flag = 0, value;

void main() {

char s[7], txt[17];
unsigned short int store_d[8] = {0, 0, 0, 0, 0, 0, 0, 0}, i = 0;

//Set GPIO Ports
TRISA = 255;
ANSELA = 255;

TRISC = 0;
ANSELC = 255;

TRISD = 255;
ANSELD = 0;


//Set ADC
ADCON0 = 0b00000001;
ADCON2 = 0b00100001;

//Set Interrupt
INTCON = 0b11100000;
PIE1.ADIE = 1;
PIR1.ADIF = 0;

//Set Timer0
T0CON = 0b11000111;


// -----------LCD Initialization---------
Lcd_Init();                // Init the display library (This will set also the PORTB Configuration)

Lcd_Cmd(_LCD_CLEAR);            // Clear display
Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
// --------------------------------------


ADCON0.GO_NOT_DONE = 1;

LATC = 0;

while(1){

    
    //PORTC update
    for(i=0;i<8;i++){
        if(store_d[i] == 0 && (PORTD & (1<<i)) == (1<<i) ){
            LATC = LATC ^ (1<<i);
            store_d[i] = 1;
        }
        else if(store_d[i] == 1 && (PORTD & (1<<i)) == 0)
            store_d[i] = 0;
    }
    
    //ADC Value update
    if(el_time>=500 && adc_flag){

        adc_flag = 0;
        el_time -= 500;
        ADCON0.GO_NOT_DONE = 1;
    }


    // Stringa "xxx + yyy = "
    IntToStr((int)value,s);
    s[0] = s[3];
    s[1] = s[4];
    s[2] = s[5];
    s[3] = 0;
    strcpy(txt, s);
    strcat(txt, " + ");
    IntToStr((int)LATC,s);
    s[0] = s[3];
    s[1] = s[4];
    s[2] = s[5];
    s[3] = 0;
    strcat(txt,s);
    strcat(txt, " = ");

    // Risultato e completamento stringa "xxx + yyy = zzzz"
    IntToStr(value+LATC,s);
    s[0] = ' ';
    s[1] = s[3];
    s[2] = s[4];
    s[3] = s[5];
    s[4] = 0;
    strcat(txt, s);
    Lcd_Out(1,1,txt);

}


}



void interrupt(){

    if(PIR1.ADIF){

        value = ADRESH;
        adc_flag = 1;
        PIR1.ADIF = 0;
    }

    if(INTCON.TMR0IF){
        el_time += 32;
        INTCON.TMR0IF = 0;
    }

}