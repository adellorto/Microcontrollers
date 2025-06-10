
_main:

;SezC.c,24 :: 		void main() {
;SezC.c,27 :: 		unsigned short int stato_accensione = 0, store_c0 = 0;                                      //Variabili sezione A
	CLRF        main_stato_accensione_L0+0 
	CLRF        main_store_c0_L0+0 
	CLRF        main_velocita_motore_L0+0 
	CLRF        main_store_c3_L0+0 
	CLRF        main_store_c4_L0+0 
;SezC.c,32 :: 		TRISC = 255;
	MOVLW       255
	MOVWF       TRISC+0 
;SezC.c,33 :: 		ANSELC = 0b11100110;
	MOVLW       230
	MOVWF       ANSELC+0 
;SezC.c,35 :: 		TRISA = 0b11101111;
	MOVLW       239
	MOVWF       TRISA+0 
;SezC.c,36 :: 		ANSELA = 255;
	MOVLW       255
	MOVWF       ANSELA+0 
;SezC.c,37 :: 		TRISD = 0;
	CLRF        TRISD+0 
;SezC.c,41 :: 		TRISE.TRISE2 = 1;
	BSF         TRISE+0, 2 
;SezC.c,42 :: 		CCPTMRS1.C5TSEL0 = 1;
	BSF         CCPTMRS1+0, 2 
;SezC.c,43 :: 		CCPTMRS1.C5TSEL1 = 0; //Timer 4
	BCF         CCPTMRS1+0, 3 
;SezC.c,44 :: 		PR4 = 8;
	MOVLW       8
	MOVWF       PR4+0 
;SezC.c,45 :: 		CCP5CON = 0b00000001;
	MOVLW       1
	MOVWF       CCP5CON+0 
;SezC.c,46 :: 		T4CON = 0b00000110;
	MOVLW       6
	MOVWF       T4CON+0 
;SezC.c,47 :: 		TRISE.TRISE2 = 0;
	BCF         TRISE+0, 2 
;SezC.c,50 :: 		INTCON = 0b11100000;
	MOVLW       224
	MOVWF       INTCON+0 
;SezC.c,53 :: 		T0CON = 0b11000111;
	MOVLW       199
	MOVWF       T0CON+0 
;SezC.c,56 :: 		ADCON0 = 0b00000001;
	MOVLW       1
	MOVWF       ADCON0+0 
;SezC.c,57 :: 		ADCON2 = 0b00100001;
	MOVLW       33
	MOVWF       ADCON2+0 
;SezC.c,58 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;SezC.c,59 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;SezC.c,64 :: 		Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
	CALL        _Lcd_Init+0, 0
;SezC.c,66 :: 		Lcd_Cmd(_LCD_CLEAR);    	// Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SezC.c,67 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SezC.c,68 :: 		Lcd_Out(1,1,"SPENTO");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_SezC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_SezC+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezC.c,74 :: 		while(1){
L_main0:
;SezC.c,78 :: 		if(store_c0 == 0 && PORTC.RC0 == 1){
	MOVF        main_store_c0_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
	BTFSS       PORTC+0, 0 
	GOTO        L_main4
L__main36:
;SezC.c,79 :: 		if(stato_accensione){
	MOVF        main_stato_accensione_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main5
;SezC.c,80 :: 		stato_accensione = 0;
	CLRF        main_stato_accensione_L0+0 
;SezC.c,81 :: 		LATA.RA4 = 0;
	BCF         LATA+0, 4 
;SezC.c,82 :: 		velocita_motore = 0;
	CLRF        main_velocita_motore_L0+0 
;SezC.c,83 :: 		LATD = 0;
	CLRF        LATD+0 
;SezC.c,84 :: 		Lcd_Out(1,1,"SPENTO");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_SezC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_SezC+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezC.c,85 :: 		}
	GOTO        L_main6
L_main5:
;SezC.c,87 :: 		stato_accensione = 1;
	MOVLW       1
	MOVWF       main_stato_accensione_L0+0 
;SezC.c,88 :: 		LATA.RA4 = 1;
	BSF         LATA+0, 4 
;SezC.c,89 :: 		velocita_motore = 1;
	MOVLW       1
	MOVWF       main_velocita_motore_L0+0 
;SezC.c,90 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;SezC.c,91 :: 		Lcd_Out(1,1,"ACCESO");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_SezC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_SezC+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezC.c,92 :: 		}
L_main6:
;SezC.c,93 :: 		store_c0 = 1;
	MOVLW       1
	MOVWF       main_store_c0_L0+0 
;SezC.c,94 :: 		}
	GOTO        L_main7
