

module i2c_driver (i2c_in_clk,reset, data, clk,SDA,SCL);

input i2c_in_clk;
input reset;
input [23:0] data ;
output clk;
output reg SDA;
output reg SCL;
//output reg [7:0] LED;

reg [31:0] counter;
reg clk_status;
reg sda_status;
reg [5:0] send_substate,next_send_substate;
reg [5:0] data_index,next_data_index;
 
//reg [7:0] LED_status;

localparam [9:0] I2C_clock = 1000;
localparam [31:0] I2C_clock_divider = 50000000/(2*I2C_clock);
	localparam [1:0] START = 2'b00,
						  SEND = 2'b01,
						  STOP = 2'b10;
reg [7:0] dummy_data;











initial begin
	counter <= 32'b0;
	clk_status <= 1'b0;
	sda_status <= 1'b0;
end

always @ (posedge i2c_in_clk) 
	begin
	counter <= counter + 1'b1;
		if (counter > 5)//125)//117)//5)//500)
			begin
				clk_status <= !clk_status;
				counter <= 32'b0;
			end


	end


	assign clk = clk_status;
	//assign clk = i2c_in_clk;
	//assign LED = LED_status;
//------------------------------------------------

reg [1:0] next_state,current_state;

reg [4:0] next_substate,current_substate;

