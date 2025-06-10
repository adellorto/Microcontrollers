
_main:

;SezA.c,21 :: 		void main() {
;SezA.c,25 :: 		TRISA = 255;
	MOVLW       255
	MOVWF       TRISA+0 
;SezA.c,26 :: 		ANSELA = 255;
	MOVLW       255
	MOVWF       ANSELA+0 
;SezA.c,30 :: 		ADCON0 = 0b00000001;
	MOVLW       1
	MOVWF       ADCON0+0 
;SezA.c,31 :: 		ADCON2 = 0b00100001;
	MOVLW       33
	MOVWF       ADCON2+0 
;SezA.c,34 :: 		INTCON = 0b11000000;
	MOVLW       192
	MOVWF       INTCON+0 
;SezA.c,35 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;SezA.c,36 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;SezA.c,40 :: 		Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
	CALL        _Lcd_Init+0, 0
;SezA.c,42 :: 		Lcd_Cmd(_LCD_CLEAR);    	// Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SezA.c,43 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SezA.c,47 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;SezA.c,49 :: 		while(1){
L_main0:
;SezA.c,51 :: 		if(adc_flag){
	MOVF        _adc_flag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main2
;SezA.c,54 :: 		IntToStr((int)value,s);
	MOVF        _value+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_s_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_s_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;SezA.c,55 :: 		s[0] = s[3];
	MOVF        main_s_L0+3, 0 
	MOVWF       main_s_L0+0 
;SezA.c,56 :: 		s[1] = s[4];
	MOVF        main_s_L0+4, 0 
	MOVWF       main_s_L0+1 
;SezA.c,57 :: 		s[2] = s[5];
	MOVF        main_s_L0+5, 0 
	MOVWF       main_s_L0+2 
;SezA.c,58 :: 		s[3] = 0;
	CLRF        main_s_L0+3 
;SezA.c,59 :: 		strcpy(txt, s);
	MOVLW       main_txt_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       main_s_L0+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(main_s_L0+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SezA.c,60 :: 		strcat(txt," +   9 = ");
	MOVLW       main_txt_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr1_SezA+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr1_SezA+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SezA.c,63 :: 		IntToStr(value+9,s);
	MOVLW       9
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
;SezA.c,64 :: 		s[0] = ' ';
	MOVLW       32
	MOVWF       main_s_L0+0 
;SezA.c,65 :: 		s[1] = s[3];
	MOVF        main_s_L0+3, 0 
	MOVWF       main_s_L0+1 
;SezA.c,66 :: 		s[2] = s[4];
	MOVF        main_s_L0+4, 0 
	MOVWF       main_s_L0+2 
;SezA.c,67 :: 		s[3] = s[5];
	MOVF        main_s_L0+5, 0 
	MOVWF       main_s_L0+3 
;SezA.c,68 :: 		s[4] = 0;
	CLRF        main_s_L0+4 
;SezA.c,69 :: 		strcat(txt, s);
	MOVLW       main_txt_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       main_s_L0+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(main_s_L0+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SezA.c,70 :: 		Lcd_Out(1,1,txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezA.c,73 :: 		adc_flag = 0;
	CLRF        _adc_flag+0 
;SezA.c,74 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;SezA.c,75 :: 		}
L_main2:
;SezA.c,77 :: 		}
	GOTO        L_main0
;SezA.c,80 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;SezA.c,84 :: 		void interrupt(){
;SezA.c,86 :: 		if(PIR1.ADIF){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt3
;SezA.c,88 :: 		value = ADRESH;
	MOVF        ADRESH+0, 0 
	MOVWF       _value+0 
;SezA.c,89 :: 		adc_flag = 1;
	MOVLW       1
	MOVWF       _adc_flag+0 
;SezA.c,90 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;SezA.c,91 :: 		}
L_interrupt3:
;SezA.c,93 :: 		}
L_end_interrupt:
L__interrupt6:
	RETFIE      1
; end of _interrupt
