
_main:

;SezioneA.c,18 :: 		void main() {
;SezioneA.c,20 :: 		unsigned short int stato_accensione = 0, store_c0 = 0;
	CLRF        main_stato_accensione_L0+0 
	CLRF        main_store_c0_L0+0 
;SezioneA.c,22 :: 		TRISC.TRISC0 = 1;
	BSF         TRISC+0, 0 
;SezioneA.c,23 :: 		TRISE.TRISE2 = 0;
	BCF         TRISE+0, 2 
;SezioneA.c,26 :: 		Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
	CALL        _Lcd_Init+0, 0
;SezioneA.c,28 :: 		Lcd_Cmd(_LCD_CLEAR);    	// Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SezioneA.c,29 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SezioneA.c,32 :: 		Lcd_Out(1,1,"SPENTO");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_SezioneA+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_SezioneA+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezioneA.c,34 :: 		while(1){
L_main0:
;SezioneA.c,36 :: 		if(store_c0 == 0 && PORTC.RC0 == 1){
	MOVF        main_store_c0_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
	BTFSS       PORTC+0, 0 
	GOTO        L_main4
L__main12:
;SezioneA.c,37 :: 		if(stato_accensione){
	MOVF        main_stato_accensione_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main5
;SezioneA.c,38 :: 		stato_accensione = 0;
	CLRF        main_stato_accensione_L0+0 
;SezioneA.c,39 :: 		Lcd_Out(1,1,"SPENTO");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_SezioneA+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_SezioneA+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezioneA.c,40 :: 		}
	GOTO        L_main6
L_main5:
;SezioneA.c,42 :: 		stato_accensione = 1;
	MOVLW       1
	MOVWF       main_stato_accensione_L0+0 
;SezioneA.c,43 :: 		Lcd_Out(1,1,"ACCESO");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_SezioneA+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_SezioneA+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezioneA.c,44 :: 		}
L_main6:
;SezioneA.c,45 :: 		store_c0 = 1;
	MOVLW       1
	MOVWF       main_store_c0_L0+0 
;SezioneA.c,46 :: 		}
	GOTO        L_main7
L_main4:
;SezioneA.c,47 :: 		else if(store_c0 == 1 && PORTC.RC0 == 0)
	MOVF        main_store_c0_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
	BTFSC       PORTC+0, 0 
	GOTO        L_main10
L__main11:
;SezioneA.c,48 :: 		store_c0 = 0;
	CLRF        main_store_c0_L0+0 
L_main10:
L_main7:
;SezioneA.c,50 :: 		LATE.LATE2 = stato_accensione;
	BTFSC       main_stato_accensione_L0+0, 0 
	GOTO        L__main14
	BCF         LATE+0, 2 
	GOTO        L__main15
L__main14:
	BSF         LATE+0, 2 
L__main15:
;SezioneA.c,54 :: 		}
	GOTO        L_main0
;SezioneA.c,59 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
