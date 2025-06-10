
_main:

;SezB.c,21 :: 		void main() {
;SezB.c,24 :: 		unsigned short int store_d[8] = {0, 0, 0, 0, 0, 0, 0, 0}, i = 0;
	CLRF        main_store_d_L0+0 
	CLRF        main_store_d_L0+1 
	CLRF        main_store_d_L0+2 
	CLRF        main_store_d_L0+3 
	CLRF        main_store_d_L0+4 
	CLRF        main_store_d_L0+5 
	CLRF        main_store_d_L0+6 
	CLRF        main_store_d_L0+7 
	CLRF        main_i_L0+0 
;SezB.c,27 :: 		TRISA = 255;
	MOVLW       255
	MOVWF       TRISA+0 
;SezB.c,28 :: 		ANSELA = 255;
	MOVLW       255
	MOVWF       ANSELA+0 
;SezB.c,30 :: 		TRISC = 0;
	CLRF        TRISC+0 
;SezB.c,31 :: 		ANSELC = 255;
	MOVLW       255
	MOVWF       ANSELC+0 
;SezB.c,33 :: 		TRISD = 255;
	MOVLW       255
	MOVWF       TRISD+0 
;SezB.c,34 :: 		ANSELD = 0;
	CLRF        ANSELD+0 
;SezB.c,38 :: 		ADCON0 = 0b00000001;
	MOVLW       1
	MOVWF       ADCON0+0 
;SezB.c,39 :: 		ADCON2 = 0b00100001;
	MOVLW       33
	MOVWF       ADCON2+0 
;SezB.c,42 :: 		INTCON = 0b11100000;
	MOVLW       224
	MOVWF       INTCON+0 
;SezB.c,43 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;SezB.c,44 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;SezB.c,47 :: 		T0CON = 0b11000111;
	MOVLW       199
	MOVWF       T0CON+0 
;SezB.c,51 :: 		Lcd_Init();                // Init the display library (This will set also the PORTB Configuration)
	CALL        _Lcd_Init+0, 0
;SezB.c,53 :: 		Lcd_Cmd(_LCD_CLEAR);            // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SezB.c,54 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SezB.c,58 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;SezB.c,60 :: 		LATC = 0;
	CLRF        LATC+0 
;SezB.c,62 :: 		while(1){
L_main0:
;SezB.c,66 :: 		for(i=0;i<8;i++){
	CLRF        main_i_L0+0 
L_main2:
	MOVLW       8
	SUBWF       main_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main3
;SezB.c,67 :: 		if(store_d[i] == 0 && (PORTD & (1<<i)) == (1<<i) ){
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
;SezB.c,68 :: 		LATC = LATC ^ (1<<i);
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
;SezB.c,69 :: 		store_d[i] = 1;
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
;SezB.c,70 :: 		}
	GOTO        L_main8
L_main7:
;SezB.c,71 :: 		else if(store_d[i] == 1 && (PORTD & (1<<i)) == 0)
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
;SezB.c,72 :: 		store_d[i] = 0;
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
;SezB.c,66 :: 		for(i=0;i<8;i++){
	INCF        main_i_L0+0, 1 
;SezB.c,73 :: 		}
	GOTO        L_main2
L_main3:
;SezB.c,76 :: 		if(el_time>=500 && adc_flag){
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
;SezB.c,78 :: 		adc_flag = 0;
	CLRF        _adc_flag+0 
;SezB.c,79 :: 		el_time -= 500;
	MOVLW       244
	SUBWF       _el_time+0, 1 
	MOVLW       1
	SUBWFB      _el_time+1, 1 
;SezB.c,80 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;SezB.c,81 :: 		}
L_main14:
;SezB.c,85 :: 		IntToStr((int)value,s);
	MOVF        _value+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_s_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_s_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;SezB.c,86 :: 		s[0] = s[3];
	MOVF        main_s_L0+3, 0 
	MOVWF       main_s_L0+0 
;SezB.c,87 :: 		s[1] = s[4];
	MOVF        main_s_L0+4, 0 
	MOVWF       main_s_L0+1 
;SezB.c,88 :: 		s[2] = s[5];
	MOVF        main_s_L0+5, 0 
	MOVWF       main_s_L0+2 
;SezB.c,89 :: 		s[3] = 0;
	CLRF        main_s_L0+3 
;SezB.c,90 :: 		strcpy(txt, s);
	MOVLW       main_txt_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       main_s_L0+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(main_s_L0+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SezB.c,91 :: 		strcat(txt, " + ");
	MOVLW       main_txt_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr1_SezB+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr1_SezB+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SezB.c,92 :: 		IntToStr((int)LATC,s);
	MOVF        LATC+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_s_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_s_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;SezB.c,93 :: 		s[0] = s[3];
	MOVF        main_s_L0+3, 0 
	MOVWF       main_s_L0+0 
;SezB.c,94 :: 		s[1] = s[4];
	MOVF        main_s_L0+4, 0 
	MOVWF       main_s_L0+1 
;SezB.c,95 :: 		s[2] = s[5];
	MOVF        main_s_L0+5, 0 
	MOVWF       main_s_L0+2 
;SezB.c,96 :: 		s[3] = 0;
	CLRF        main_s_L0+3 
;SezB.c,97 :: 		strcat(txt,s);
	MOVLW       main_txt_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       main_s_L0+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(main_s_L0+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SezB.c,98 :: 		strcat(txt, " = ");
	MOVLW       main_txt_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr2_SezB+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr2_SezB+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SezB.c,101 :: 		IntToStr(value+LATC,s);
	MOVF        LATC+0, 0 
	ADDWF       _value+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	CLRF        FARG_IntToStr_input+1 
	MOVLW       0
	ADDWFC      FARG_IntToStr_input+1, 1 
	MOVLW       main_s_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_s_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;SezB.c,102 :: 		s[0] = ' ';
	MOVLW       32
	MOVWF       main_s_L0+0 
;SezB.c,103 :: 		s[1] = s[3];
	MOVF        main_s_L0+3, 0 
	MOVWF       main_s_L0+1 
;SezB.c,104 :: 		s[2] = s[4];
	MOVF        main_s_L0+4, 0 
	MOVWF       main_s_L0+2 
;SezB.c,105 :: 		s[3] = s[5];
	MOVF        main_s_L0+5, 0 
	MOVWF       main_s_L0+3 
;SezB.c,106 :: 		s[4] = 0;
	CLRF        main_s_L0+4 
;SezB.c,107 :: 		strcat(txt, s);
	MOVLW       main_txt_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       main_s_L0+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(main_s_L0+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SezB.c,108 :: 		Lcd_Out(1,1,txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezB.c,110 :: 		}
	GOTO        L_main0
;SezB.c,113 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;SezB.c,117 :: 		void interrupt(){
;SezB.c,119 :: 		if(PIR1.ADIF){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt15
;SezB.c,121 :: 		value = ADRESH;
	MOVF        ADRESH+0, 0 
	MOVWF       _value+0 
;SezB.c,122 :: 		adc_flag = 1;
	MOVLW       1
	MOVWF       _adc_flag+0 
;SezB.c,123 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;SezB.c,124 :: 		}
L_interrupt15:
;SezB.c,126 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt16
;SezB.c,127 :: 		el_time += 32;
	MOVLW       32
	ADDWF       _el_time+0, 1 
	MOVLW       0
	ADDWFC      _el_time+1, 1 
;SezB.c,128 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;SezB.c,129 :: 		}
L_interrupt16:
;SezB.c,131 :: 		}
L_end_interrupt:
L__interrupt31:
	RETFIE      1
; end of _interrupt
