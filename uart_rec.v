// Code your design here
module uart_rec( input clk,Rx,reset,
				 output [7:0] Rx_data,
				 output Rx_dval,
				 output reg Rx_idle);
localparam idle=3'b000;
localparam start_bit=3'b001;
localparam data_bits=3'b010;
localparam stop_bit=3'b011;
localparam clean=3'b100;
localparam clk_per_bits= 434;//5208;//5208;//434;

reg [31:0] clock_count;
reg [31:0] bit_index;
reg data_valid;
reg [7:0] data;
reg [2:0] pr_state;
  
always @(posedge clk,posedge reset)
begin
	
	if(reset)
        begin
				clock_count<=0;
				pr_state<=idle;
				data_valid<=1'b0;
		  end
	
	else
	begin
		 case(pr_state)
			idle: 
				begin
					data_valid<=1'b0;
					clock_count<=0;
					bit_index<=0;
					if(Rx==1'b1)
						begin
							pr_state<=idle;
							Rx_idle<=1'b1;
						end
					else
						begin
							pr_state<=start_bit;
							data<=7'b0;
							Rx_idle<=1'b0;
						end	
				end
			start_bit: 
				begin
					if(clock_count==clk_per_bits/2)
						begin
							if(Rx==1'b0)
								begin
									clock_count<=0;
									pr_state<=data_bits;
								end
							else
								begin
									pr_state<=idle;
									clock_count<=0;
								end
						end
					else
						begin
							clock_count<=clock_count+1;
							pr_state<=start_bit;
						end
				end
			data_bits:
				begin
					if (bit_index<=7)
						begin
							if(clock_count==clk_per_bits)
								begin
									data[bit_index]<=Rx;
									bit_index<=bit_index+1;
									clock_count<=0;
									pr_state<=data_bits;
								end
							else
								begin
									clock_count<=clock_count+1;
									pr_state<=data_bits;
								end
						end
					else
								begin
									clock_count<=0;
									pr_state<=stop_bit;
								end	
				end
			stop_bit:
				begin
					if(clock_count==clk_per_bits)
						begin
							clock_count<=0;
							data_valid<=1'b1;
							pr_state<=clean;
						end
					else
						begin
							clock_count<=clock_count+1;
							pr_state<=stop_bit;
						end
				end
			clean:
				begin
					clock_count<=0;
					pr_state<=idle;
					data_valid<=1'b0;
					//data<=7'b0;
				end
			default:
				begin
					pr_state<=idle;
				end
		endcase
   end
end
assign Rx_dval=data_valid;
assign Rx_data=data;
endmodule 