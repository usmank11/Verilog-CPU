module cpu(PC, INSTRUCTION, CLK, RESET);
    input [31:0] INSTRUCTION;
    input CLK;
    input RESET;

    output [31:0] PC;
    reg [31:0] PC;
    wire [31:0] PCRESULT;

    reg writeEnable;
        reg isADD;
        reg isImmediate;
        reg [2:0] aluOp;
        reg [2:0] regRead1Addr;
        reg [2:0] regRead2Addr;
        reg [2:0] writeRegAddr;
        reg [7:0] immediateVal;
        wire [7:0] mux1out;
        wire [7:0] mux2out;
        wire [7:0] ALURESULT;
        wire [7:0] minusVal;
    
    reg [7:0] IN;
        wire [7:0] OUT1;
        wire [7:0] OUT2;

    reg [7:0] OPCODE;
        reg [2:0] DESTINATION;
        reg [2:0] SOURCE1;
        reg [2:0] SOURCE2;

    always@(RESET) begin
        if(RESET == 1) PC = -4;
    end

    adder myadder(PC, PCRESULT);

    always@(posedge CLK) begin
        #1
        PC = PCRESULT;
    end
    
    always@(INSTRUCTION) begin
        OPCODE = INSTRUCTION[31:24];
        #1

        case(OPCODE)
            8'b00000000:
                begin
                    writeEnable = 1'b1;
                    aluOp = 3'b000;
                    isAdd = 1'b1;
                    isImmediate = 1'b0;
                end
            8'b00000001:
                begin
                    writeEnable = 1'b1;  
                    aluOp = 3'b000;
                    isAdd = 1'b1;
                    isImmediate = 1'b0;
                end
            8'b00000010:
                begin
                    writeEnable = 1'b1;
                    aluOp = 3'b001;
                    isAdd = 1'b1;
                    isImediate = 1'b0;
                end
            8'b00000011:
                begin
                    writeEnable = 1'b1;
                    aluOp = 3'b001;
                    isAdd = 1'b0;
                    isImediate = 1'b0;
                end
            8'b00000100:
                begin
                    writeEnable = 1'b1;
                    aluOp = 3'b010;
                    isAdd = 1'b1;
                    isImediate = 1'b0; 
                end
            8'b00000101:
                begin
                    writeEnable = 1'b1;
                    aluOp = 3'b011;
                    isAdd  =1'b1;
                    isImediate = 1'b0; 
                end
        endcase
    end
endmodule