L_main4:
;SezC.c,95 :: 		else if(store_c0 == 1 && PORTC.RC0 == 0)
	MOVF        main_store_c0_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
	BTFSC       PORTC+0, 0 
	GOTO        L_main10
L__main35:
;SezC.c,96 :: 		store_c0 = 0;
	CLRF        main_store_c0_L0+0 
L_main10:
L_main7:
;SezC.c,101 :: 		if(stato_accensione){
	MOVF        main_stato_accensione_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
;SezC.c,104 :: 		if(store_c3 == 0 && PORTC.RC3 == 1){
	MOVF        main_store_c3_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main14
	BTFSS       PORTC+0, 3 
	GOTO        L_main14
L__main34:
;SezC.c,105 :: 		if(velocita_motore<8)
	MOVLW       8
	SUBWF       main_velocita_motore_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main15
;SezC.c,106 :: 		velocita_motore++;
	INCF        main_velocita_motore_L0+0, 1 
L_main15:
;SezC.c,107 :: 		store_c3 = 1;
	MOVLW       1
	MOVWF       main_store_c3_L0+0 
;SezC.c,108 :: 		}
	GOTO        L_main16
L_main14:
;SezC.c,109 :: 		else if(store_c3 == 1 && PORTC.RC3 == 0)
	MOVF        main_store_c3_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main19
	BTFSC       PORTC+0, 3 
	GOTO        L_main19
L__main33:
;SezC.c,110 :: 		store_c3 = 0;
	CLRF        main_store_c3_L0+0 
L_main19:
L_main16:
;SezC.c,112 :: 		if(store_c4 == 0 && PORTC.RC4 == 1){
	MOVF        main_store_c4_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main22
	BTFSS       PORTC+0, 4 
	GOTO        L_main22
L__main32:
;SezC.c,113 :: 		if(velocita_motore>1)
	MOVF        main_velocita_motore_L0+0, 0 
	SUBLW       1
	BTFSC       STATUS+0, 0 
	GOTO        L_main23
;SezC.c,114 :: 		velocita_motore--;
	DECF        main_velocita_motore_L0+0, 1 
L_main23:
;SezC.c,115 :: 		store_c4 = 1;
	MOVLW       1
	MOVWF       main_store_c4_L0+0 
;SezC.c,116 :: 		}
	GOTO        L_main24
L_main22:
;SezC.c,117 :: 		else if(store_c4 == 1 && PORTC.RC4 == 0)
	MOVF        main_store_c4_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main27
	BTFSC       PORTC+0, 4 
	GOTO        L_main27
L__main31:
;SezC.c,118 :: 		store_c4 = 0;
	CLRF        main_store_c4_L0+0 
L_main27:
L_main24:
;SezC.c,120 :: 		LATD = (1<<velocita_motore) - 1;
	MOVF        main_velocita_motore_L0+0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__main38:
	BZ          L__main39
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__main38
L__main39:
	DECF        R0, 0 
	MOVWF       LATD+0 
;SezC.c,123 :: 		}
L_main11:
;SezC.c,125 :: 		CCPR5L = velocita_motore;
	MOVF        main_velocita_motore_L0+0, 0 
	MOVWF       CCPR5L+0 
