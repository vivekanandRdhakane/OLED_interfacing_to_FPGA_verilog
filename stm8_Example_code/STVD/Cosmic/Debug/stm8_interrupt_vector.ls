   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  51                     ; 13 @far @interrupt void NonHandledInterrupt (void)
  51                     ; 14 {
  52                     .text:	section	.text,new
  53  0000               f_NonHandledInterrupt:
  57                     ; 18 	return;
  60  0000 80            	iret	
  62                     .const:	section	.text
  63  0000               __vectab:
  64  0000 82            	dc.b	130
  66  0001 00            	dc.b	page(__stext)
  67  0002 0000          	dc.w	__stext
  68  0004 82            	dc.b	130
  70  0005 00            	dc.b	page(f_NonHandledInterrupt)
  71  0006 0000          	dc.w	f_NonHandledInterrupt
  72  0008 82            	dc.b	130
  74  0009 00            	dc.b	page(f_NonHandledInterrupt)
  75  000a 0000          	dc.w	f_NonHandledInterrupt
  76  000c 82            	dc.b	130
  78  000d 00            	dc.b	page(f_NonHandledInterrupt)
  79  000e 0000          	dc.w	f_NonHandledInterrupt
  80  0010 82            	dc.b	130
  82  0011 00            	dc.b	page(f_NonHandledInterrupt)
  83  0012 0000          	dc.w	f_NonHandledInterrupt
  84  0014 82            	dc.b	130
  86  0015 00            	dc.b	page(f_NonHandledInterrupt)
  87  0016 0000          	dc.w	f_NonHandledInterrupt
  88  0018 82            	dc.b	130
  90  0019 00            	dc.b	page(f_NonHandledInterrupt)
  91  001a 0000          	dc.w	f_NonHandledInterrupt
  92  001c 82            	dc.b	130
  94  001d 00            	dc.b	page(f_NonHandledInterrupt)
  95  001e 0000          	dc.w	f_NonHandledInterrupt
  96  0020 82            	dc.b	130
  98  0021 00            	dc.b	page(f_NonHandledInterrupt)
  99  0022 0000          	dc.w	f_NonHandledInterrupt
 100  0024 82            	dc.b	130
 102  0025 00            	dc.b	page(f_NonHandledInterrupt)
 103  0026 0000          	dc.w	f_NonHandledInterrupt
 104  0028 82            	dc.b	130
 106  0029 00            	dc.b	page(f_NonHandledInterrupt)
 107  002a 0000          	dc.w	f_NonHandledInterrupt
 108  002c 82            	dc.b	130
 110  002d 00            	dc.b	page(f_NonHandledInterrupt)
 111  002e 0000          	dc.w	f_NonHandledInterrupt
 112  0030 82            	dc.b	130
 114  0031 00            	dc.b	page(f_NonHandledInterrupt)
 115  0032 0000          	dc.w	f_NonHandledInterrupt
 116  0034 82            	dc.b	130
 118  0035 00            	dc.b	page(f_NonHandledInterrupt)
 119  0036 0000          	dc.w	f_NonHandledInterrupt
 120  0038 82            	dc.b	130
 122  0039 00            	dc.b	page(f_NonHandledInterrupt)
 123  003a 0000          	dc.w	f_NonHandledInterrupt
 124  003c 82            	dc.b	130
 126  003d 00            	dc.b	page(f_NonHandledInterrupt)
 127  003e 0000          	dc.w	f_NonHandledInterrupt
 128  0040 82            	dc.b	130
 130  0041 00            	dc.b	page(f_NonHandledInterrupt)
 131  0042 0000          	dc.w	f_NonHandledInterrupt
 132  0044 82            	dc.b	130
 134  0045 00            	dc.b	page(f_NonHandledInterrupt)
 135  0046 0000          	dc.w	f_NonHandledInterrupt
 136  0048 82            	dc.b	130
 138  0049 00            	dc.b	page(f_NonHandledInterrupt)
 139  004a 0000          	dc.w	f_NonHandledInterrupt
 140  004c 82            	dc.b	130
 142  004d 00            	dc.b	page(f_NonHandledInterrupt)
 143  004e 0000          	dc.w	f_NonHandledInterrupt
 144  0050 82            	dc.b	130
 146  0051 00            	dc.b	page(f_UART1_RX_IRQHandler)
 147  0052 0000          	dc.w	f_UART1_RX_IRQHandler
 148  0054 82            	dc.b	130
 150  0055 00            	dc.b	page(f_NonHandledInterrupt)
 151  0056 0000          	dc.w	f_NonHandledInterrupt
 152  0058 82            	dc.b	130
 154  0059 00            	dc.b	page(f_NonHandledInterrupt)
 155  005a 0000          	dc.w	f_NonHandledInterrupt
 156  005c 82            	dc.b	130
 158  005d 00            	dc.b	page(f_NonHandledInterrupt)
 159  005e 0000          	dc.w	f_NonHandledInterrupt
 160  0060 82            	dc.b	130
 162  0061 00            	dc.b	page(f_NonHandledInterrupt)
 163  0062 0000          	dc.w	f_NonHandledInterrupt
 164  0064 82            	dc.b	130
 166  0065 00            	dc.b	page(f_NonHandledInterrupt)
 167  0066 0000          	dc.w	f_NonHandledInterrupt
 168  0068 82            	dc.b	130
 170  0069 00            	dc.b	page(f_NonHandledInterrupt)
 171  006a 0000          	dc.w	f_NonHandledInterrupt
 172  006c 82            	dc.b	130
 174  006d 00            	dc.b	page(f_NonHandledInterrupt)
 175  006e 0000          	dc.w	f_NonHandledInterrupt
 176  0070 82            	dc.b	130
 178  0071 00            	dc.b	page(f_NonHandledInterrupt)
 179  0072 0000          	dc.w	f_NonHandledInterrupt
 180  0074 82            	dc.b	130
 182  0075 00            	dc.b	page(f_NonHandledInterrupt)
 183  0076 0000          	dc.w	f_NonHandledInterrupt
 184  0078 82            	dc.b	130
 186  0079 00            	dc.b	page(f_NonHandledInterrupt)
 187  007a 0000          	dc.w	f_NonHandledInterrupt
 188  007c 82            	dc.b	130
 190  007d 00            	dc.b	page(f_NonHandledInterrupt)
 191  007e 0000          	dc.w	f_NonHandledInterrupt
 242                     	xdef	__vectab
 243                     	xref	__stext
 244                     	xdef	f_NonHandledInterrupt
 245                     	xref	f_UART1_RX_IRQHandler
 264                     	end