always @ (posedge clk,negedge reset) 
	begin
			if(~reset)
				begin
					current_state <= START;
					current_substate <= 0;
					
					//data_index<= 0;
					send_substate <= 0;
					
					dummy_data <= 8'b01010101;
					
				end
			else
				begin
					current_state <=   next_state;
					current_substate <= next_substate;
					
					//data_index <= next_data_index ;
					send_substate <= next_send_substate;
					
					
				end
			
	end

	
						  
						  
	//localparam [7:0] SSD1306_ADDRESS = 8'h78;
	
						  
	always @(*)
		begin
		//LED[1:0] <= current_state;
		//LED[4:2] <= current_substate;
		//LED[7:5] <= send_substate;
			
			case(current_state)
					
						START : 
									begin
											//LED<= 8'b00000001; 
											
											case(current_substate)
															
														0:	
																	begin
																			SDA <= 1'b1;
																			SCL <= 1'b1;
																			next_substate <= 1;
																			next_state <= START;
																			
																	end
														1: 
																	begin
																			SDA <= 1'b0; //add SCL also
																			next_substate <= 2;
																			next_state <= START;
																	end
														2: 
																	begin
																			SCL <= 1'b0; //add SDA also
																			next_substate <= 0 ;
																			next_state <= SEND;
																			
																			
																	end
												endcase
												
											next_data_index   <= 0;
											next_send_substate <=0;
									 
									end
									
									
									
					SEND:
							begin
											//LED[1]<=  1;  
											case(current_substate)
															
														0:	
																	begin
																			//i2c_send(SDA, SCL, data,data_index,send_substate);
																			
																			if(send_substate == 0) 
																				begin
																					//SDA <=data[7]; //data[7] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= 0;
																					//LED[4]<= 1 ;//dummy_data[0] ;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[7] ;
																					SCL <= 1;
																					
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= 0;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[7] ;
																					SCL <= 0;
																					
																					next_state <= SEND;
																					next_send_substate <= 0;
																					next_substate <= 1;
																
																				end
																		SDA <=data[7];
																		next_data_index <= data_index;
																			
																	end
														1: 
																	begin
																			 if(send_substate == 0) 
																				begin
																					//SDA <= data[6] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																					//LED[6]<=  1 ;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[6] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[6] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_state <= SEND;
																					next_substate <= 2;
																				end
																			SDA <= data[6] ;
																			next_data_index <= data_index;

																	end
														2: 
																	begin
																			if(send_substate == 0) 
																				begin
																					//SDA <= data[5] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[5] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[5] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_state <= SEND;
																					next_substate <= 3;
																				end
																			SDA <= data[5];
																			next_data_index <= data_index;
																			  
																	end
														3: 
																	begin
																			if(send_substate == 0) 
																				begin
																					//SDA <= data[4] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																					//LED[6]<=  1 ;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[4] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																					next_data_index <= data_index;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[4] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_state <= SEND;
																					next_substate <= 4;
																				end
																			
																			SDA <= data[4] ;
																			next_data_index <= data_index;
																			  
																	end
														4: 
																	begin
																			if(send_substate == 0) 
																				begin
																					//SDA <= data[3] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																					//LED[6]<=  1 ;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[3] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[3] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_state <= SEND;
																					next_substate <= 5;
																				end
																			SDA <= data[3] ;
																			next_data_index <= data_index;
																			  
																	end
														5: 
																	begin
																			if(send_substate == 0) 
																				begin
																					//SDA <= data[2] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																					//LED[6]<=  1 ;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[2] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[2] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_state <= SEND;
																					next_substate <= 6;
																				end
																			SDA <= data[2] ;
																			next_data_index <= data_index;
																			  
																	end
														6: 
																	begin
																			if(send_substate == 0) 
																				begin
																					//SDA <= data[1] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																					//LED[6]<=  1 ;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[1] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[1] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_state <= SEND;
																					next_substate <= 7;
																				end
																			SDA <= data[1] ;
																			next_data_index <= data_index;
																			  
																	end
														7: 
																	begin
																			if(send_substate == 0) 
																				begin
																					//SDA <= data[0] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																					//LED[6]<=  1 ;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[0] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[0] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_substate <= 24;
																					next_state <= SEND;
																					
																				end
																				
																			SDA <= data[0] ;
																			
																	end
														24: 
																	begin
																			if(send_substate == 0) 
																				begin
																					//SDA <= data[0] ;
																					SCL <= 0;
																					next_state <= SEND;
																					
																					next_substate <= current_substate;
																					//LED[6]<=  1 ;
																					if(SDA  == 1)
																						next_send_substate <= 0;
																					else
																						next_send_substate <= 1;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[0] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[0] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_substate <= 8;
																					next_state <= SEND;
																					
																				end
																																				
																	end
														8:	
																	begin
																			//i2c_send(SDA, SCL, data,data_index,send_substate);
																			
																			if(send_substate == 0) 
																				begin
																					//SDA <=data[15]; //data[7] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																					//LED[4]<= 1 ;//dummy_data[0] ;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[15] ;
																					SCL <= 1;
																					
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[15] ;
																					SCL <= 0;
																					
																					next_state <= SEND;
																					next_send_substate <= 0;
																					next_substate <= 9;
																
																				end
																		SDA <= data[15] ;
																		next_data_index <= data_index;
																			
																	end
														9: 
																	begin
																			 if(send_substate == 0) 
																				begin
																					//SDA <= data[14] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																					//LED[6]<=  1 ;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[14] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[14] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_state <= SEND;
																					next_substate <= 10;
																				end
																			SDA <= data[14] ;
																			next_data_index <= data_index;

																	end
														10: 
																	begin
																			if(send_substate == 0) 
																				begin
																					//SDA <= data[13] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[13] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[13] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_state <= SEND;
																					next_substate <= 11;
																				end
																			SDA <= data[13] ;
																			next_data_index <= data_index;
																			  
																	end
														11: 
																	begin
																			if(send_substate == 0) 
																				begin
																					//SDA <= data[12] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																					//LED[6]<=  1 ;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[12] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																					next_data_index <= data_index;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[12] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_state <= SEND;
																					next_substate <= 12;
																				end
																			
																			SDA <= data[12] ;
																			next_data_index <= data_index;
																			  
																	end
														12: 
																	begin
																			if(send_substate == 0) 
																				begin
																					//SDA <= data[11] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																					//LED[6]<=  1 ;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[11] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[11] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_state <= SEND;
																					next_substate <= 13;
																				end
																				
																			SDA <= data[11] ;
																			next_data_index <= data_index;
																			  
																	end
														13: 
																	begin
																			if(send_substate == 0) 
																				begin
																					//SDA <= data[10] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																					//LED[6]<=  1 ;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[10] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[10] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_state <= SEND;
																					next_substate <= 14;
																				end
																			SDA <= data[10] ;
																			next_data_index <= data_index;
																			  
																	end
														14: 
																	begin
																			if(send_substate == 0) 
																				begin
																					//SDA <= data[9] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																					//LED[6]<=  1 ;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[9] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[9] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_state <= SEND;
																					next_substate <= 15;
																				end
																			SDA <= data[9] ;
																			next_data_index <= data_index;
																			  
																	end
														15: 
																	begin
																			if(send_substate == 0) 
																				begin
																					//SDA <= data[8] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																					//LED[6]<=  1 ;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[8] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[8] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_substate <= 25;
																					next_state <= SEND;
																					
																				end
																			
																			SDA <= data[8] ;
																			
																			  
																	end
														
														25: 
																	begin
																			if(send_substate == 0) 
																				begin
																					//SDA <= data[0] ;
																					SCL <= 0;
																					next_state <= SEND;
																					
																					next_substate <= current_substate;
																					//LED[6]<=  1 ;
																					if(SDA  == 1)
																						next_send_substate <= 0;
																					else
																						next_send_substate <= 1;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[0] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[0] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_substate <= 16;
																					next_state <= SEND;
																					
																				end
																																				
																	end
														
														16:	
																	begin
																			//i2c_send(SDA, SCL, data,data_index,send_substate);
																			
																			if(send_substate == 0) 
																				begin
																					//SDA <=data[23]; //data[7] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																					//LED[4]<= 1 ;//dummy_data[0] ;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[23] ;
																					SCL <= 1;
																					
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[23] ;
																					SCL <= 0;
																					
																					next_state <= SEND;
																					next_send_substate <= 0;
																					next_substate <= current_substate+1;
																
																				end
																		SDA <=data[23];
																		next_data_index <= data_index;
																			
																	end
														17: 
																	begin
																			 if(send_substate == 0) 
																				begin
																					//SDA <= data[22] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																					//LED[6]<=  1 ;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[22] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[22] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_state <= SEND;
																					next_substate <= current_substate+1;
																				end
																			SDA <= data[22] ;
																			next_data_index <= data_index;

																	end
														18: 
																	begin
																			if(send_substate == 0) 
																				begin
																					//SDA <= data[21] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[21] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[21] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_state <= SEND;
																					next_substate <= current_substate+1;
																				end
																			SDA <= data[21] ;
																			next_data_index <= data_index;
																			  
																	end
														19: 
																	begin
																			if(send_substate == 0) 
																				begin
																					//SDA <= data[20] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																					//LED[6]<=  1 ;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[20] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																					next_data_index <= data_index;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[20] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_state <= SEND;
																					next_substate <= current_substate+1;
																				end
																			
																			SDA <= data[20] ;
																			next_data_index <= data_index;
																			  
																	end
														20: 
																	begin
																			if(send_substate == 0) 
																				begin
																					//SDA <= data[19] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																					//LED[6]<=  1 ;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[19] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[19] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_state <= SEND;
																					next_substate <= current_substate+1;
																				end
																			SDA <= data[19] ;
																			next_data_index <= data_index;
																			  
																	end
														21: 
																	begin
																			if(send_substate == 0) 
																				begin
																					//SDA <= data[18] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																					//LED[6]<=  1 ;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[18] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[18] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_state <= SEND;
																					next_substate <= current_substate+1;
																				end
																			SDA <= data[18] ;
																			next_data_index <= data_index;
																			  
																	end
														22: 
																	begin
																			if(send_substate == 0) 
																				begin
																					//SDA <= data[17] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																					//LED[6]<=  1 ;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[17] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[17] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_state <= SEND;
																					next_substate <= current_substate+1;
																				end
																			SDA <= data[17] ;
																			next_data_index <= data_index;
																			  
																	end
														23: 
																	begin
																			if(send_substate == 0) 
																				begin
																					//SDA <= data[16] ;
																					SCL <= 0;
																					next_state <= SEND;
																					next_send_substate <= 1;
																					next_substate <= current_substate;
																					//LED[6]<=  1 ;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[16] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= current_substate;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[16] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_substate <= 0;
																					next_state <= 26;
																					
																				end
																			SDA <= data[16] ;
																			
																			
																			  
																	end
														26: 
																	begin
																			if(send_substate == 0) 
																				begin
																					//SDA <= data[0] ;
																					SCL <= 0;
																					next_state <= SEND;
																					
																					next_substate <= 26;
																					//LED[6]<=  1 ;
																					if(SDA  == 1)
																						next_send_substate <= 0;
																					else
																						next_send_substate <= 1;
																				end
																			
																			else if(send_substate == 1)
																				begin
																					//SDA <= data[0] ;
																					SCL <= 1;
																					next_state <= SEND;
																					next_send_substate <= 2;
																					next_substate <= 26;
																				end
																			else if(send_substate == 2)
																				begin
																					//SDA <= data[0] ;
																					SCL <= 0;
																					next_send_substate <= 0;
																					next_substate <= 0;
																					next_state <= STOP;
																					
																				end
																																				
																	end
												endcase
												
												
									
									
							end
					
					STOP:
							begin
										//LED[2]<=  1;  
										case(current_substate)
													
													0:
														begin
																SDA <= 1'b0;
																SCL <= 1'b0;
																next_substate <= 1 ;
																next_state <= STOP;
														end
													1:
														begin
																SCL <= 1'b1;
																next_substate <= 2 ;
																next_state <= STOP;
														end
													2:
														begin
																SDA <= 1'b1;
																next_substate <= 3 ;
																next_state <= STOP;
														end
													3:   // remove this if not word : double about this state as SCL should remain 1
														begin
																SCL <= 1'b0;
																next_substate <= 3 ;
																next_state <= STOP;
																//LED[3]<=  1;
														end
													
											
										endcase
							end
			endcase			
		
		
		end
	

	
	
