module reg(IN, OUT1, OUT2, INADDR, OUT1ADDR, OUT2ADDR, WRITE, CLK, RESET);
    input [7:0] IN;
    input [2:0] INADDR;
    input [2:0] OUT1ADDR;
    input [2:0] OUT2ADDR;
    input WRITE;
    input CLK;
    input RESET;

    output [7:0] OUT1;
    output [7:0] OUT2;

    integer i;
        reg [7:0] regFile [0:7];

    input
        always@(*)
        if (RESET == 1) begin
            #2
            for (i = 0; i < 8; i = i + 1) begin
                regFile [i] = 8'b00000000;
            end
        end
    
    always@(posedge CLK) begin
        if (WRITE == 1'b1 && RESET == 1'b0) begin
            #2 regFile [INADDR] = IN;
        end
    end

    assign #2 OUT1 = regFile[OUT1ADDR];
    assign #2 OUT2 = regFile[OUT2ADDR];
endmodule