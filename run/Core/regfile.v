`timescale 1ns / 1ps

module regfile #(
    parameter WIDTH = 16,
    parameter SIZE  = 8
)(
    input  wire                     clk,
    input  wire                     rst_n,
    input  wire                     input_valid,
    input  wire [WIDTH-1:0]         data_in,
    output wire [(SIZE*WIDTH)-1:0]  data_out_flat
);

    reg [WIDTH-1:0] regfile [0:SIZE-1];
    reg [WIDTH-1:0] data_negedge;
    integer         i;

    // Flatten regfile array to output bus.
    genvar gi;
    generate
        for (gi = 0; gi < SIZE; gi = gi + 1) begin : gen_pack_out
            assign data_out_flat[(SIZE - gi) * WIDTH - 1 -: WIDTH] = regfile[gi];
        end
    endgenerate

    // Latch data on negedge (mid-cycle stable after upstream posedge update).
    always @(negedge clk or negedge rst_n) begin
        if (!rst_n)
            data_negedge <= {WIDTH{1'b0}};
        else if (input_valid)
            data_negedge <= data_in;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < SIZE; i = i + 1) begin
                regfile[i] <= {WIDTH{1'b0}};
            end
        end else begin
            if (input_valid) begin
                for (i = 0; i < SIZE - 1; i = i + 1) begin
                    regfile[i] <= regfile[i+1];
                end
                regfile[SIZE-1] <= data_negedge;
            end
        end
    end

endmodule