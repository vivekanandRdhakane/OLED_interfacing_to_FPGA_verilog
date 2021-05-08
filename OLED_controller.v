




module OLED_controller (CLOCK_50,reset,button,Rx,SDA,SCL,LED);

  input CLOCK_50;
  input reset;
  input button;
  input Rx;
  reg [7:0] UART_Rx_data;
  wire Rx_dval;
  //input [7:0] OPERATION;
  //output reg driver_clock;
  inout  SDA;
  output  SCL;
  reg controller_clock;
  output reg [1:0] LED;
  wire  OLED_driver_clock;

  reg data_received;
  reg oled_idle_done;
  reg [11:0] temp_var;
  reg [31:0] counter;
  reg OLED_driver_reset;
  //reg driver_clock;
  reg [7:0] OPERATION;
  reg [7:0] state;
   reg [7:0] next_state;
  reg next_state_change;
  reg next_state_assigned;

  reg [15:0] data;
  reg [7 : 0] FONT [0 : 7000] ;
  wire [7:0] data_for_index; 
  wire [15:0] data_index;
  wire OLED_driver_busy;
  reg operation_completed;
  wire [7:0] Rx_Data;
  reg [7 : 0] uart_receiver_buf [0 : 30];
  reg [7:0] uart_buf_index;
  reg [7:0] cursor_x,cursor_y,previous_cursor_x;
  reg data_sent;
  reg [7:0] font_size;
  reg [7:0] string_index_counter;
  reg [7:0] string_length;
  wire [7:0] spacing;
  reg [7:0] previous_spacing;
  reg [15:0] spacing_data_index;
  reg one_string_printed;
  reg [7:0] char_size;
  //wire Rx_Dval;
  //reg [7 : 0] FONT [0 : 3167] ;

  localparam [7:0]  IDLE =0,
  STATE_1= 1,
  STATE_2 = 2,
  STATE_3 = 3,
  STATE_4 = 4;


  localparam [7:0] INIT_OLED= 1,
  CLEAR_DISPLAY = 2,
  DISPLAY_CHAR = 3, x_bit2 = 4,x_bit1 = 5,x_bit0 = 6, y_bit = 7, char_start=8, font_size_start=3;
  
  
  /*---------------------------------------------------------------------------
  
  
  
  -------------------------------------------------------------------------*/
  
  
  
  
  
  

  initial begin
   counter <= 32'b0;
    controller_clock <= 1'b0;
