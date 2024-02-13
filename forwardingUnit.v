`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2023 12:46:35 PM
// Design Name: 
// Module Name: forwardingUnit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module forwardingUnit(forwardA, forwardB, ID_EX_Rs, ID_EX_Rt, EX_MEM_Rd, MEM_WB_Rd, EX_MEM_RegWrite, EX_MEM_MemWrite, MEM_WB_RegWrite);
    
    output [1:0] forwardA, forwardB;
    input [4:0] ID_EX_Rs, ID_EX_Rt, EX_MEM_Rd, MEM_WB_Rd;
    input EX_MEM_RegWrite, EX_MEM_MemWrite, MEM_WB_RegWrite; 

    assign forwardA = ((EX_MEM_Rd == ID_EX_Rs) && (EX_MEM_Rd != 5'b0) && (EX_MEM_RegWrite)) ? 2'b10 : // One-Ahead                       
        ((MEM_WB_Rd == ID_EX_Rs) && (MEM_WB_Rd != 5'b0) && (MEM_WB_RegWrite)) ? 2'b01 : 2'b00;        // Two-Ahead
        
    assign forwardB = ((EX_MEM_Rd == ID_EX_Rt) && (EX_MEM_Rd != 5'b0) && (EX_MEM_RegWrite || EX_MEM_MemWrite)) ? 2'b10 : // One-Ahead 
        ((MEM_WB_Rd == ID_EX_Rt) && (MEM_WB_Rd != 5'b0) && (MEM_WB_RegWrite)) ? 2'b01 : 2'b00;                           // Two-Ahead
        
endmodule
