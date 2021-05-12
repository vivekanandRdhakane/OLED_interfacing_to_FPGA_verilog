/**************************************************************

Note for u:  remember to set UART Configuration in terminal as
UART1 is configured as follow:
    - BaudRate = 9600 baud  
    - Word Length = 8 Bits 
    - One Stop Bit
    - No parity
    - Receive and transmit enabled
    - UART1 Clock disabled
****************************************************************/


/**
  ******************************************************************************
  * @file    UART1_HyperTerminal_Interrupt\main.c
  * @author  MCD Application Team
  * @version V2.0.4
  * @date     26-April-2018
  * @brief   This file contains the main function for UART1 using interrupts in 
  *          communication example.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */ 

/* Includes ------------------------------------------------------------------*/
#include <stdio.h> 
#include <stdlib.h>
#include "stm8s.h"
#include "main.h"
//#include "stm8s_eval.h"

/**
  * @addtogroup UART1_HyperTerminal_Interrupt
  * @{
  */
/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
#define receive_buffer_size 20
#define UART_receive_END_CHAR '~'
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/

char receive_buffer[receive_buffer_size];
uint16_t receive_buffer_index = 0;

/* Private function prototypes -----------------------------------------------*/
static void GPIO_Config(void);
static void CLK_Config(void);
static void UART1_Config(void); 
void delay_ms(uint16_t nCount);
void clear_OLED(void);
void INIT_OLED(void);
void write_OLED_devnagari(char string[],u8 size,char cordinate[]);
void write_OLED_ENGLISH(char string[],u8 size,char cordinate[]);
void display_int_devnagari(int value,u8 size,char cordinate[]);
int temp;
/* Private functions ---------------------------------------------------------*/
INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
{
  uint8_t temp;
  /* Read one byte from the receive data register and send it back */
  //temp = (UART1_ReceiveData8() & 0x7F);
	temp = (UART1_ReceiveData8());
	
  //UART1_SendData8(temp);
	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending
	
	receive_buffer[receive_buffer_index++] = temp;
	
	
	
	if(receive_buffer_index == (receive_buffer_size-1) ) // check if buffer is full
		{
			receive_buffer[receive_buffer_index] = '\0';
			Serial_print_string("Receiver = ");
			Serial_print_string(receive_buffer);
			Serial_print_string("<\n");
			receive_buffer_index = 0;
		}
	else if(temp  == UART_receive_END_CHAR)  // check if end char is rec
		{
			receive_buffer[receive_buffer_index] = '\0';
			Serial_print_string("Receiver EC = ");
			Serial_print_string(receive_buffer);
			Serial_print_string("<\n");
			receive_buffer_index = 0;
		}
}
 void Serial_print_char (char character)
 {
	 UART1_SendData8(character);
	 while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET); //wait for sending
	 
 }
 
 void Serial_print_string (char string[])
 {

	 char i=0;

	 while (string[i] != 0x00)
	 {
		UART1_SendData8(string[i]);
		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
		i++;
	}
 }
 
 void Serial_print_int (int number) //Funtion to print int value to serial monitor 
 {
	  char str[6];
	  sprintf(str, "%d", number);
		Serial_print_string(str);
 }
 
  void Serial_send_hex (u8 number) //Funtion to print int value to serial monitor 
 {
	  UART1_SendData8(number);
		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 }
 

/**
  * @brief  Main program.
  * @param  None
  * @retval None
  */
void main(void)
{
	
  /* Clock configuration -----------------------------------------*/
  CLK_Config();  
	delay_ms(10000);
  /* UART1 configuration -----------------------------------------*/
  UART1_Config();  
	INIT_OLED();
	delay_ms(1000);
	
	//Serial_send_hex (0);
	//Serial_print_string("MAR30000marazI");
	//Serial_send_hex (255);
	
	clear_OLED();
	write_OLED_devnagari("marazI",3,"0000");
	delay_ms(1500);
	write_OLED_devnagari("ihndI",3,"0003")	;
	delay_ms(1500);
	write_OLED_ENGLISH("ENGLISH",2,"0006");
	delay_ms(1500);
	clear_OLED();
  while (1)
  {
		display_int_devnagari(temp++,3,"0503");
		delay_ms(1000);
		clear_OLED();
		
  }
}



void write_OLED_devnagari(char string[],u8 size,char cordinate[])
{
	Serial_send_hex (0);
	Serial_print_string("MAR");
	Serial_send_hex(size+48);
	Serial_print_string(cordinate);
	Serial_print_string(string);
	Serial_send_hex (255);

}

void write_OLED_ENGLISH(char string[],u8 size,char cordinate[])
{
	Serial_send_hex (0);
	Serial_print_string("ENG");
	Serial_send_hex(size+48);
	Serial_print_string(cordinate);
	Serial_print_string(string);
	Serial_send_hex (255);

}


