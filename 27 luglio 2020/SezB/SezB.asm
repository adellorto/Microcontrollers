
_main:

;SezB.c,19 :: 		void main() {
;SezB.c,22 :: 		unsigned short int stato_accensione = 0, store_c0 = 0;          //Variabili sezione A
	CLRF        main_stato_accensione_L0+0 
	CLRF        main_store_c0_L0+0 
	CLRF        main_velocita_motore_L0+0 
	CLRF        main_store_c3_L0+0 
	CLRF        main_store_c4_L0+0 
;SezB.c,26 :: 		TRISC = 255;
	MOVLW       255
	MOVWF       TRISC+0 
;SezB.c,27 :: 		ANSELC = 0b11100110;
	MOVLW       230
	MOVWF       ANSELC+0 
;SezB.c,29 :: 		TRISA = 0b11101111;
	MOVLW       239
	MOVWF       TRISA+0 
;SezB.c,30 :: 		TRISD = 0;
	CLRF        TRISD+0 
;SezB.c,34 :: 		TRISE.TRISE2 = 1;
	BSF         TRISE+0, 2 
;SezB.c,35 :: 		CCPTMRS1.C5TSEL0 = 1;
	BSF         CCPTMRS1+0, 2 
;SezB.c,36 :: 		CCPTMRS1.C5TSEL1 = 0; //Timer 4
	BCF         CCPTMRS1+0, 3 
;SezB.c,37 :: 		PR4 = 8;
	MOVLW       8
	MOVWF       PR4+0 
;SezB.c,38 :: 		CCP5CON = 0b00001111;
	MOVLW       15
	MOVWF       CCP5CON+0 
;SezB.c,39 :: 		T4CON = 0b00000110;
	MOVLW       6
	MOVWF       T4CON+0 
;SezB.c,40 :: 		TRISE.TRISE2 = 0;
	BCF         TRISE+0, 2 
;SezB.c,45 :: 		Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
	CALL        _Lcd_Init+0, 0
;SezB.c,47 :: 		Lcd_Cmd(_LCD_CLEAR);    	// Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SezB.c,48 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SezB.c,49 :: 		Lcd_Out(1,1,"SPENTO");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_SezB+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_SezB+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezB.c,53 :: 		while(1){
L_main0:
;SezB.c,57 :: 		if(store_c0 == 0 && PORTC.RC0 == 1){
	MOVF        main_store_c0_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
	BTFSS       PORTC+0, 0 
	GOTO        L_main4
L__main33:
;SezB.c,58 :: 		if(stato_accensione){
	MOVF        main_stato_accensione_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main5
;SezB.c,59 :: 		stato_accensione = 0;
	CLRF        main_stato_accensione_L0+0 
;SezB.c,60 :: 		LATA.RA4 = 0;
	BCF         LATA+0, 4 
;SezB.c,61 :: 		velocita_motore = 0;
	CLRF        main_velocita_motore_L0+0 
;SezB.c,62 :: 		LATD = 0;
	CLRF        LATD+0 
;SezB.c,63 :: 		Lcd_Out(1,1,"SPENTO");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_SezB+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_SezB+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezB.c,64 :: 		}
	GOTO        L_main6
L_main5:
;SezB.c,66 :: 		stato_accensione = 1;
	MOVLW       1
	MOVWF       main_stato_accensione_L0+0 
;SezB.c,67 :: 		LATA.RA4 = 1;
	BSF         LATA+0, 4 
;SezB.c,68 :: 		velocita_motore = 1;
	MOVLW       1
	MOVWF       main_velocita_motore_L0+0 
;SezB.c,69 :: 		Lcd_Out(1,1,"ACCESO");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_SezB+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_SezB+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SezB.c,70 :: 		}
L_main6:
;SezB.c,71 :: 		store_c0 = 1;
	MOVLW       1
	MOVWF       main_store_c0_L0+0 
;SezB.c,72 :: 		}
	GOTO        L_main7
L_main4:
;SezB.c,73 :: 		else if(store_c0 == 1 && PORTC.RC0 == 0)
	MOVF        main_store_c0_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
	BTFSC       PORTC+0, 0 
	GOTO        L_main10
L__main32:
;SezB.c,74 :: 		store_c0 = 0;
	CLRF        main_store_c0_L0+0 
L_main10:
L_main7:
;SezB.c,79 :: 		if(stato_accensione){
	MOVF        main_stato_accensione_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
;SezB.c,82 :: 		if(store_c3 == 0 && PORTC.RC3 == 1){
	MOVF        main_store_c3_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main14
	BTFSS       PORTC+0, 3 
	GOTO        L_main14
L__main31:
;SezB.c,83 :: 		if(velocita_motore<8)
	MOVLW       8
	SUBWF       main_velocita_motore_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main15
;SezB.c,84 :: 		velocita_motore++;
	INCF        main_velocita_motore_L0+0, 1 
L_main15:
;SezB.c,85 :: 		store_c3 = 1;
	MOVLW       1
	MOVWF       main_store_c3_L0+0 
;SezB.c,86 :: 		}
	GOTO        L_main16
L_main14:
;SezB.c,87 :: 		else if(store_c3 == 1 && PORTC.RC3 == 0)
	MOVF        main_store_c3_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main19
	BTFSC       PORTC+0, 3 
	GOTO        L_main19
L__main30:
;SezB.c,88 :: 		store_c3 = 0;
	CLRF        main_store_c3_L0+0 
L_main19:
L_main16:
;SezB.c,90 :: 		if(store_c4 == 0 && PORTC.RC4 == 1){
	MOVF        main_store_c4_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main22
	BTFSS       PORTC+0, 4 
	GOTO        L_main22
L__main29:
;SezB.c,91 :: 		if(velocita_motore>1)
	MOVF        main_velocita_motore_L0+0, 0 
	SUBLW       1
	BTFSC       STATUS+0, 0 
	GOTO        L_main23
;SezB.c,92 :: 		velocita_motore--;
	DECF        main_velocita_motore_L0+0, 1 
L_main23:
;SezB.c,93 :: 		store_c4 = 1;
	MOVLW       1
	MOVWF       main_store_c4_L0+0 
;SezB.c,94 :: 		}
	GOTO        L_main24
L_main22:
;SezB.c,95 :: 		else if(store_c4 == 1 && PORTC.RC4 == 0)
	MOVF        main_store_c4_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main27
	BTFSC       PORTC+0, 4 
	GOTO        L_main27
L__main28:
;SezB.c,96 :: 		store_c4 = 0;
	CLRF        main_store_c4_L0+0 
L_main27:
L_main24:
;SezB.c,98 :: 		LATD = (1<<velocita_motore) - 1;
	MOVF        main_velocita_motore_L0+0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__main35:
	BZ          L__main36
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__main35
L__main36:
	DECF        R0, 0 
	MOVWF       LATD+0 
;SezB.c,101 :: 		}
L_main11:
;SezB.c,103 :: 		CCPR5L = velocita_motore;
	MOVF        main_velocita_motore_L0+0, 0 
	MOVWF       CCPR5L+0 
;SezB.c,106 :: 		}
	GOTO        L_main0
;SezB.c,109 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
