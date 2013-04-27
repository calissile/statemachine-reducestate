module fsm(output reg z, 
	output reg [0:2] nstate,
	output reg [0:2] pstate,
	output reg [0:4] ncount,
	output reg [0:4] pcount,
	input q,
	clk,
	init);

parameter A=3'b000, C=3'b001, EH=3'b010, BD=3'b011, FG=3'b100;

always@(posedge(clk))
begin
	pstate <= nstate;
	pcount <= ncount;
end


always@(*)
begin
	if(~init)
		nstate <= A;
	else begin
	case(pstate)
	A: {nstate, z} <= (q? {C, 1'b0}:{FG,1'b0});
	EH: {nstate, z} <= (q? {FG, 1'b0}:{A,1'b0});
	BD: {nstate, z} <= (q? {FG, 1'b0}:{EH,1'b0});
	FG: {nstate, z} <= {BD, 1'b0};

	C: 
	if(q == 1) begin
		nstate <= C;
		ncount <= 0;
		z <= 1'b0;
	end
	else begin
	if(pcount < 18) 
	begin
		nstate <= C;
		ncount <= pcount + 1;
		z <= 1'b1;
	end
	else
	     begin			
		nstate <= EH;
		ncount <= 18;
		z <= 1'b1;
	     end
	end
	
	default:
	begin
		nstate <= A;
		z <= 0;
	end
	endcase
	end
end
endmodule


module testcode(output reg clk, output reg init, output reg q);
initial
begin
    $dumpvars;
    $dumpfile("prac2.dump");
    init = 0;
    clk = 1;
    q = 0;
#5  clk = 0; 
    init = 1;
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 1;
    clk = 1;
#5  clk = 0; 
#5  q = 1;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 1;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 1;
    clk = 1;
#5  clk = 0; 
#5  q = 1;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
#5  q = 0;  
    clk = 1;
#5  clk = 0; 
#5  q = 0;
    clk = 1;
#5  clk = 0; 
end
endmodule

module testbench;
wire z; 
wire [0:2] nstate;
wire [0:2] pstate;
wire [0:4] ncount;
wire [0:4] pcount;
wire q;
wire clk;
wire init;

fsm(z,nstate,pstate,ncount,pcount,q,clk,init);
testcode(clk,init,q);
endmodule

