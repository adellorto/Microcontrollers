
_main:

;SezioneB.c,18 :: 		void main() {
;SezioneB.c,20 :: 		unsigned short int stato_accensione = 0, store_c0 = 0;                                //Sezione A
	CLRF        main_stato_accensione_L0+0 
	CLRF        main_store_c0_L0+0 
	MOVLW       25
	MOVWF       main_setpoint_temperatura_L0+0 
	CLRF        main_store_c3_L0+0 
	CLRF        main_store_c4_L0+0 
;SezioneB.c,26 :: 		TRISC.TRISC0 = 1;
	BSF         TRISC+0, 0 
;SezioneB.c,27 :: 		TRISE.TRISE2 = 0;
	BCF         TRISE+0, 2 
;SezioneB.c,31 :: 		TRISC.TRISC3 = 1;
	BSF         TRISC+0, 3 
;SezioneB.c,32 :: 		TRISC.TRISC4 = 1;
	BSF         TRISC+0, 4 
;SezioneB.c,33 :: 		ANSELC.ANSC3 = 0;
	BCF         ANSELC+0, 3 
;SezioneB.c,34 :: 		ANSELC.ANSC4 = 0;
	BCF         ANSELC+0, 4 
;SezioneB.c,38 :: 		Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
	CALL        _Lcd_Init+0, 0
;SezioneB.c,40 :: 		Lcd_Cmd(_LCD_CLEAR);    	// Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SezioneB.c,41 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SezioneB.c,44 :: 		Lcd_Out(1,1,"SPENTO");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_SezioneB+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_SezioneB+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezioneB.c,45 :: 		IntToStr((int) setpoint_temperatura,txt);
	MOVF        main_setpoint_temperatura_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;SezioneB.c,46 :: 		Lcd_Out(2,1,txt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezioneB.c,48 :: 		while(1){
L_main0:
;SezioneB.c,53 :: 		if(store_c0 == 0 && PORTC.RC0 == 1){
	MOVF        main_store_c0_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
	BTFSS       PORTC+0, 0 
	GOTO        L_main4
L__main34:
;SezioneB.c,54 :: 		if(stato_accensione){
	MOVF        main_stato_accensione_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main5
;SezioneB.c,55 :: 		stato_accensione = 0;
	CLRF        main_stato_accensione_L0+0 
;SezioneB.c,56 :: 		Lcd_Out(1,1,"SPENTO");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_SezioneB+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_SezioneB+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezioneB.c,57 :: 		}
	GOTO        L_main6
L_main5:
;SezioneB.c,59 :: 		stato_accensione = 1;
	MOVLW       1
	MOVWF       main_stato_accensione_L0+0 
;SezioneB.c,60 :: 		Lcd_Out(1,1,"ACCESO");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_SezioneB+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_SezioneB+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezioneB.c,61 :: 		}
L_main6:
;SezioneB.c,62 :: 		store_c0 = 1;
	MOVLW       1
	MOVWF       main_store_c0_L0+0 
;SezioneB.c,63 :: 		}
	GOTO        L_main7
L_main4:
;SezioneB.c,64 :: 		else if(store_c0 == 1 && PORTC.RC0 == 0)
	MOVF        main_store_c0_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
	BTFSC       PORTC+0, 0 
	GOTO        L_main10
L__main33:
;SezioneB.c,65 :: 		store_c0 = 0;
	CLRF        main_store_c0_L0+0 
L_main10:
L_main7:
;SezioneB.c,67 :: 		LATE.LATE2 = stato_accensione;
	BTFSC       main_stato_accensione_L0+0, 0 
	GOTO        L__main36
	BCF         LATE+0, 2 
	GOTO        L__main37
L__main36:
	BSF         LATE+0, 2 
L__main37:
;SezioneB.c,70 :: 		if(stato_accensione){
	MOVF        main_stato_accensione_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
;SezioneB.c,75 :: 		if(store_c3 == 0 && PORTC.RC3 == 1){
	MOVF        main_store_c3_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main14
	BTFSS       PORTC+0, 3 
	GOTO        L_main14
L__main32:
;SezioneB.c,76 :: 		if(setpoint_temperatura<255)
	MOVLW       255
	SUBWF       main_setpoint_temperatura_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main15
;SezioneB.c,77 :: 		setpoint_temperatura++;
	INCF        main_setpoint_temperatura_L0+0, 1 
L_main15:
;SezioneB.c,78 :: 		IntToStr((int) setpoint_temperatura,txt);
	MOVF        main_setpoint_temperatura_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;SezioneB.c,79 :: 		Lcd_Out(2,1,txt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezioneB.c,80 :: 		store_c3 = 1;
	MOVLW       1
	MOVWF       main_store_c3_L0+0 
;SezioneB.c,81 :: 		}
	GOTO        L_main16
L_main14:
;SezioneB.c,82 :: 		else if(store_c3 == 1 && PORTC.RC3 == 0)
	MOVF        main_store_c3_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main19
	BTFSC       PORTC+0, 3 
	GOTO        L_main19
L__main31:
;SezioneB.c,83 :: 		store_c3 = 0;
	CLRF        main_store_c3_L0+0 
L_main19:
L_main16:
;SezioneB.c,85 :: 		if(store_c4 == 0 && PORTC.RC4 == 1){
	MOVF        main_store_c4_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main22
	BTFSS       PORTC+0, 4 
	GOTO        L_main22
L__main30:
;SezioneB.c,86 :: 		if(setpoint_temperatura>0)
	MOVF        main_setpoint_temperatura_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main23
;SezioneB.c,87 :: 		setpoint_temperatura--;
	DECF        main_setpoint_temperatura_L0+0, 1 
L_main23:
;SezioneB.c,88 :: 		IntToStr((int) setpoint_temperatura,txt);
	MOVF        main_setpoint_temperatura_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;SezioneB.c,89 :: 		Lcd_Out(2,1,txt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezioneB.c,90 :: 		store_c4 = 1;
	MOVLW       1
	MOVWF       main_store_c4_L0+0 
;SezioneB.c,91 :: 		}
	GOTO        L_main24
L_main22:
;SezioneB.c,92 :: 		else if(store_c4 == 1 && PORTC.RC4 == 0)
	MOVF        main_store_c4_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main27
	BTFSC       PORTC+0, 4 
	GOTO        L_main27
L__main29:
;SezioneB.c,93 :: 		store_c4 = 0;
	CLRF        main_store_c4_L0+0 
L_main27:
L_main24:
;SezioneB.c,99 :: 		}
	GOTO        L_main28
L_main11:
;SezioneB.c,101 :: 		setpoint_temperatura = 25;
	MOVLW       25
	MOVWF       main_setpoint_temperatura_L0+0 
;SezioneB.c,102 :: 		}
L_main28:
;SezioneB.c,109 :: 		}
	GOTO        L_main0
;SezioneB.c,114 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
