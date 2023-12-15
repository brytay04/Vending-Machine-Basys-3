`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2023 10:54:00 PM
// Design Name: 
// Module Name: one-shot
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


module oneshot(
    input clk,
    input money,
    input purchase,
    output reg dis_led_signal
);

    // store 26-bit count - BETTER TO SLOW CLOCK DOWN!
    // for a 100MHz clock, 26'h2000000 delays ~4 sec
    // (note this defines a 26-bit value in hex)
    reg [25:0] count;
    reg y; // Added declaration for y

    // change state on the rising edge of the clock
    always @(posedge clk)
    begin
        // start on rising edge
        if ((purchase == 1) && (money == 12'd40))
        begin
            y <= 1;
            count <= 0;
        end
        // count reached max value
        else if ((y == 1) && (count < 26'h2000000))
        begin
            count <= count + 1;
        end
        // else, done
        else
        begin
            count <= 0;
            y <= 0;
        end
        // Assign the output
        dis_led_signal <= y;
    end
endmodule

