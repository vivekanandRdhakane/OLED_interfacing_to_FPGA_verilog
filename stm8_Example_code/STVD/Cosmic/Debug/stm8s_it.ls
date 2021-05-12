   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  21                     	bsct
  22  0000               _TxBuffer:
  23  0000 487970657254  	dc.b	"HyperTerminal Inte"
  24  0012 72727570743a  	dc.b	"rrupt: UART1-Hyper"
  25  0024 7465726d696e  	dc.b	"terminal communica"
  26  0036 74696f6e2075  	dc.b	"tion using Interru"
  27  0048 707400        	dc.b	"pt",0
  28  004b               _TxCounter:
  29  004b 00            	dc.b	0
  59                     ; 55 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  59                     ; 56 {
  60                     .text:	section	.text,new
  61  0000               f_NonHandledInterrupt:
  65                     ; 60 }
  68  0000 80            	iret	
  90                     ; 68 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  90                     ; 69 {
  91                     .text:	section	.text,new
  92  0000               f_TRAP_IRQHandler:
  96                     ; 73 }
  99  0000 80            	iret	
 121                     ; 79 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 121                     ; 80 {
 122                     .text:	section	.text,new
 123  0000               f_TLI_IRQHandler:
 127                     ; 84 }
 130  0000 80            	iret	
 152                     ; 91 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 152                     ; 92 {
 153                     .text:	section	.text,new
 154  0000               f_AWU_IRQHandler:
 158                     ; 96 }
 161  0000 80            	iret	
 183                     ; 103 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 183                     ; 104 {
 184                     .text:	section	.text,new
 185  0000               f_CLK_IRQHandler:
 189                     ; 108 }
 192  0000 80            	iret	
 215                     ; 115 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 215                     ; 116 {
 216                     .text:	section	.text,new
 217  0000               f_EXTI_PORTA_IRQHandler:
 221                     ; 120 }
 224  0000 80            	iret	
 247                     ; 127 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 247                     ; 128 {
 248                     .text:	section	.text,new
 249  0000               f_EXTI_PORTB_IRQHandler:
 253                     ; 132 }
 256  0000 80            	iret	
 279                     ; 139 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 279                     ; 140 {
 280                     .text:	section	.text,new
 281  0000               f_EXTI_PORTC_IRQHandler:
 285                     ; 144 }
 288  0000 80            	iret	
 311                     ; 151 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 311                     ; 152 {
 312                     .text:	section	.text,new
 313  0000               f_EXTI_PORTD_IRQHandler:
 317                     ; 156 }
 320  0000 80            	iret	
 343                     ; 163 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 343                     ; 164 {
 344                     .text:	section	.text,new
 345  0000               f_EXTI_PORTE_IRQHandler:
 349                     ; 168 }
 352  0000 80            	iret	
 374                     ; 214 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 374                     ; 215 {
 375                     .text:	section	.text,new
 376  0000               f_SPI_IRQHandler:
 380                     ; 219 }
 383  0000 80            	iret	
 406                     ; 226 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 406                     ; 227 {
 407                     .text:	section	.text,new
 408  0000               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 412                     ; 231 }
 415  0000 80            	iret	
 438                     ; 238 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 438                     ; 239 {
 439                     .text:	section	.text,new
 440  0000               f_TIM1_CAP_COM_IRQHandler:
 444                     ; 243 }
 447  0000 80            	iret	
 470                     ; 275  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 470                     ; 276 {
 471                     .text:	section	.text,new
 472  0000               f_TIM2_UPD_OVF_BRK_IRQHandler:
 476                     ; 280 }
 479  0000 80            	iret	
 502                     ; 287  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 502                     ; 288 {
 503                     .text:	section	.text,new
 504  0000               f_TIM2_CAP_COM_IRQHandler:
 508                     ; 292 }
 511  0000 80            	iret	
 538                     ; 329  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 538                     ; 330 {
 539                     .text:	section	.text,new
 540  0000               f_UART1_TX_IRQHandler:
 542  0000 8a            	push	cc
 543  0001 84            	pop	a
 544  0002 a4bf          	and	a,#191
 545  0004 88            	push	a
 546  0005 86            	pop	cc
 547  0006 3b0002        	push	c_x+2
 548  0009 be00          	ldw	x,c_x
 549  000b 89            	pushw	x
 550  000c 3b0002        	push	c_y+2
 551  000f be00          	ldw	x,c_y
 552  0011 89            	pushw	x
 555                     ; 332   UART1_SendData8(TxBuffer[TxCounter++]);
 557  0012 b64b          	ld	a,_TxCounter
 558  0014 3c4b          	inc	_TxCounter
 559  0016 5f            	clrw	x
 560  0017 97            	ld	xl,a
 561  0018 e600          	ld	a,(_TxBuffer,x)
 562  001a cd0000        	call	_UART1_SendData8
 564                     ; 334   if (TxCounter == TX_BUFFER_SIZE)
 566  001d b64b          	ld	a,_TxCounter
 567  001f a14a          	cp	a,#74
 568  0021 2609          	jrne	L112
 569                     ; 337     UART1_ITConfig(UART1_IT_TXE, DISABLE);
 571  0023 4b00          	push	#0
 572  0025 ae0277        	ldw	x,#631
 573  0028 cd0000        	call	_UART1_ITConfig
 575  002b 84            	pop	a
 576  002c               L112:
 577                     ; 339 }
 580  002c 85            	popw	x
 581  002d bf00          	ldw	c_y,x
 582  002f 320002        	pop	c_y+2
 583  0032 85            	popw	x
 584  0033 bf00          	ldw	c_x,x
 585  0035 320002        	pop	c_x+2
 586  0038 80            	iret	
 608                     ; 364 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 608                     ; 365 {
 609                     .text:	section	.text,new
 610  0000               f_I2C_IRQHandler:
 614                     ; 369 }
 617  0000 80            	iret	
 639                     ; 444  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 639                     ; 445 {
 640                     .text:	section	.text,new
 641  0000               f_ADC1_IRQHandler:
 645                     ; 450     return;
 648  0000 80            	iret	
 671                     ; 473  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 671                     ; 474 {
 672                     .text:	section	.text,new
 673  0000               f_TIM4_UPD_OVF_IRQHandler:
 677                     ; 478 }
 680  0000 80            	iret	
 703                     ; 486 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 703                     ; 487 {
 704                     .text:	section	.text,new
 705  0000               f_EEPROM_EEC_IRQHandler:
 709                     ; 491 }
 712  0000 80            	iret	
 745                     	xdef	_TxCounter
 746                     	xdef	_TxBuffer
 747                     	xdef	f_EEPROM_EEC_IRQHandler
 748                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 749                     	xdef	f_ADC1_IRQHandler
 750                     	xdef	f_I2C_IRQHandler
 751                     	xdef	f_UART1_TX_IRQHandler
 752                     	xdef	f_TIM2_CAP_COM_IRQHandler
 753                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
 754                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
 755                     	xdef	f_TIM1_CAP_COM_IRQHandler
 756                     	xdef	f_SPI_IRQHandler
 757                     	xdef	f_EXTI_PORTE_IRQHandler
 758                     	xdef	f_EXTI_PORTD_IRQHandler
 759                     	xdef	f_EXTI_PORTC_IRQHandler
 760                     	xdef	f_EXTI_PORTB_IRQHandler
 761                     	xdef	f_EXTI_PORTA_IRQHandler
 762                     	xdef	f_CLK_IRQHandler
 763                     	xdef	f_AWU_IRQHandler
 764                     	xdef	f_TLI_IRQHandler
 765                     	xdef	f_TRAP_IRQHandler
 766                     	xdef	f_NonHandledInterrupt
 767                     	xref	_UART1_SendData8
 768                     	xref	_UART1_ITConfig
 769                     	xref.b	c_x
 770                     	xref.b	c_y
 789                     	end
