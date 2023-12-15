`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2023 01:57:57 PM
// Design Name: 
// Module Name: TOP
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

module Top_Module(
    input clk,
    input btnU,   // purchase
    input btnD,   // refund 
    input btnL,   // Quarter $0.25
    input btnR,   // Nickel $0.05
    input btnC,   // Dime $0.10
    output [6:0] seg,
    output [3:0] an,
    output pur_led,
    output dis_led,
    output q_led,
    output n_led,
    output d_led
);

    wire [11:0] money;
    wire deb_btnU, deb_btnD, deb_btnL, deb_btnR, deb_btnC;

    Debounce dbnU(clk, btnU, deb_btnU);  // purchase
    Debounce dbnD(clk, btnD, deb_btnD);  // refund 
    Debounce dbnL(clk, btnL, deb_btnL);  // Quarter $0.25
    Debounce dbnR(clk, btnR, deb_btnR);  // Nickel $0.05
    Debounce dbnC(clk, btnC, deb_btnC);  // Dime $0.10

    wire [3:0] thous, hunds, tens, ones;

    Binary_to_BCD BCD(money, thous, hunds, tens, ones);
    Seven_Seg_Driver SSD(clk, deb_btnU, tens, ones, seg, an);

    Vending_Machine vm(
        .clk(clk),
        .purchase(deb_btnU),
        .refund(deb_btnD),
        .quarter(deb_btnL),
        .nickel(deb_btnR),
        .dime(deb_btnC),
        .money(money),
        .pur_led(pur_led),
        .dis_led(dis_led),
        .q_led(q_led),
        .n_led(n_led),
        .d_led(d_led)
    );
    
    oneshot os(
        .clk(clk),
        .money(money),
        .purchase(deb_btnU),
        .dis_led_signal(dis_led)
    );

endmodule
