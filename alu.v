module alu(DATA1, DATA2, RESULT, SELECT, ZERO);
    //8 bit inputs
    input [7:0] DATA1;
    input [7:0] DATA2;

    //3 bit select
    input [2:0] SELECT;

    //8 bit output
    output [7:0] RESULT;

    //1 bit for 0
    output ZERO;

    reg [7:0] RESULT;
    reg ZERO;
    reg [7:0] RightShiftResult;

    barrelShifter RightLogicalShift(DATA1, DATA2[7:5], RightShiftResult);

    always@(DATA1, DATA2, SELECT) begin
        case(SELECT)
        3'b000:
        #1 RESULT = DATA2; //Forward
        3'b001:
        #2 RESULT = DATA1 + DATA2; //add and sub
        3'b010:
        #1 RESULT = DATA1 & DATA2; //AND
        3'b011:
        #1 RESULT = DATA1 | DATA2; //OR
        3'b100:
        RESULT = RightShiftResult;
        3'b101:
        RESULT = 8'b00000000; 
        3'b110:
        RESULT = 8'b00000000; 
        3'b111:
        RESULT = 8'b00000000;
        endcase
    end

    //Zero bit
    always@(RESULT) begin
        ZERO = RESULT[0]~|RESULT[1]~|RESULT[2]~|RESULT[3]~|RESULT[4]~|RESULT[5]~|RESULT[6]~|RESULT[7];
    end
endmodule