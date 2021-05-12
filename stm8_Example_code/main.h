#ifndef __MAIN_H
#define __MAIN_H

#include "stm8s.h"
 INTERRUPT void UART1_RX_IRQHandler(void); /* UART1 RX */
 //INTERRUPT void UART1_TX_IRQHandler(void); /* UART1 TX */
void Serial_print_string (char string[]);

#endif