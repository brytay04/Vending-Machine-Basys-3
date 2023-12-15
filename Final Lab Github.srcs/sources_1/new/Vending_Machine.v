`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2023 02:54:03 PM
// Design Name: 
// Module Name: Vending_Machine
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


module Vending_Machine(
    input clk,
    input purchase,
    input refund,
    input quarter,
    input nickel,
    input dime,
    output reg [11:0] money = 0,
    output reg q_led, n_led, d_led, // Separate LEDs for each coin
    output reg pur_led,
    output reg dis_led
);

    reg quarter_prev, nickel_prev, dime_prev;
    reg dis_led_signal;

    always @(posedge clk) begin
        quarter_prev <= quarter;
        nickel_prev <= nickel;
        dime_prev <= dime;

        // Additional logic to control LEDs for each coin
        q_led <= (quarter_prev == 1'b0 && quarter == 1'b1) ? 1'b1 : 1'b0;
        n_led <= (nickel_prev == 1'b0 && nickel == 1'b1) ? 1'b1 : 1'b0;
        d_led <= (dime_prev == 1'b0 && dime == 1'b1) ? 1'b1 : 1'b0;

        if (refund == 1) // Make the display on the segment set to zero
            money <= 12'b0;

        else if (quarter_prev == 1'b0 && quarter == 1'b1) // If quarter is inserted
            money <= money + 12'd25; // Money inserted increases by 25 cents

        else if (nickel_prev == 1'b0 && nickel == 1'b1) // If nickel is inserted
            money <= money + 12'd5; // Money inserted increases by 5 cents

        else if (dime_prev == 1'b0 && dime == 1'b1) // If dime is inserted
            money <= money + 12'd10; // Money inserted increases by 10 cents
            
        else if (money == 12'd40)
             pur_led <= 1'b1;
            
        else if (purchase == 1'b1 && money == 12'd40)
            money <= 12'b0 ;
            dis_led <= dis_led_signal ;
    end
endmodule
