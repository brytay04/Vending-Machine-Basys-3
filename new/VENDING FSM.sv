`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2023 02:37:35 PM
// Design Name: 
// Module Name: VENDING FSM
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


module VENDING FSM(
module vending_machine_fsm (
    input wire clk,
    input wire btn_north,
    input wire btn_south,
    input wire btn_west,
    input wire btn_center,
    input wire btn_east,
    output wire led0,
    output wire led1
);

// Internal signals
reg [2:0] state, next_state;
reg [3:0] count;
reg purchase_ready, dispense_item;

// FSM states
parameter IDLE = 3'b000, // Initial state
          DEPOSIT_NICKEL = 3'b001,
          DEPOSIT_DIME = 3'b010,
          DEPOSIT_QUARTER = 3'b011,
          PURCHASE_READY = 3'b100,
          DISPENSE_ITEM = 3'b101,
          ILLEGAL_STATE = 3'b110;

// Instantiate debounce and one-shot modules
debounce_one_shot u_btn_north (
    .clk(clk),
    .btn(btn_north),
    .debounced_btn(btn_north_debounced),
    .one_shot(btn_north_one_shot)
);

debounce_one_shot u_btn_south (
    // Similar instantiation for other buttons...
);

debounce_one_shot u_btn_west (
    // Similar instantiation for other buttons...
);

debounce_one_shot u_btn_center (
    // Similar instantiation for other buttons...
);

debounce_one_shot u_btn_east (
    // Similar instantiation for other buttons...
);

// Instantiate state_decoder module
state_decoder u_state_decoder (
    .state(state),
    .led0(led0),
    .led1(led1)
);

always_ff @(posedge clk) begin
    // Your FSM logic here...

end
);
endmodule