endmodule 




//module OLED_driver (CLOCK_50,reset,OPERATION,SDA,SCL, driver_clock,LED);
module OLED_driver (CLOCK_50,reset,OPERATION,data,in_cursor_x,in_cursor_y,SDA,SCL,driver_clock,data_index,data_for_index,busy,font_size,char_size);
	
	input CLOCK_50;
	input reset;
	input [7:0] OPERATION;
	input [15:0] data;
	input [7:0] in_cursor_x,in_cursor_y;
	//output reg driver_clock;
	inout  SDA;
	output  SCL;
	output reg driver_clock;
	output reg [15:0] data_index;
	input [7:0] data_for_index;
	output reg busy;
	input [7:0] font_size;
	input [7:0] char_size;
	//output reg [1:0] LED;
	
	reg [31:0] counter;
	reg [9:0] substate;
	reg [1:0] OLED_write_state;
	reg [2:0] set_cursor_state;
	reg [7:0] state;
	reg [23:0] in_data;
	reg i2c_reset;
	reg [7:0] cursor_x,cursor_y;
	reg [7:0] screen_buffer [7:0][127:0];	
	reg [7 : 0] FONT [0 : 3167] ;
	reg [7:0] char_byte_count;
	reg [15:0] char_pixel_index;
	
		localparam [7:0] SSD1306_ADDRESS =8'h78,
							COMMAND_REG = 8'h80,
							DATA_REG = 8'h40,
							ON_CMD = 8'hAF,
							NORMAL_DISPLAY_CMD = 8'hA6,
							ADDRESSING_MODE = 8'h20,
						   PAGE_ADDRESSING_MODE = 8'h02,
							charge_pump_1 = 8'h8D,
							charge_pump_2 = 8'h14;
							
		
		localparam [7:0] IDLE =0,
							  INIT_OLED= 1,
							  CLEAR_DISPLAY = 2,
							  DISPLAY_CHAR = 3;

	i2c_driver i2c(CLOCK_50,i2c_reset, in_data, clk,SDA,SCL);
	
	initial begin
		counter <= 32'b0;
		driver_clock <= 1'b0;
		
		//state <= IDLE;
		//$readmemh("English_font.hex", FONT ) ;
		
	end
	
	
	

	
	
	
	always @ (posedge driver_clock,posedge reset)
			begin
					
					if(reset)
					begin
								state <= OPERATION;
								//LED[0]<= 1;
								//LED[1]<= 0;
								//LED <= {FONT[0][4],FONT[0][0]};
					end
					else
					begin
					
					case (OPERATION)
								IDLE:
									begin
										
										substate <= 0;
										state <= IDLE;
										i2c_reset <= 0;
										OLED_write_state <= 0;
										set_cursor_state <= 0;
										busy <= 0;
										//LED[0]<= 0;
										//LED[1]<= 1;
										//LED <= {FONT[1][4],FONT[1][0]};
									end
									
								INIT_OLED:
								   begin
										
										//LED[0]<= 1;
										//LED[1]<= 1;
										//LED <= {FONT[2][4],FONT[2][0]};
										if(substate == 0)
											begin
														OLED_write_state <= 0;
														substate         <= substate+1 ;
														busy <= 1;
											end
										else if(substate == 1)
											begin
														OLED_write_task ({ON_CMD,COMMAND_REG,SSD1306_ADDRESS});
														
														
														check_for_next_substate ();
		
														
															
											end
										else if(substate == 2)
											begin
													OLED_write_task ({NORMAL_DISPLAY_CMD,COMMAND_REG,SSD1306_ADDRESS});
														check_for_next_substate ();
		
											end
										else if(substate == 3)
											begin
													OLED_write_task ({ADDRESSING_MODE,COMMAND_REG,SSD1306_ADDRESS});
														check_for_next_substate ();
		
											end
										else if(substate == 4)
											begin
													OLED_write_task ({PAGE_ADDRESSING_MODE,COMMAND_REG,SSD1306_ADDRESS});
														check_for_next_substate ();														

											end
										else if(substate == 5)
											begin
													OLED_write_task ({charge_pump_1,COMMAND_REG,SSD1306_ADDRESS});
													check_for_next_substate ();
											end
										else if(substate == 6)
											begin
													OLED_write_task ({charge_pump_2,COMMAND_REG,SSD1306_ADDRESS});
													check_for_next_substate ();
											end
										else if(substate == 7)
											begin
												substate <=8;
													/*OLED_set_cursor_task(0,0);
													if(set_cursor_state == 4)
														begin
															substate <= substate+1 ;
															OLED_write_state <= 0;
														end
													else
														begin
															substate <= substate;
														end*/
													
											end
										else if(substate == 8)
											begin
														
														state <= state;
														substate <=substate;
														busy <= 0;
														//substate <=8;
											
											end

									end
								CLEAR_DISPLAY:
										begin
											case (substate)
														
																	0: 
																		begin
																			cursor_x<=0;
																			cursor_y<=0;
																			OLED_write_state <= 0;
																			substate <= substate+1 ;
																			state <= CLEAR_DISPLAY;
																			busy <= 1;
																			
																		end
																	1:
																		begin
																			
																			
																			OLED_set_cursor_task(cursor_x,cursor_y);
																			
																			if(set_cursor_state == 4)
																				begin
																					substate <= substate+1 ;
																					OLED_write_state <= 0;
																					set_cursor_state <=0;
																					state <= CLEAR_DISPLAY;
																				end
																			else
																				begin
																					substate <= substate;
																					state <= CLEAR_DISPLAY;
																				end
																		end
																	
																	2: 
																		begin
																				screen_buffer[cursor_y][cursor_x] <= 8'h00;
																				OLED_write_task ({8'h00,DATA_REG,SSD1306_ADDRESS});
																				check_for_next_substate();	
																				state <= CLEAR_DISPLAY;																				
																					
																		end
																	3: 
																		begin
																			
																			if (cursor_x < 127)
																				begin
																						cursor_x <= cursor_x+1;
																						substate <= 1;
																						state <= CLEAR_DISPLAY;
																				end
																			else
																				begin
																						if(cursor_y < 7)
																							begin
																									cursor_y <= cursor_y+1;
																									cursor_x <=0;
																									substate <= 1;
																									state <= CLEAR_DISPLAY;
																									
																							end
																						else
																							begin
																									cursor_x <= 0;
																									cursor_y <= 0;
																									substate <= 4;
																									state <= CLEAR_DISPLAY;
																							end
																				end																			
																																				
																																				
																		end
																	4:
																		begin
																				//LED[0]<= 0;
																				//LED[1]<= 0;
																				//LED <= {FONT[3][4],FONT[3][0]};
																				substate <= 4;
																				state <= DISPLAY_CHAR;
																				busy <= 0;
																				
																		end
																		
											
											
											endcase
										end	
								
								
								DISPLAY_CHAR:
										begin
											case (substate)
														
																	0: 
																		begin
																			cursor_x<=in_cursor_x;
																			cursor_y<=in_cursor_y;
																			char_byte_count <= 0;
																			char_pixel_index <= data;//data;//2146;  //65*33+1
																			data_index <= data;
																			OLED_write_state <= 0;
																			substate <= substate+1 ;
																			state <= state;
																			busy <= 1;
																			
																			
																		end
																	1:
																		begin
																			
																			
																			OLED_set_cursor_task(cursor_x,cursor_y);
																			
																			if(set_cursor_state == 4)
																				begin
																					substate <= substate+1 ;
																					OLED_write_state <= 0;
																					set_cursor_state <=0;
																					state <= state;
																				end
																			else
																				begin
																					substate <= substate;
																					state <= state;
																				end
																		end
																	
																	2: 
																		begin
																				screen_buffer[cursor_y][cursor_x] <= screen_buffer[cursor_y][cursor_x] | data_for_index;
																				OLED_write_task ({screen_buffer[cursor_y][cursor_x] | data_for_index,DATA_REG,SSD1306_ADDRESS});
																				//OLED_write_task ({data_for_index,DATA_REG,SSD1306_ADDRESS});
																				check_for_next_substate();	
																				state <= state;																				
																					
																		end
																	3: 
																		begin
																			
																			if (char_byte_count < (char_size - 1))
																				begin
																						if(char_byte_count % font_size == 1)
																							begin
																									cursor_y <= in_cursor_y+1;//1;
																							end
																						else if(char_byte_count % font_size == 2)
																							begin
																									cursor_y <= in_cursor_y+2;
																							end
																						else if(char_byte_count % font_size == 3)
																							begin
																									cursor_y <= in_cursor_y+3;
																							end
																						else
																							begin
																								cursor_x <= cursor_x+1;
																								cursor_y <=in_cursor_y;//0;
																							end
																						char_byte_count <= char_byte_count + 1;
																						char_pixel_index <= char_pixel_index+1;
																						data_index <= char_pixel_index;
																						substate <= 1;
																						state <= state;
																				end
																			else
																				begin
																						cursor_x <= 0;
																						cursor_y <= 0;
																						substate <= 4;
																						state <= state;
																				end																			
																																				
																																				
																		end
																	4:
																		begin
																				//LED[0]<= 0;
																				//LED[1]<= 0;
																				//LED <= {FONT[3][4],FONT[3][0]};
																				substate <= substate;
																				state <= state;
																				busy <= 0;
																		end
											
											
											endcase
										end				
								
								

					
					endcase
					end

			end
	
	
	always @ (posedge CLOCK_50) 
	begin
	counter <= counter + 1'b1;
		if (counter > 500)//7000)//30000)//300)//500) //50000)//50000000)//50000000)
			begin
				driver_clock <= !driver_clock;
				counter <= 32'b0;
			end

	end
	
	
	
	
	task automatic OLED_set_cursor_task (input [7:0] x,
		input [7:0] y);
		
		
		
		begin: task_4
					case (set_cursor_state)
							
														0:
															begin
																	OLED_write_state <= 0;		
																	set_cursor_state <= 1;
															end
														1:
															begin
																	//OLED_write_task ({x & 8'h0F ,COMMAND_REG,SSD1306_ADDRESS});
																	OLED_write_task ({{4'b0000,x[3:0]} ,COMMAND_REG,SSD1306_ADDRESS});
																	check_for_next_cursor_state();
															end
														2: 
															begin
																	//OLED_write_task ({ 8'h10 + ((x>>4) & 8'h0F),COMMAND_REG,SSD1306_ADDRESS});
																	OLED_write_task ({ 8'h10 + x[7:4],COMMAND_REG,SSD1306_ADDRESS});
																	check_for_next_cursor_state();
															end
														3: 
															begin
																	OLED_write_task ({8'hB0 + y,COMMAND_REG,SSD1306_ADDRESS});
																	check_for_next_cursor_state();
															end
										endcase
				
				
				
				
		end
	
	endtask
	
	
	
	
	
	task automatic check_for_next_cursor_state ();
		
		
		begin: task_5
					if(OLED_write_state == 3)
						begin
							set_cursor_state <= set_cursor_state+1 ;
							OLED_write_state <= 0;
						end
					else
						begin
							set_cursor_state <= set_cursor_state;

						end
		
		end	
	
	endtask
	
	
	
	
	
	
	
	
	task automatic check_for_next_substate ();
		
		
		begin: task_3
					if(OLED_write_state == 3)
															begin
																substate <= substate+1 ;
																OLED_write_state <= 0;
															end
														else
															begin
																substate <= substate;
															end
		
		end	
	
	endtask
	
	task automatic OLED_write_task (
								input [23:0] task_data
							);
				
			begin: task_2
							case (OLED_write_state)
							
														0:
															begin
																	in_data <= task_data;
																	i2c_reset <= 0;
																	OLED_write_state <= OLED_write_state+1;
																
															end
														1:
															begin
																	in_data <= task_data;
																	i2c_reset <= 1;
																	OLED_write_state <= 3;
															end
										endcase
				end	
				
				
	endtask
	
	
	


endmodule








