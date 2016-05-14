`include "cpu_types_pkg.vh"
`include "register_file_if.vh"

import cpu_types_pkg::*;

module register_file (
    input logic CLK,
    input logic nRST,
    register_file_if.rf io
    );

    word_t [31:0] registers;

    always_ff @ (posedge CLK, negedge nRST)
    begin
        if (nRST == 0) begin
            registers[31:0] <= 0;
        end else if (io.WEN && (io.wsel != 0)) begin
            registers[io.wsel] <= io.wdat;
        end
    end

    assign io.rdat1 = io.rsel1 ? registers[io.rsel1] : 0;
    assign io.rdat2 = io.rsel2 ? registers[io.rsel2] : 0;

endmodule
