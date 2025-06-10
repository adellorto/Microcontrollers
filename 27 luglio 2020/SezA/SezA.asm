
_main:

;SezA.c,19 :: 		void main() {
;SezA.c,21 :: 		unsigned short int stato_accensione = 0, store_c0 = 0;
	CLRF        main_stato_accensione_L0+0 
	CLRF        main_store_c0_L0+0 
;SezA.c,23 :: 		TRISC = 255;
	MOVLW       255
	MOVWF       TRISC+0 
;SezA.c,24 :: 		ANSELC = 0b11111110;
	MOVLW       254
	MOVWF       ANSELC+0 
;SezA.c,26 :: 		TRISE = 0b11111011;
	MOVLW       251
	MOVWF       TRISE+0 
;SezA.c,27 :: 		TRISA = 0b11101111;
	MOVLW       239
	MOVWF       TRISA+0 
;SezA.c,30 :: 		Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
	CALL        _Lcd_Init+0, 0
;SezA.c,32 :: 		Lcd_Cmd(_LCD_CLEAR);    	// Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SezA.c,33 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SezA.c,34 :: 		Lcd_Out(1,1,"SPENTO");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_SezA+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_SezA+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezA.c,38 :: 		while(1){
L_main0:
;SezA.c,40 :: 		if(store_c0 == 0 && PORTC.RC0 == 1){
	MOVF        main_store_c0_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
	BTFSS       PORTC+0, 0 
	GOTO        L_main4
L__main12:
;SezA.c,41 :: 		if(stato_accensione){
	MOVF        main_stato_accensione_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main5
;SezA.c,42 :: 		stato_accensione = 0;
	CLRF        main_stato_accensione_L0+0 
;SezA.c,43 :: 		LATA.RA4 = 0;
	BCF         LATA+0, 4 
;SezA.c,44 :: 		LATE.RE2 = 0;
	BCF         LATE+0, 2 
;SezA.c,45 :: 		Lcd_Out(1,1,"SPENTO");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_SezA+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_SezA+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezA.c,46 :: 		}
	GOTO        L_main6
L_main5:
;SezA.c,48 :: 		stato_accensione = 1;
	MOVLW       1
	MOVWF       main_stato_accensione_L0+0 
;SezA.c,49 :: 		LATA.RA4 = 1;
	BSF         LATA+0, 4 
;SezA.c,50 :: 		LATE.RE2 = 1;
	BSF         LATE+0, 2 
;SezA.c,51 :: 		Lcd_Out(1,1,"ACCESO");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_SezA+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_SezA+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezA.c,52 :: 		}
L_main6:
;SezA.c,53 :: 		store_c0 = 1;
	MOVLW       1
	MOVWF       main_store_c0_L0+0 
;SezA.c,54 :: 		}
	GOTO        L_main7
L_main4:
;SezA.c,55 :: 		else if(store_c0 == 1 && PORTC.RC0 == 0)
	MOVF        main_store_c0_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
	BTFSC       PORTC+0, 0 
	GOTO        L_main10
L__main11:
;SezA.c,56 :: 		store_c0 = 0;
	CLRF        main_store_c0_L0+0 
L_main10:
L_main7:
;SezA.c,59 :: 		}
	GOTO        L_main0
;SezA.c,62 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
