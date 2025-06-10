
_main:

;SezC.c,21 :: 		void main() {
;SezC.c,24 :: 		unsigned short int store_d[8] = {0, 0, 0, 0, 0, 0, 0, 0}, i = 0;
	CLRF        main_store_d_L0+0 
	CLRF        main_store_d_L0+1 
	CLRF        main_store_d_L0+2 
	CLRF        main_store_d_L0+3 
	CLRF        main_store_d_L0+4 
	CLRF        main_store_d_L0+5 
	CLRF        main_store_d_L0+6 
	CLRF        main_store_d_L0+7 
	CLRF        main_i_L0+0 
	CLRF        main_somma_L0+0 
	CLRF        main_somma_L0+1 
;SezC.c,28 :: 		TRISA = 255;
	MOVLW       255
	MOVWF       TRISA+0 
;SezC.c,29 :: 		ANSELA = 255;
	MOVLW       255
	MOVWF       ANSELA+0 
;SezC.c,31 :: 		TRISC = 0;
	CLRF        TRISC+0 
;SezC.c,32 :: 		ANSELC = 255;
	MOVLW       255
	MOVWF       ANSELC+0 
;SezC.c,34 :: 		TRISD = 255;
	MOVLW       255
	MOVWF       TRISD+0 
;SezC.c,35 :: 		ANSELD = 0;
	CLRF        ANSELD+0 
;SezC.c,39 :: 		ADCON0 = 0b00000001;
	MOVLW       1
	MOVWF       ADCON0+0 
;SezC.c,40 :: 		ADCON2 = 0b00100001;
	MOVLW       33
	MOVWF       ADCON2+0 
;SezC.c,43 :: 		INTCON = 0b11100000;
	MOVLW       224
	MOVWF       INTCON+0 
;SezC.c,44 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;SezC.c,45 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;SezC.c,48 :: 		T0CON = 0b11000111;
	MOVLW       199
	MOVWF       T0CON+0 
;SezC.c,51 :: 		TRISE.TRISE2 = 1;
	BSF         TRISE+0, 2 
;SezC.c,52 :: 		CCPTMRS1.C5TSEL0 = 1;
	BSF         CCPTMRS1+0, 2 
;SezC.c,53 :: 		CCPTMRS0.C5TSEL1 = 0;  //Timer4
	BCF         CCPTMRS0+0, 3 
;SezC.c,54 :: 		PR4 = 255;
	MOVLW       255
	MOVWF       PR4+0 
;SezC.c,55 :: 		CCP5CON = 0b00001100;
	MOVLW       12
	MOVWF       CCP5CON+0 
;SezC.c,56 :: 		T4CON = 0b00000110; //Prescaler 1:16
	MOVLW       6
	MOVWF       T4CON+0 
;SezC.c,57 :: 		TRISE.TRISE2 = 0;
	BCF         TRISE+0, 2 
;SezC.c,60 :: 		Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
	CALL        _Lcd_Init+0, 0
;SezC.c,62 :: 		Lcd_Cmd(_LCD_CLEAR);    	// Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SezC.c,63 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SezC.c,67 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;SezC.c,70 :: 		LATC = 0;
	CLRF        LATC+0 
;SezC.c,72 :: 		while(1){
L_main0:
;SezC.c,76 :: 		for(i=0;i<8;i++){
	CLRF        main_i_L0+0 
L_main2:
	MOVLW       8
	SUBWF       main_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main3
;SezC.c,77 :: 		if(store_d[i] == 0 && (PORTD & (1<<i)) == (1<<i) ){
	MOVLW       main_store_d_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_store_d_L0+0)
	MOVWF       FSR0L+1 
	MOVF        main_i_L0+0, 0 
	ADDWF       FSR0L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0L+1, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main7
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       1
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVF        R0, 0 
L__main21:
	BZ          L__main22
	RLCF        R3, 1 
	BCF         R3, 0 
	RLCF        R4, 1 
	ADDLW       255
	GOTO        L__main21
L__main22:
	MOVF        R3, 0 
	ANDWF       PORTD+0, 0 
	MOVWF       R1 
	MOVLW       0
	ANDWF       R4, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main23
	MOVF        R3, 0 
	XORWF       R1, 0 
L__main23:
	BTFSS       STATUS+0, 2 
	GOTO        L_main7
L__main19:
;SezC.c,78 :: 		LATC = LATC ^ (1<<i);
	MOVF        main_i_L0+0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__main24:
	BZ          L__main25
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__main24
L__main25:
	MOVF        R0, 0 
	XORWF       LATC+0, 1 
;SezC.c,79 :: 		store_d[i] = 1;
	MOVLW       main_store_d_L0+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(main_store_d_L0+0)
	MOVWF       FSR1L+1 
	MOVF        main_i_L0+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;SezC.c,80 :: 		}
	GOTO        L_main8
L_main7:
;SezC.c,81 :: 		else if(store_d[i] == 1 && (PORTD & (1<<i)) == 0)
	MOVLW       main_store_d_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_store_d_L0+0)
	MOVWF       FSR0L+1 
	MOVF        main_i_L0+0, 0 
	ADDWF       FSR0L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0L+1, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
	MOVF        main_i_L0+0, 0 
	MOVWF       R2 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__main26:
	BZ          L__main27
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__main26
L__main27:
	MOVF        R0, 0 
	ANDWF       PORTD+0, 0 
	MOVWF       R2 
	MOVLW       0
	ANDWF       R1, 0 
	MOVWF       R3 
	MOVLW       0
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main28
	MOVLW       0
	XORWF       R2, 0 
L__main28:
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
L__main18:
;SezC.c,82 :: 		store_d[i] = 0;
	MOVLW       main_store_d_L0+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(main_store_d_L0+0)
	MOVWF       FSR1L+1 
	MOVF        main_i_L0+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	CLRF        POSTINC1+0 
L_main11:
L_main8:
;SezC.c,76 :: 		for(i=0;i<8;i++){
	INCF        main_i_L0+0, 1 
;SezC.c,83 :: 		}
	GOTO        L_main2
L_main3:
;SezC.c,86 :: 		if(el_time>=500 && adc_flag){
	MOVLW       1
	SUBWF       _el_time+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main29
	MOVLW       244
	SUBWF       _el_time+0, 0 
L__main29:
	BTFSS       STATUS+0, 0 
	GOTO        L_main14
	MOVF        _adc_flag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main14
L__main17:
;SezC.c,88 :: 		adc_flag = 0;
	CLRF        _adc_flag+0 
;SezC.c,89 :: 		el_time -= 500;
	MOVLW       244
	SUBWF       _el_time+0, 1 
	MOVLW       1
	SUBWFB      _el_time+1, 1 
;SezC.c,90 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;SezC.c,91 :: 		}
L_main14:
;SezC.c,95 :: 		IntToStr((int)value,s);
	MOVF        _value+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_s_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_s_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;SezC.c,96 :: 		s[0] = s[3];
	MOVF        main_s_L0+3, 0 
	MOVWF       main_s_L0+0 
;SezC.c,97 :: 		s[1] = s[4];
	MOVF        main_s_L0+4, 0 
	MOVWF       main_s_L0+1 
;SezC.c,98 :: 		s[2] = s[5];
	MOVF        main_s_L0+5, 0 
	MOVWF       main_s_L0+2 
;SezC.c,99 :: 		s[3] = 0;
	CLRF        main_s_L0+3 
;SezC.c,100 :: 		strcpy(txt, s);
	MOVLW       main_txt_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       main_s_L0+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(main_s_L0+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SezC.c,101 :: 		strcat(txt, " + ");
	MOVLW       main_txt_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr1_SezC+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr1_SezC+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SezC.c,102 :: 		IntToStr((int)LATC,s);
	MOVF        LATC+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_s_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_s_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;SezC.c,103 :: 		s[0] = s[3];
	MOVF        main_s_L0+3, 0 
	MOVWF       main_s_L0+0 
;SezC.c,104 :: 		s[1] = s[4];
	MOVF        main_s_L0+4, 0 
	MOVWF       main_s_L0+1 
;SezC.c,105 :: 		s[2] = s[5];
	MOVF        main_s_L0+5, 0 
	MOVWF       main_s_L0+2 
;SezC.c,106 :: 		s[3] = 0;
	CLRF        main_s_L0+3 
;SezC.c,107 :: 		strcat(txt,s);
	MOVLW       main_txt_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       main_s_L0+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(main_s_L0+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SezC.c,108 :: 		strcat(txt, " = ");
	MOVLW       main_txt_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr2_SezC+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr2_SezC+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SezC.c,111 :: 		somma = value+LATC;
	MOVF        LATC+0, 0 
	ADDWF       _value+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       main_somma_L0+0 
	MOVF        R1, 0 
	MOVWF       main_somma_L0+1 
;SezC.c,112 :: 		IntToStr(somma,s);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_s_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_s_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;SezC.c,113 :: 		s[0] = ' ';
	MOVLW       32
	MOVWF       main_s_L0+0 
;SezC.c,114 :: 		s[1] = s[3];
	MOVF        main_s_L0+3, 0 
	MOVWF       main_s_L0+1 
;SezC.c,115 :: 		s[2] = s[4];
	MOVF        main_s_L0+4, 0 
	MOVWF       main_s_L0+2 
;SezC.c,116 :: 		s[3] = s[5];
	MOVF        main_s_L0+5, 0 
	MOVWF       main_s_L0+3 
;SezC.c,117 :: 		s[4] = 0;
	CLRF        main_s_L0+4 
;SezC.c,118 :: 		strcat(txt, s);
	MOVLW       main_txt_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       main_s_L0+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(main_s_L0+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SezC.c,119 :: 		Lcd_Out(1,1,txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezC.c,122 :: 		CCPR5L = somma>>1;
	MOVF        main_somma_L0+0, 0 
	MOVWF       R0 
	MOVF        main_somma_L0+1, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	MOVF        R0, 0 
	MOVWF       CCPR5L+0 
;SezC.c,124 :: 		}
	GOTO        L_main0
;SezC.c,127 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;SezC.c,131 :: 		void interrupt(){
;SezC.c,133 :: 		if(PIR1.ADIF){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt15
;SezC.c,135 :: 		value = ADRESH;
	MOVF        ADRESH+0, 0 
	MOVWF       _value+0 
;SezC.c,136 :: 		adc_flag = 1;
	MOVLW       1
	MOVWF       _adc_flag+0 
;SezC.c,137 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;SezC.c,138 :: 		}
L_interrupt15:
;SezC.c,140 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt16
;SezC.c,141 :: 		el_time += 32;
	MOVLW       32
	ADDWF       _el_time+0, 1 
	MOVLW       0
	ADDWFC      _el_time+1, 1 
;SezC.c,142 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;SezC.c,143 :: 		}
L_interrupt16:
;SezC.c,145 :: 		}
L_end_interrupt:
L__interrupt31:
	RETFIE      1
; end of _interrupt