//    $readmemh("English_font.hex", FONT ) ;
//
   end


  OLED_driver OLEDDriver(CLOCK_50,OLED_driver_reset,OPERATION,data,cursor_x,cursor_y,SDA,SCL,OLED_driver_clock,data_index,data_for_index,OLED_driver_busy,font_size,char_size);

  uart_rec recv(CLOCK_50,Rx,reset,Rx_Data,Rx_dval);
  //assign UART_Rx_data = Rx_Data;


  assign data_for_index = FONT[data_index];
  assign spacing = FONT[spacing_data_index];

  always @ (posedge controller_clock,posedge reset,posedge button)
    begin

      if(reset)
        begin
          state <= IDLE;
          OLED_driver_reset <= 0;
          OPERATION <= IDLE;
			 next_state_assigned <= 0;
			 string_index_counter <=char_start;
			 previous_spacing <=0; 
			 cursor_x <=0;
			 cursor_y <=0;
          //LED <= {FONT[0][4],FONT[0][0]};
        end

      else if(button)
        begin
          state <= STATE_1;
          OPERATION <= IDLE;
          //LED[0]<= 0;
          //LED[1]<= 1;


        end
		 else if(next_state_change)
			begin
				state <= next_state;
				next_state_assigned <= 1;
			end

      else
        begin
			
			next_state_assigned <= 0;

          case (state)
            IDLE:
              begin
                state <=IDLE; //STATE_1; //IDLE
                OLED_driver_reset <= 0;
                OPERATION <= IDLE;
                operation_completed <= 1;
                temp_var <= (39);
                oled_idle_done <= 1;
					 string_index_counter <=char_start;
					 
					 cursor_x <=0;
						cursor_y <=0;
					 
					 /*
					 if (one_string_printed == 1)
						begin
							previous_spacing <= 16;
						end
					 else
						begin
							previous_spacing <= 0;
						end
					*/
                //LED[0]<= 0;
                //LED[1]<= 0;
              end
            1:

              begin
				  
					Do_operation(INIT_OLED,0);
					
              end

            3:
              begin
						
						Do_operation(CLEAR_DISPLAY,0);
						
              end

            5:
              begin
						  cursor_x <=50;
                    cursor_y <=0;
                     data    <=(uart_receiver_buf[1]-32)*33 + 1;//(temp_var*33)+1; //(uart_receiver_buf[0]-31)*33;//;//-8'h1F)*8'h21; //1189;//+(33*21)-1;
							
				        Do_operation(DISPLAY_CHAR,IDLE);

              end
				6:
				  begin
						
						if( string_index_counter  <= string_length)
							begin
								
							   
								//string_index_counter;
								cursor_y <=uart_receiver_buf[y_bit] - 48;
								data    <= (uart_receiver_buf[string_index_counter]-32)*char_size + 1;//(temp_var*33)+1; //(uart_receiver_buf[0]-31)*33;//;//-8'h1F)*8'h21; //1189;//+(33*21)-1;
								//spacing_data_index <= (uart_receiver_buf[string_index_counter]-32)*33;
								
									
								Do_operation(DISPLAY_CHAR,6);
									
								if (oled_idle_done & operation_completed)
									begin
										
										spacing_data_index <= (uart_receiver_buf[string_index_counter]-32)*char_size;
										
										if(string_index_counter == char_start)
											begin
												cursor_x <= (100 * (uart_receiver_buf[x_bit2]-48)) + (10 * (uart_receiver_buf[x_bit1]-48)) +((uart_receiver_buf[x_bit0]-48));
												
												
												previous_spacing <= spacing;
												
												
											end
										else if(string_index_counter > char_start)
											begin
												if(uart_receiver_buf[string_index_counter] == 73 & uart_receiver_buf[0] == 77)
													begin
															if(uart_receiver_buf[font_size_start] == 50)
																cursor_x <= cursor_x + 8;
															else if (uart_receiver_buf[font_size_start] == 51)
																cursor_x <= cursor_x + 10;
															
													end
													
												else
													begin
														cursor_x <= cursor_x + spacing;//previous_spacing ;
													end
												
												previous_spacing <= spacing;
											end
									
										
										//Do_operation(DISPLAY_CHAR,6);
										
										string_index_counter <= string_index_counter+1;
										
									end
								
								
							end
						else
							begin
								state <=IDLE;
								//one_string_printed <= 1;
								
							end

              end
				
				
				



          endcase




        end

    end



  always @ (negedge CLOCK_50,posedge reset) 
    begin
		if(reset)
        begin

			next_state_change <= 0;
			LED[0]<= 0;
         LED[1]<= 0;
          //LED <= {FONT[0][4],FONT[0][0]};
        end
      else if(Rx_dval == 1)
        begin
          if(Rx_Data == 0)//33)//8'h1E)
            begin
              uart_buf_index <= 0;
              LED[0]<= 1;
              LED[1]<= 0;
              data_received <= 0;
				  string_length <= 0;
				  next_state_change <= 0;
            end
          else if(Rx_Data == 255)//34)//8'h1F)
            begin
              uart_buf_index <= 0;
              LED[0]<= 0;
              LED[1]<= 1;
              data_received <= 1;
              //state <= 5;
				  //next_state <= 6;
				  next_state_change <= 1;
				  font_size <= uart_receiver_buf[font_size_start] - 48;