;SezC.c,130 :: 		if(el_time >= 300){
	MOVLW       1
	SUBWF       _el_time+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main40
	MOVLW       44
	SUBWF       _el_time+0, 0 
L__main40:
	BTFSS       STATUS+0, 0 
	GOTO        L_main28
;SezC.c,132 :: 		voltage = voltage*20;
	MOVF        _voltage+0, 0 
	MOVWF       R0 
	MOVF        _voltage+1, 0 
	MOVWF       R1 
	MOVLW       20
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVF        R1, 0 
	MOVWF       FLOC__main+1 
	MOVF        FLOC__main+0, 0 
	MOVWF       _voltage+0 
	MOVF        FLOC__main+1, 0 
	MOVWF       _voltage+1 
;SezC.c,133 :: 		dec = voltage%1000;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FLOC__main+4 
	MOVF        R1, 0 
	MOVWF       FLOC__main+5 
	MOVF        FLOC__main+4, 0 
	MOVWF       _dec+0 
	MOVF        FLOC__main+5, 0 
	MOVWF       _dec+1 
;SezC.c,134 :: 		voltage = ((voltage/1000)<<3) + 10;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	MOVLW       10
	ADDWF       R2, 0 
	MOVWF       FLOC__main+0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FLOC__main+1 
	MOVF        FLOC__main+0, 0 
	MOVWF       _voltage+0 
	MOVF        FLOC__main+1, 0 
	MOVWF       _voltage+1 
;SezC.c,135 :: 		dec = (dec<<3);
	MOVF        FLOC__main+4, 0 
	MOVWF       FLOC__main+2 
	MOVF        FLOC__main+5, 0 
	MOVWF       FLOC__main+3 
	RLCF        FLOC__main+2, 1 
	BCF         FLOC__main+2, 0 
	RLCF        FLOC__main+3, 1 
	RLCF        FLOC__main+2, 1 
	BCF         FLOC__main+2, 0 
	RLCF        FLOC__main+3, 1 
	RLCF        FLOC__main+2, 1 
	BCF         FLOC__main+2, 0 
	RLCF        FLOC__main+3, 1 
	MOVF        FLOC__main+2, 0 
	MOVWF       _dec+0 
	MOVF        FLOC__main+3, 0 
	MOVWF       _dec+1 
;SezC.c,136 :: 		voltage = voltage + dec/1000;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        FLOC__main+2, 0 
	MOVWF       R0 
	MOVF        FLOC__main+3, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__main+0, 1 
	MOVF        R1, 0 
	ADDWFC      FLOC__main+1, 1 
	MOVF        FLOC__main+0, 0 
	MOVWF       _voltage+0 
	MOVF        FLOC__main+1, 0 
	MOVWF       _voltage+1 
;SezC.c,137 :: 		dec = (dec%1000)/100;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        FLOC__main+2, 0 
	MOVWF       R0 
	MOVF        FLOC__main+3, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _dec+0 
	MOVF        R1, 0 
	MOVWF       _dec+1 
;SezC.c,141 :: 		IntToStr(voltage, txt);
	MOVF        FLOC__main+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        FLOC__main+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;SezC.c,142 :: 		temperature[0] = txt[4];
	MOVF        main_txt_L0+4, 0 
	MOVWF       main_temperature_L0+0 
;SezC.c,143 :: 		temperature[1] = txt[5];
	MOVF        main_txt_L0+5, 0 
	MOVWF       main_temperature_L0+1 
;SezC.c,144 :: 		temperature[2] = 0;
	CLRF        main_temperature_L0+2 
;SezC.c,145 :: 		strcat(temperature, ",");
	MOVLW       main_temperature_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_temperature_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr4_SezC+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr4_SezC+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SezC.c,146 :: 		IntToStr(dec, txt);
	MOVF        _dec+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _dec+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;SezC.c,147 :: 		txt[0] = txt[5];
	MOVF        main_txt_L0+5, 0 
	MOVWF       main_txt_L0+0 
;SezC.c,148 :: 		txt[1] = 0;
	CLRF        main_txt_L0+1 
;SezC.c,149 :: 		strcat(temperature,txt);
	MOVLW       main_temperature_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_temperature_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SezC.c,150 :: 		Lcd_Out(2,1,temperature);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_temperature_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_temperature_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezC.c,152 :: 		el_time -= 300;
	MOVLW       44
	SUBWF       _el_time+0, 1 
	MOVLW       1
	SUBWFB      _el_time+1, 1 
;SezC.c,153 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;SezC.c,154 :: 		}
L_main28:
;SezC.c,159 :: 		}
	GOTO        L_main0
;SezC.c,162 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;SezC.c,165 :: 		void interrupt(){
;SezC.c,167 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt29
;SezC.c,169 :: 		el_time += 32;
	MOVLW       32
	ADDWF       _el_time+0, 1 
	MOVLW       0
	ADDWFC      _el_time+1, 1 
;SezC.c,170 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;SezC.c,171 :: 		}
L_interrupt29:
;SezC.c,173 :: 		if(PIR1.ADIF){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt30
;SezC.c,176 :: 		voltage = ADRESH;
	MOVF        ADRESH+0, 0 
	MOVWF       _voltage+0 
	MOVLW       0
	MOVWF       _voltage+1 
;SezC.c,177 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;SezC.c,178 :: 		}
L_interrupt30:
;SezC.c,183 :: 		}
L_end_interrupt:
L__interrupt42:
	RETFIE      1
; end of _interrupt