void clear_OLED(void)
{
	Serial_send_hex (0);
	Serial_print_string("C");
	Serial_send_hex (255);
	delay_ms(500);

}

void INIT_OLED(void)
{
	Serial_send_hex (0);
	Serial_print_string("I");
	Serial_send_hex (255);

}

/**
  * @brief  Configure system clock to run at 16Mhz
  * @param  None
  * @retval None
  */
static void CLK_Config(void)
{
    /* Initialization of the clock */
    /* Clock divider to HSI/1 */
    CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
}


/**
  * @brief  Configure UART1 for the communication with HyperTerminal
  * @param  None
  * @retval None
  */
static void UART1_Config(void)
{
  /* EVAL COM (UART) configuration -----------------------------------------*/
  /* USART configured as follow:
        - BaudRate = 115200 baud  
        - Word Length = 8 Bits
        - One Stop Bit
        - Odd parity
        - Receive and transmit enabled
        - UART Clock disabled
  */
  UART1_Init((uint32_t)115200, UART1_WORDLENGTH_8D,UART1_STOPBITS_1, UART1_PARITY_NO,
                   UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);

  /* Enable the UART Receive interrupt: this interrupt is generated when the UART
    receive data register is not empty */
 // UART1_ITConfig(UART1_IT_RXNE_OR, ENABLE);
  
  /* Enable the UART Transmit complete interrupt: this interrupt is generated 
     when the UART transmit Shift Register is empty */
  //UART1_ITConfig(UART1_IT_TXE, ENABLE);

  /* Enable UART */
  UART1_Cmd(ENABLE);
  
    /* Enable general interrupts */
  enableInterrupts();
}

/**
  * @brief  Delay.
  * @param  nCount
  * @retval None
  */
void delay_ms (uint16_t ms) //Function Definition 
{
	 
	int i =0 ;
	int j=0;
	ms--;
	for (i=0; i<=ms; i++)
	{
	for (j=0; j<2664; j++) // Nop = Fosc/4
			_asm("nop"); //Perform no operation //assembly code <span style="white-space:pre"> </span>
	}
}


void display_int_devnagari(int value,u8 size,char cordinate[])
{

   char ch[] = {0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x00};

  if(value < 0)

  {

    ch[0] = '-';

    value = -value;

  }

  else

  {

    ch[0] = '+';

  }

  if(value > 9999)

  {

    ch[1] = ((value / 10000) + 0x30); 

    ch[2] = (((value % 10000) / 1000) + 0x30); 

    ch[3] = (((value % 1000) / 100) + 0x30); 

    ch[4] = (((value % 100) / 10) + 0x30); 

    ch[5] = ((value % 10) + 0x30);

  }

  else if((value > 999) && (value <= 9999))

  {

    ch[1] = ((value / 1000) + 0x30); 

    ch[2] = (((value % 1000) / 100) + 0x30); 

    ch[3] = (((value % 100) / 10) + 0x30); 

    ch[4] = ((value % 10) + 0x30);

    ch[5] = 0x00;

  }

  else if((value > 99) && (value <= 999))

  {

    ch[1] = ((value / 100) + 0x30); 

    ch[2] = (((value % 100) / 10) + 0x30); 

    ch[3] = ((value % 10) + 0x30);

    ch[4] = 0x00;

    ch[5] = 0x00;

  }

  else if((value > 9) && (value <= 99))

  {

    ch[1] = ((value / 10) + 0x30); 

    ch[2] = ((value % 10) + 0x30);

    ch[3] = 0x00;

    ch[4] = 0x00;

    ch[5] = 0x00;

  }

  else

  {

    ch[1] = ((value % 10) + 0x30);

    ch[2] = 0x00;

    ch[3] = 0x00;

    ch[4] = 0x00;

    ch[5] = 0x00;

  }
	
	
	if(ch[0] == '+')
		{
			ch[0] = ch[1];
			ch[1] = ch[2];
			ch[2] = ch[3];
			ch[3] = ch[4];
			ch[4] = ch[5];
			ch[5] = 0x00;
		}


	Serial_send_hex (0);
	Serial_print_string("ENG");
	Serial_send_hex(size+48);
	Serial_print_string(cordinate);
	Serial_print_string(ch);
	Serial_send_hex (255);
}


#ifdef USE_FULL_ASSERT

/**
  * @brief  Reports the name of the source file and the source line number
  *   where the assert_param error has occurred.
  * @param file: pointer to the source file name
  * @param line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t* file, uint32_t line)
{ 
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {
  }
}
#endif

/**
  * @}
  */


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
