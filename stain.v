module stain(
			input [11:0] A,  
			input [11:0] B,
			input clk,    
			input clr, 
			output reg [11:0] gcd
			);

reg [11:0] A_temp,B_temp,C,gcd_temp;
reg [4:0] state;
parameter    isdone='b00001,
			 judge='b00010;
			// N03='b00100,
			// N04='b01000,
			// N05='b10000;
always @(posedge clk)
begin
	if(clr==1)
		begin
			A_temp<=A;
			B_temp<=B;
			gcd_temp=0;
			C<=1'b1;
			state<=isdone;
		end
	else
		begin
			case(state)
				isdone:
				if(A_temp==0)
					begin
						gcd_temp<=B_temp;
					end 
				else if(B_temp==0)
					begin 
						gcd_temp<=A_temp;
					end 
				else
					begin
						state=judge;
					end
		
				judge:
				begin  
					state<=isdone;
					if(A_temp[0]==0&&B_temp[0]==0)
						begin
							A_temp<=(A_temp>>1);
							B_temp<=(B_temp>>1);
							C<=(C<<1);
						end
					else if(A_temp[0]==1'b1&&B_temp[0]==1'b1)
						begin
							if(A_temp>B_temp)
								begin
									A_temp<=A_temp-B_temp;
								end
								else
								begin
									B_temp<=B_temp-A_temp;
								end
						end 
					else if(A_temp[0]==1'b0&&B_temp[0]==1'b1) 
						begin
							A_temp<=(A_temp>>1);
						end 
					else 
						begin
							B_temp<=(B_temp>>1);
						end 
				end 
		//default: state<=N01;
			endcase	
		end 
end 
always @(posedge clk)
begin
	gcd<=gcd_temp*C;
end 
endmodule 
