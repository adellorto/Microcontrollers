
_main:

;SezB.c,20 :: 		void main() {
;SezB.c,22 :: 		unsigned short int timer_value = 30;    //Sezione A
	MOVLW       30
	MOVWF       main_timer_value_L0+0 
	CLRF        main_store_a0_L0+0 
	CLRF        main_store_a0_L0+1 
	CLRF        main_store_a1_L0+0 
	CLRF        main_store_a1_L0+1 
	CLRF        main_store_a2_L0+0 
	CLRF        main_store_a2_L0+1 
	CLRF        main_store_a3_L0+0 
	CLRF        main_store_a3_L0+1 
	CLRF        main_start_L0+0 
	CLRF        main_start_L0+1 
;SezB.c,27 :: 		TRISD = 0;
	CLRF        TRISD+0 
;SezB.c,28 :: 		TRISE.RE2 = 0;
	BCF         TRISE+0, 2 
;SezB.c,31 :: 		TRISA = 255;
	MOVLW       255
	MOVWF       TRISA+0 
;SezB.c,32 :: 		ANSELA = 0b11110000;
	MOVLW       240
	MOVWF       ANSELA+0 
;SezB.c,35 :: 		INTCON = 0b10100000;
	MOVLW       160
	MOVWF       INTCON+0 
;SezB.c,38 :: 		T0CON = 0b01000111;
	MOVLW       71
	MOVWF       T0CON+0 
;SezB.c,41 :: 		Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
	CALL        _Lcd_Init+0, 0
;SezB.c,43 :: 		Lcd_Cmd(_LCD_CLEAR);    	// Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SezB.c,44 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SezB.c,47 :: 		IntToStr((int) timer_value, timer);
	MOVF        main_timer_value_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_timer_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_timer_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;SezB.c,48 :: 		strcat(timer, " secondi");
	MOVLW       main_timer_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_timer_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr1_SezB+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr1_SezB+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SezB.c,49 :: 		Lcd_Out(1,1, timer);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_timer_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_timer_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezB.c,51 :: 		while(1){
L_main0:
;SezB.c,54 :: 		if(store_a0 == 0 && PORTA.RA0 == 1){
	MOVLW       0
	XORWF       main_store_a0_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main48
	MOVLW       0
	XORWF       main_store_a0_L0+0, 0 
L__main48:
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
	BTFSS       PORTA+0, 0 
	GOTO        L_main4
L__main46:
;SezB.c,55 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;SezB.c,56 :: 		start = 1;
	MOVLW       1
	MOVWF       main_start_L0+0 
	MOVLW       0
	MOVWF       main_start_L0+1 
;SezB.c,57 :: 		store_a0 = 1;
	MOVLW       1
	MOVWF       main_store_a0_L0+0 
	MOVLW       0
	MOVWF       main_store_a0_L0+1 
;SezB.c,58 :: 		}
	GOTO        L_main5
L_main4:
;SezB.c,59 :: 		else if(store_a0 == 1 && PORTA.RA0 == 0)
	MOVLW       0
	XORWF       main_store_a0_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main49
	MOVLW       1
	XORWF       main_store_a0_L0+0, 0 
L__main49:
	BTFSS       STATUS+0, 2 
	GOTO        L_main8
	BTFSC       PORTA+0, 0 
	GOTO        L_main8
L__main45:
;SezB.c,60 :: 		store_a0 = 0;
	CLRF        main_store_a0_L0+0 
	CLRF        main_store_a0_L0+1 
L_main8:
L_main5:
;SezB.c,62 :: 		if(store_a1 == 0 && PORTA.RA1 == 1){
	MOVLW       0
	XORWF       main_store_a1_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main50
	MOVLW       0
	XORWF       main_store_a1_L0+0, 0 
L__main50:
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
	BTFSS       PORTA+0, 1 
	GOTO        L_main11
L__main44:
;SezB.c,63 :: 		T0CON.TMR0ON = 0;
	BCF         T0CON+0, 7 
;SezB.c,64 :: 		el_time = 0;
	CLRF        _el_time+0 
	CLRF        _el_time+1 
;SezB.c,65 :: 		start = 0;
	CLRF        main_start_L0+0 
	CLRF        main_start_L0+1 
;SezB.c,66 :: 		store_a1 = 1;
	MOVLW       1
	MOVWF       main_store_a1_L0+0 
	MOVLW       0
	MOVWF       main_store_a1_L0+1 
;SezB.c,67 :: 		}
	GOTO        L_main12
L_main11:
;SezB.c,68 :: 		else if(store_a1 == 1 && PORTA.RA1 == 0)
	MOVLW       0
	XORWF       main_store_a1_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main51
	MOVLW       1
	XORWF       main_store_a1_L0+0, 0 
L__main51:
	BTFSS       STATUS+0, 2 
	GOTO        L_main15
	BTFSC       PORTA+0, 1 
	GOTO        L_main15
L__main43:
;SezB.c,69 :: 		store_a1 = 0;
	CLRF        main_store_a1_L0+0 
	CLRF        main_store_a1_L0+1 
L_main15:
L_main12:
;SezB.c,71 :: 		if(store_a2 == 0 && PORTA.RA2 == 1){
	MOVLW       0
	XORWF       main_store_a2_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main52
	MOVLW       0
	XORWF       main_store_a2_L0+0, 0 
L__main52:
	BTFSS       STATUS+0, 2 
	GOTO        L_main18
	BTFSS       PORTA+0, 2 
	GOTO        L_main18
L__main42:
;SezB.c,72 :: 		if(timer_value<250)
	MOVLW       250
	SUBWF       main_timer_value_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main19
;SezB.c,73 :: 		timer_value += 5;
	MOVLW       5
	ADDWF       main_timer_value_L0+0, 1 
L_main19:
;SezB.c,74 :: 		store_a2 = 1;
	MOVLW       1
	MOVWF       main_store_a2_L0+0 
	MOVLW       0
	MOVWF       main_store_a2_L0+1 
;SezB.c,75 :: 		}
	GOTO        L_main20
L_main18:
;SezB.c,76 :: 		else if(store_a2 == 1 && PORTA.RA2 == 0)
	MOVLW       0
	XORWF       main_store_a2_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main53
	MOVLW       1
	XORWF       main_store_a2_L0+0, 0 
L__main53:
	BTFSS       STATUS+0, 2 
	GOTO        L_main23
	BTFSC       PORTA+0, 2 
	GOTO        L_main23
L__main41:
;SezB.c,77 :: 		store_a2 = 0;
	CLRF        main_store_a2_L0+0 
	CLRF        main_store_a2_L0+1 
L_main23:
L_main20:
;SezB.c,79 :: 		if(store_a3 == 0 && PORTA.RA3 == 1){
	MOVLW       0
	XORWF       main_store_a3_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main54
	MOVLW       0
	XORWF       main_store_a3_L0+0, 0 
L__main54:
	BTFSS       STATUS+0, 2 
	GOTO        L_main26
	BTFSS       PORTA+0, 3 
	GOTO        L_main26
L__main40:
;SezB.c,80 :: 		if(timer_value > 0)
	MOVF        main_timer_value_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main27
;SezB.c,81 :: 		timer_value -= 5;
	MOVLW       5
	SUBWF       main_timer_value_L0+0, 1 
L_main27:
;SezB.c,82 :: 		store_a3 = 1;
	MOVLW       1
	MOVWF       main_store_a3_L0+0 
	MOVLW       0
	MOVWF       main_store_a3_L0+1 
;SezB.c,83 :: 		}
	GOTO        L_main28
L_main26:
;SezB.c,84 :: 		else if(store_a3 == 1 && PORTA.RA3 == 0)
	MOVLW       0
	XORWF       main_store_a3_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main55
	MOVLW       1
	XORWF       main_store_a3_L0+0, 0 
L__main55:
	BTFSS       STATUS+0, 2 
	GOTO        L_main31
	BTFSC       PORTA+0, 3 
	GOTO        L_main31
L__main39:
;SezB.c,85 :: 		store_a3 = 0;
	CLRF        main_store_a3_L0+0 
	CLRF        main_store_a3_L0+1 
L_main31:
L_main28:
;SezB.c,89 :: 		if(el_time >= 1000){
	MOVLW       3
	SUBWF       _el_time+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main56
	MOVLW       232
	SUBWF       _el_time+0, 0 
L__main56:
	BTFSS       STATUS+0, 0 
	GOTO        L_main32
;SezB.c,91 :: 		if(timer_value >0 && start){
	MOVF        main_timer_value_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main35
	MOVF        main_start_L0+0, 0 
	IORWF       main_start_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main35
L__main38:
;SezB.c,92 :: 		timer_value--;
	DECF        main_timer_value_L0+0, 1 
;SezB.c,93 :: 		}
L_main35:
;SezB.c,94 :: 		if(timer_value == 0)
	MOVF        main_timer_value_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main36
;SezB.c,95 :: 		LATE.RE2 = 1;
	BSF         LATE+0, 2 
L_main36:
;SezB.c,97 :: 		LATD = timer_value;
	MOVF        main_timer_value_L0+0, 0 
	MOVWF       LATD+0 
;SezB.c,98 :: 		el_time -= 1000;
	MOVLW       232
	SUBWF       _el_time+0, 1 
	MOVLW       3
	SUBWFB      _el_time+1, 1 
;SezB.c,99 :: 		}
L_main32:
;SezB.c,102 :: 		IntToStr((int) timer_value, timer);
	MOVF        main_timer_value_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_timer_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_timer_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;SezB.c,103 :: 		strcat(timer, " secondi");
	MOVLW       main_timer_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_timer_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr2_SezB+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr2_SezB+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SezB.c,104 :: 		Lcd_Out(1,1, timer);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_timer_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_timer_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezB.c,109 :: 		}
	GOTO        L_main0
;SezB.c,113 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;SezB.c,115 :: 		void interrupt(){
;SezB.c,117 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt37
;SezB.c,119 :: 		el_time += 32;
	MOVLW       32
	ADDWF       _el_time+0, 1 
	MOVLW       0
	ADDWFC      _el_time+1, 1 
;SezB.c,121 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;SezB.c,122 :: 		}
L_interrupt37:
;SezB.c,124 :: 		}
L_end_interrupt:
L__interrupt58:
	RETFIE      1
; end of _interrupt
