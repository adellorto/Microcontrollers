
_main:

;SezA.c,19 :: 		void main() {
;SezA.c,21 :: 		unsigned short int timer_value = 10;
	MOVLW       10
	MOVWF       main_timer_value_L0+0 
;SezA.c,24 :: 		TRISD = 0;
	CLRF        TRISD+0 
;SezA.c,25 :: 		TRISE.RE2 = 0;
	BCF         TRISE+0, 2 
;SezA.c,27 :: 		INTCON = 0b10100000;
	MOVLW       160
	MOVWF       INTCON+0 
;SezA.c,28 :: 		T0CON = 0b11000111;
	MOVLW       199
	MOVWF       T0CON+0 
;SezA.c,31 :: 		Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
	CALL        _Lcd_Init+0, 0
;SezA.c,33 :: 		Lcd_Cmd(_LCD_CLEAR);    	// Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SezA.c,34 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SezA.c,36 :: 		IntToStr((int) timer_value, timer);
	MOVF        main_timer_value_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_timer_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_timer_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;SezA.c,37 :: 		strcat(timer, " secondi");
	MOVLW       main_timer_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_timer_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr1_SezA+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr1_SezA+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SezA.c,38 :: 		Lcd_Out(1,1, timer);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_timer_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_timer_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezA.c,40 :: 		while(1){
L_main0:
;SezA.c,45 :: 		if(el_time >= 1000){
	MOVLW       3
	SUBWF       _el_time+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main7
	MOVLW       232
	SUBWF       _el_time+0, 0 
L__main7:
	BTFSS       STATUS+0, 0 
	GOTO        L_main2
;SezA.c,47 :: 		if(timer_value >0){
	MOVF        main_timer_value_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main3
;SezA.c,48 :: 		timer_value--;
	DECF        main_timer_value_L0+0, 1 
;SezA.c,49 :: 		IntToStr((int) timer_value, timer);
	MOVF        main_timer_value_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_timer_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_timer_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;SezA.c,50 :: 		strcat(timer, " secondi");
	MOVLW       main_timer_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_timer_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr2_SezA+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr2_SezA+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SezA.c,51 :: 		Lcd_Out(1,1, timer);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_timer_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_timer_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezA.c,52 :: 		}
L_main3:
;SezA.c,53 :: 		if(timer_value == 0)
	MOVF        main_timer_value_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
;SezA.c,54 :: 		LATE.RE2 = 1;
	BSF         LATE+0, 2 
L_main4:
;SezA.c,56 :: 		LATD = timer_value;
	MOVF        main_timer_value_L0+0, 0 
	MOVWF       LATD+0 
;SezA.c,57 :: 		el_time -= 1000;
	MOVLW       232
	SUBWF       _el_time+0, 1 
	MOVLW       3
	SUBWFB      _el_time+1, 1 
;SezA.c,58 :: 		}
L_main2:
;SezA.c,63 :: 		}
	GOTO        L_main0
;SezA.c,67 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;SezA.c,69 :: 		void interrupt(){
;SezA.c,71 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt5
;SezA.c,73 :: 		el_time += 32;
	MOVLW       32
	ADDWF       _el_time+0, 1 
	MOVLW       0
	ADDWFC      _el_time+1, 1 
;SezA.c,75 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;SezA.c,76 :: 		}
L_interrupt5:
;SezA.c,78 :: 		}
L_end_interrupt:
L__interrupt9:
	RETFIE      1
; end of _interrupt
