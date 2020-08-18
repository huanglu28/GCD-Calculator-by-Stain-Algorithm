`timescale 1ns/1ps  
module gcd_test;
	reg clk,clr,go;
	wire [3:0] gcd;
	reg [3:0] xin;
	reg [3:0] yin;
	always begin
	#5 clk<=~clk;
	end
	stain gcd1(.clk(clk),.clr(clr),.go(go),.xin(xin),.yin(yin),.gcd(gcd));
	initial begin
		clk<=0;
		clr<=1;
		go<=0;
		xin<=12b’000000000000;
		yin<=12b’000000000000;
		#15;
		clr<=0;
		#10;
		go<=1;
		#10;
		xin<=12b’000010010000;
		yin<=12b’000010000100;
	end
	
endmodule