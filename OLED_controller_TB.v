//////////////////////////////////////////////////////////////////////
// File Downloaded from http://www.nandland.com
//////////////////////////////////////////////////////////////////////
 
// This testbench will exercise both the UART Tx and Rx.
// It sends out byte 0xAB over the transmitter
// It then exercises the receive by receiving byte 0x3F
`timescale 1ns/10ps
 
//`include "uart_tx.v"
//`include "uart_rx.v"
 
module uart_tb ();
 
  // Testbench uses a 10 MHz clock
  // Want to interface to 115200 baud UART
  // 50000000 / 115200 = 87 Clocks Per Bit.
  parameter c_CLOCK_PERIOD_NS = 100;
  parameter c_CLKS_PER_BIT    = 434;//87;
  parameter c_BIT_PERIOD      = 43000;//8600;
   
  reg r_Clock = 0;
  reg r_Tx_DV = 0;
  wire w_Tx_Done;
  reg [7:0] r_Tx_Byte = 0;
  reg r_Rx_Serial = 1;
  wire [7:0] w_Rx_Byte;
  wire Rx_dval;
  wire SDA,SCL,controller_clock,OLED_driver_clock;
  reg reset;
  // Takes in input byte and serializes it 
  task UART_WRITE_BYTE;
    input [7:0] i_Data;
    integer     ii;
    begin
       
      // Send Start Bit
      r_Rx_Serial <= 1'b0;
      #(c_BIT_PERIOD);
      #1000;
       
       
      // Send Data Byte
      for (ii=0; ii<8; ii=ii+1)
        begin
          r_Rx_Serial <= i_Data[ii];
          #(c_BIT_PERIOD);
        end
       
      // Send Stop Bit
      r_Rx_Serial <= 1'b1;
      #(c_BIT_PERIOD);
     end
  endtask // UART_WRITE_BYTE
   
   
	               //   (CLOCK_50,reset,button,Rx,SDA,SCL,LED)
	//OLED_controller uut(r_Clock,reset,button,r_Rx_Serial,w_Rx_Byte,Rx_dval,SDA,SCL, controller_clock,LED,OLED_driver_clock);
	  OLED_controller uut(r_Clock,reset,button,r_Rx_Serial,SDA,SCL,LED);
	
  /*uart_rx #(.CLKS_PER_BIT(c_CLKS_PER_BIT)) UART_RX_INST
    (.i_Clock(r_Clock),
     .i_Rx_Serial(r_Rx_Serial),
     .o_Rx_DV(),
     .o_Rx_Byte(w_Rx_Byte)
     );
	  */
   
 /* uart_tx #(.CLKS_PER_BIT(c_CLKS_PER_BIT)) UART_TX_INST
    (.i_Clock(r_Clock),
     .i_Tx_DV(r_Tx_DV),
     .i_Tx_Byte(r_Tx_Byte),
     .o_Tx_Active(),
     .o_Tx_Serial(),
     .o_Tx_Done(w_Tx_Done)
     );
 */
   
  always
    #(c_CLOCK_PERIOD_NS/2) r_Clock <= !r_Clock;
 
   
  // Main Testing:
  initial
    begin
       
		 
		 
		 
      // Tell UART to send a command (exercise Tx)
		#8000000 reset <= 1;
		#4000000 reset <= 0;
      
      @(posedge r_Clock);
      @(posedge r_Clock);
      r_Tx_DV <= 1'b1;
      r_Tx_Byte <= 8'h0A;
      @(posedge r_Clock);
      r_Tx_DV <= 1'b0;
     // @(posedge w_Tx_Done);
       
      // Send a command to the UART (exercise Rx)
      @(posedge r_Clock);
      UART_WRITE_BYTE(0);
		
		#4000000 UART_WRITE_BYTE(69);//E
		#4000000 UART_WRITE_BYTE(78);//N
		#4000000 UART_WRITE_BYTE(71);//G
		#4000000 UART_WRITE_BYTE(51);//3
		#4000000 UART_WRITE_BYTE(48);//0
		#4000000 UART_WRITE_BYTE(48);//0
		#4000000 UART_WRITE_BYTE(48);//0
		#4000000 UART_WRITE_BYTE(51);//3
		#4000000 UART_WRITE_BYTE(69);//E
		#4000000 UART_WRITE_BYTE(78);//N
		#4000000 UART_WRITE_BYTE(71);//G
		#4000000 UART_WRITE_BYTE(255);
		
//		#100000000	UART_WRITE_BYTE(8'h21);
//		#4000000 UART_WRITE_BYTE(69);//E
//		#4000000 UART_WRITE_BYTE(78);//N
//		#4000000 UART_WRITE_BYTE(71);//G
//		#4000000 UART_WRITE_BYTE(48);//0
//		#4000000 UART_WRITE_BYTE(51);//3
//		#4000000 UART_WRITE_BYTE(48);//0
//		#4000000 UART_WRITE_BYTE(51);//3
//		#4000000 UART_WRITE_BYTE(70);//E
//		#4000000 UART_WRITE_BYTE(71);//N
//		#4000000 UART_WRITE_BYTE(72);//G
//		#4000000 UART_WRITE_BYTE(8'h22);
//		

		
		/*
      // Check that the correct command was received
      if (w_Rx_Byte == 8'h3F)
        $display("Test Passed - Correct Byte Received");
      else
        $display("Test Failed - Incorrect Byte Received");*/
       
    end
   
endmodule
