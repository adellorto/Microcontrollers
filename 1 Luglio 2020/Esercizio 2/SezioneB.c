
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

void main() {

unsigned short int stato_accensione = 0, store_c0 = 0;                                //Sezione A
unsigned short int setpoint_temperatura = 25, store_c3 = 0, store_c4 = 0;              //Sezione B
char txt[7];


//Buffer GPIO -- Sezione A
TRISC.TRISC0 = 1;
TRISE.TRISE2 = 0;


//Buffer GPIO -- Sezione B
TRISC.TRISC3 = 1;
TRISC.TRISC4 = 1;
ANSELC.ANSC3 = 0;
ANSELC.ANSC4 = 0;


// -----------LCD Initialization---------
Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)

Lcd_Cmd(_LCD_CLEAR);    	// Clear display
Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
// --------------------------------------

Lcd_Out(1,1,"SPENTO");
IntToStr((int) setpoint_temperatura,txt);
Lcd_Out(2,1,txt);

while(1){


    //Firmware ACCENDI/SPEGNI -- Sezione A

    if(store_c0 == 0 && PORTC.RC0 == 1){
        if(stato_accensione){
            stato_accensione = 0;
            Lcd_Out(1,1,"SPENTO");
        }
        else{
            stato_accensione = 1;
            Lcd_Out(1,1,"ACCESO");
        }
        store_c0 = 1;
    }
    else if(store_c0 == 1 && PORTC.RC0 == 0)
        store_c0 = 0;

    LATE.LATE2 = stato_accensione;


    if(stato_accensione){

    
        //Firmware INCREMENTA/DECREMENTA TEMPERATURA -- Sezione B

        if(store_c3 == 0 && PORTC.RC3 == 1){
            if(setpoint_temperatura<255)
                setpoint_temperatura++;
            IntToStr((int) setpoint_temperatura,txt);
            Lcd_Out(2,1,txt);
            store_c3 = 1;
        }
        else if(store_c3 == 1 && PORTC.RC3 == 0)
            store_c3 = 0;

        if(store_c4 == 0 && PORTC.RC4 == 1){
            if(setpoint_temperatura>0)
                setpoint_temperatura--;
            IntToStr((int) setpoint_temperatura,txt);
            Lcd_Out(2,1,txt);
            store_c4 = 1;
        }
        else if(store_c4 == 1 && PORTC.RC4 == 0)
            store_c4 = 0;

    
    
    
    
    }
    else{
        setpoint_temperatura = 25;
    }
    
    




}




}