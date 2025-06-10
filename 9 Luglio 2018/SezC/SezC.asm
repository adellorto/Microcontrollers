
_main:

;SezC.c,21 :: 		void main() {
;SezC.c,23 :: 		unsigned short int timer_value = 30;    //Sezione A
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
;SezC.c,29 :: 		TRISD = 0;
	CLRF        TRISD+0 
;SezC.c,30 :: 		TRISE.RE2 = 0;
	BCF         TRISE+0, 2 
;SezC.c,33 :: 		TRISA = 255;
	MOVLW       255
	MOVWF       TRISA+0 
;SezC.c,34 :: 		ANSELA = 0b11110000;
	MOVLW       240
	MOVWF       ANSELA+0 
;SezC.c,37 :: 		TRISC = 0b10111111;
	MOVLW       191
	MOVWF       TRISC+0 
;SezC.c,38 :: 		ANSELC = 0b11111011;
	MOVLW       251
	MOVWF       ANSELC+0 
;SezC.c,41 :: 		INTCON = 0b11100000;
	MOVLW       224
	MOVWF       INTCON+0 
;SezC.c,44 :: 		T0CON = 0b01000111;
	MOVLW       71
	MOVWF       T0CON+0 
;SezC.c,47 :: 		CCP1CON = 0b00000101;
	MOVLW       5
	MOVWF       CCP1CON+0 
;SezC.c,48 :: 		CCPTMRS1.C1TSEL0 = 0;
	BCF         CCPTMRS1+0, 0 
;SezC.c,49 :: 		CCPTMRS1.C1TSEL1 = 0;
	BCF         CCPTMRS1+0, 1 
;SezC.c,50 :: 		PIE1.CCP1IE = 1;
	BSF         PIE1+0, 2 
;SezC.c,51 :: 		PIR1.CCP1IF = 0;
	BCF         PIR1+0, 2 
;SezC.c,52 :: 		T1CON = 0b00010011;
	MOVLW       19
	MOVWF       T1CON+0 
;SezC.c,55 :: 		Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
	CALL        _Lcd_Init+0, 0
;SezC.c,57 :: 		Lcd_Cmd(_LCD_CLEAR);    	// Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SezC.c,58 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SezC.c,60 :: 		LATC.RC6 = 1;
	BSF         LATC+0, 6 
;SezC.c,62 :: 		while(1){
L_main0:
;SezC.c,65 :: 		if(store_a0 == 0 && PORTA.RA0 == 1){
	MOVLW       0
	XORWF       main_store_a0_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main53
	MOVLW       0
	XORWF       main_store_a0_L0+0, 0 
L__main53:
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
	BTFSS       PORTA+0, 0 
	GOTO        L_main4
L__main51:
;SezC.c,66 :: 		T0CON.TMR0ON = 1;
	BSF         T0CON+0, 7 
;SezC.c,67 :: 		start = 1;
	MOVLW       1
	MOVWF       main_start_L0+0 
	MOVLW       0
	MOVWF       main_start_L0+1 
;SezC.c,68 :: 		store_a0 = 1;
	MOVLW       1
	MOVWF       main_store_a0_L0+0 
	MOVLW       0
	MOVWF       main_store_a0_L0+1 
;SezC.c,69 :: 		}
	GOTO        L_main5
L_main4:
;SezC.c,70 :: 		else if(store_a0 == 1 && PORTA.RA0 == 0)
	MOVLW       0
	XORWF       main_store_a0_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main54
	MOVLW       1
	XORWF       main_store_a0_L0+0, 0 
L__main54:
	BTFSS       STATUS+0, 2 
	GOTO        L_main8
	BTFSC       PORTA+0, 0 
	GOTO        L_main8
L__main50:
;SezC.c,71 :: 		store_a0 = 0;
	CLRF        main_store_a0_L0+0 
	CLRF        main_store_a0_L0+1 
L_main8:
L_main5:
;SezC.c,73 :: 		if(store_a1 == 0 && PORTA.RA1 == 1){
	MOVLW       0
	XORWF       main_store_a1_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main55
	MOVLW       0
	XORWF       main_store_a1_L0+0, 0 
L__main55:
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
	BTFSS       PORTA+0, 1 
	GOTO        L_main11
L__main49:
;SezC.c,74 :: 		T0CON.TMR0ON = 0;
	BCF         T0CON+0, 7 
;SezC.c,75 :: 		el_time = 0;
	CLRF        _el_time+0 
	CLRF        _el_time+1 
;SezC.c,76 :: 		start = 0;
	CLRF        main_start_L0+0 
	CLRF        main_start_L0+1 
;SezC.c,77 :: 		store_a1 = 1;
	MOVLW       1
	MOVWF       main_store_a1_L0+0 
	MOVLW       0
	MOVWF       main_store_a1_L0+1 
;SezC.c,78 :: 		}
	GOTO        L_main12
L_main11:
;SezC.c,79 :: 		else if(store_a1 == 1 && PORTA.RA1 == 0)
	MOVLW       0
	XORWF       main_store_a1_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main56
	MOVLW       1
	XORWF       main_store_a1_L0+0, 0 
L__main56:
	BTFSS       STATUS+0, 2 
	GOTO        L_main15
	BTFSC       PORTA+0, 1 
	GOTO        L_main15
L__main48:
;SezC.c,80 :: 		store_a1 = 0;
	CLRF        main_store_a1_L0+0 
	CLRF        main_store_a1_L0+1 
L_main15:
L_main12:
;SezC.c,82 :: 		if(store_a2 == 0 && PORTA.RA2 == 1){
	MOVLW       0
	XORWF       main_store_a2_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main57
	MOVLW       0
	XORWF       main_store_a2_L0+0, 0 
L__main57:
	BTFSS       STATUS+0, 2 
	GOTO        L_main18
	BTFSS       PORTA+0, 2 
	GOTO        L_main18
L__main47:
;SezC.c,83 :: 		if(timer_value<250)
	MOVLW       250
	SUBWF       main_timer_value_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main19
;SezC.c,84 :: 		timer_value += 5;
	MOVLW       5
	ADDWF       main_timer_value_L0+0, 1 
L_main19:
;SezC.c,85 :: 		store_a2 = 1;
	MOVLW       1
	MOVWF       main_store_a2_L0+0 
	MOVLW       0
	MOVWF       main_store_a2_L0+1 
;SezC.c,86 :: 		}
	GOTO        L_main20
L_main18:
;SezC.c,87 :: 		else if(store_a2 == 1 && PORTA.RA2 == 0)
	MOVLW       0
	XORWF       main_store_a2_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main58
	MOVLW       1
	XORWF       main_store_a2_L0+0, 0 
L__main58:
	BTFSS       STATUS+0, 2 
	GOTO        L_main23
	BTFSC       PORTA+0, 2 
	GOTO        L_main23
L__main46:
;SezC.c,88 :: 		store_a2 = 0;
	CLRF        main_store_a2_L0+0 
	CLRF        main_store_a2_L0+1 
L_main23:
L_main20:
;SezC.c,90 :: 		if(store_a3 == 0 && PORTA.RA3 == 1){
	MOVLW       0
	XORWF       main_store_a3_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main59
	MOVLW       0
	XORWF       main_store_a3_L0+0, 0 
L__main59:
	BTFSS       STATUS+0, 2 
	GOTO        L_main26
	BTFSS       PORTA+0, 3 
	GOTO        L_main26
L__main45:
;SezC.c,91 :: 		if(timer_value > 0)
	MOVF        main_timer_value_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main27
;SezC.c,92 :: 		timer_value -= 5;
	MOVLW       5
	SUBWF       main_timer_value_L0+0, 1 
L_main27:
;SezC.c,93 :: 		store_a3 = 1;
	MOVLW       1
	MOVWF       main_store_a3_L0+0 
	MOVLW       0
	MOVWF       main_store_a3_L0+1 
;SezC.c,94 :: 		}
	GOTO        L_main28
L_main26:
;SezC.c,95 :: 		else if(store_a3 == 1 && PORTA.RA3 == 0)
	MOVLW       0
	XORWF       main_store_a3_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main60
	MOVLW       1
	XORWF       main_store_a3_L0+0, 0 
L__main60:
	BTFSS       STATUS+0, 2 
	GOTO        L_main31
	BTFSC       PORTA+0, 3 
	GOTO        L_main31
L__main44:
;SezC.c,96 :: 		store_a3 = 0;
	CLRF        main_store_a3_L0+0 
	CLRF        main_store_a3_L0+1 
L_main31:
L_main28:
;SezC.c,100 :: 		if(el_time >= 1000){
	MOVLW       3
	SUBWF       _el_time+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main61
	MOVLW       232
	SUBWF       _el_time+0, 0 
L__main61:
	BTFSS       STATUS+0, 0 
	GOTO        L_main32
;SezC.c,102 :: 		if(timer_value >0 && start){
	MOVF        main_timer_value_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main35
	MOVF        main_start_L0+0, 0 
	IORWF       main_start_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main35
L__main43:
;SezC.c,103 :: 		timer_value--;
	DECF        main_timer_value_L0+0, 1 
;SezC.c,104 :: 		}
L_main35:
;SezC.c,105 :: 		if(timer_value == 0)
	MOVF        main_timer_value_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main36
;SezC.c,106 :: 		LATE.RE2 = 1;
	BSF         LATE+0, 2 
L_main36:
;SezC.c,108 :: 		LATD = timer_value;
	MOVF        main_timer_value_L0+0, 0 
	MOVWF       LATD+0 
;SezC.c,109 :: 		el_time -= 1000;
	MOVLW       232
	SUBWF       _el_time+0, 1 
	MOVLW       3
	SUBWFB      _el_time+1, 1 
;SezC.c,110 :: 		}
L_main32:
;SezC.c,112 :: 		delta = Tb - Ta;
	MOVF        _Ta+0, 0 
	SUBWF       _Tb+0, 0 
	MOVWF       R1 
	MOVF        _Ta+1, 0 
	SUBWFB      _Tb+1, 0 
	MOVWF       R2 
;SezC.c,114 :: 		if(delta>1000){
	MOVF        R2, 0 
	SUBLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L__main62
	MOVF        R1, 0 
	SUBLW       232
L__main62:
	BTFSC       STATUS+0, 0 
	GOTO        L_main37
;SezC.c,115 :: 		start = 0;
	CLRF        main_start_L0+0 
	CLRF        main_start_L0+1 
;SezC.c,116 :: 		Lcd_Out(1,1,"   Aborted    ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_SezC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_SezC+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezC.c,117 :: 		}
	GOTO        L_main38
L_main37:
;SezC.c,119 :: 		IntToStr((int) timer_value, timer);
	MOVF        main_timer_value_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_timer_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_timer_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;SezC.c,120 :: 		strcat(timer, " secondi");
	MOVLW       main_timer_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_timer_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr2_SezC+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr2_SezC+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SezC.c,121 :: 		Lcd_Out(1,1, timer);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_timer_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_timer_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezC.c,122 :: 		}
L_main38:
;SezC.c,126 :: 		}
	GOTO        L_main0
;SezC.c,130 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;SezC.c,132 :: 		void interrupt(){
;SezC.c,134 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt39
;SezC.c,136 :: 		el_time += 32;
	MOVLW       32
	ADDWF       _el_time+0, 1 
	MOVLW       0
	ADDWFC      _el_time+1, 1 
;SezC.c,138 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;SezC.c,139 :: 		}
L_interrupt39:
;SezC.c,141 :: 		if(PIR1.CCP1IF){
	BTFSS       PIR1+0, 2 
	GOTO        L_interrupt40
;SezC.c,143 :: 		if(CCP1CON.CCP1M0){
	BTFSS       CCP1CON+0, 0 
	GOTO        L_interrupt41
;SezC.c,144 :: 		Ta = (CCPR1H<<8) + CCPR1L;
	MOVF        CCPR1H+0, 0 
	MOVWF       _Ta+1 
	CLRF        _Ta+0 
	MOVF        CCPR1L+0, 0 
	ADDWF       _Ta+0, 1 
	MOVLW       0
	ADDWFC      _Ta+1, 1 
;SezC.c,145 :: 		CCP1CON.CCP1M0 = 0;
	BCF         CCP1CON+0, 0 
;SezC.c,146 :: 		}
	GOTO        L_interrupt42
L_interrupt41:
;SezC.c,148 :: 		Tb = (CCPR1H<<8) + CCPR1L;
	MOVF        CCPR1H+0, 0 
	MOVWF       _Tb+1 
	CLRF        _Tb+0 
	MOVF        CCPR1L+0, 0 
	ADDWF       _Tb+0, 1 
	MOVLW       0
	ADDWFC      _Tb+1, 1 
;SezC.c,149 :: 		CCP1CON.CCP1M0 = 1;
	BSF         CCP1CON+0, 0 
;SezC.c,150 :: 		}
L_interrupt42:
;SezC.c,152 :: 		PIR1.CCP1IF = 0;
	BCF         PIR1+0, 2 
;SezC.c,153 :: 		}
L_interrupt40:
;SezC.c,155 :: 		}
L_end_interrupt:
L__interrupt64:
	RETFIE      1
; end of _interrupt
