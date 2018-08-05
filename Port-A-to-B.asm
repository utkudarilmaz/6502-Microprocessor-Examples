.code $0200
LDA #00
STA $0401 	; Set DDRA
STA $0403 	; Set DDRB
STA $0400 	; Input ORA
LDA #$FF
STA $0402 	; Output ORB
LDA #04
STA $0401	; Set ORA
STA $0403	; Set ORB
LDA $0400	; Read ORA
STA $0402	; Write ORB
BRK
END