//				  if (uart_receiver_buf[font_size_start] == 50)
//				  begin
//						char_size <= 33;
//				  end
//				  else if (uart_receiver_buf[font_size_start] == 51)
//				  begin
//						char_size <= 73;
//				  end
//				  else if(uart_receiver_buf[font_size_start] == 52)
//				  begin
//						char_size <= 121;
//				  end
				  //if (next_state == 6)
					//	begin
							if (uart_receiver_buf[0] == 69 & uart_receiver_buf[1] == 78 & uart_receiver_buf[2] == 71)
							begin
								
								next_state <= 6;
								if (uart_receiver_buf[font_size_start] == 50)
								begin
									char_size <= 33;
									$readmemh("English_font_16.hex", FONT ) ;	
								end
								else if (uart_receiver_buf[font_size_start] == 51)
								begin
									char_size <= 73;
									$readmemh("English_font_24.hex", FONT ) ;	
								end
//								else if (uart_receiver_buf[font_size_start] == 52)
//								begin
//									char_size <= 121;
//									$readmemh("English_font_32.hex", FONT ) ;	
//								end
//								else
//								begin
//									char_size <= 33;
//									$readmemh("English_font_16.hex", FONT ) ;	
//								end
								
								
							end
							else if(uart_receiver_buf[0] == 77 & uart_receiver_buf[1] == 65 & uart_receiver_buf[2] == 82)
							begin
							
								next_state <= 6;
								
								if (uart_receiver_buf[font_size_start] == 50)
								begin
									char_size <= 33;
									//$readmemh("Marathi_font_16.hex", FONT ) ;
								end
								else if (uart_receiver_buf[font_size_start] == 51)
								begin
									char_size <= 70;
								   $readmemh("Marathi_font_24.hex", FONT ) ;
								end
//								else if (uart_receiver_buf[font_size_start] == 52)
//								begin
//									char_size <= 125;
//									$readmemh("Marathi_font_32.hex", FONT ) ;
//								end
//								else
//								begin
//									char_size <= 33;
//									$readmemh("Marathi_font_16.hex", FONT ) ;
//									
//								end
							end
							else if(uart_receiver_buf[0] == 67)
							begin
								 next_state <= 3;
							end
							
							else if(uart_receiver_buf[0] == 73)
							begin
								 next_state <= 1;
							end
//							else
//							begin
//								$readmemh("English_font_16.hex", FONT ) ; //Default
//							end
//						
					//	end
				  
				  
            end
          else
            begin
              uart_receiver_buf[uart_buf_index] <= Rx_Data;
              uart_buf_index <= uart_buf_index+1;
				  string_length <= string_length +1;
				  LED[0]<= 1;
				  LED[1]<= 1;
            end

        end
		
		else if(next_state_change)
			begin
			  if (next_state_assigned  == 1)
					begin
						next_state_change <= 0;
					end
				
				
			end

    end




  task automatic Do_operation(input [7:0] in_operation, input [7:0] in_Next_state);


    begin
      if(oled_idle_done == 1)
        begin
          OPERATION <= in_operation;//INIT_OLED;
          OLED_driver_reset <= 0;
        end
      else
        begin
          OPERATION <= IDLE;
          OLED_driver_reset <= 0;
        end


      if(operation_completed ==1)
        begin
          operation_completed <= 0;
        end
      else
        begin
          if(OLED_driver_busy != 1)
            begin
              //state <=2;// STATE_2;
              if(oled_idle_done == 1)
                begin
                  oled_idle_done <= 0;
                  operation_completed <= 1;
                end
              else
                begin
                  state <=in_Next_state;//state+1;// STATE_2;
                  //state <= state+1;// STATE_2;
						
						
                  operation_completed <= 1;
                  oled_idle_done <= 1;		
                end
            end
          else
            begin
              state <= state;
            end
        end


    end	

  endtask

  
  
  
  always @ (posedge CLOCK_50) 
    begin
      counter <= counter + 1'b1;
      if (counter > 10000)//1000000)//10000)//500) //50000)//50000000)//50000000)
        begin
          controller_clock <= !controller_clock;
          //LED[0] <= !LED[0];
          counter <= 32'b0;
        end

    end




endmodule
