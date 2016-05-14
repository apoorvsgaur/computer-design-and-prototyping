`include "cpu_types_pkg.vh"
`include "alu_if.vh"

import cpu_types_pkg::*;

module alu(
	alu_if.ula io
	);

    logic [31:0] output_temp;
    logic of_temp;

    always_comb begin
        of_temp = 0;
        output_temp = 0;
        if (io.opcode == ALU_SLL) begin
        	// shift left
            output_temp = io.port_a << io.port_b;
        end else if (io.opcode == ALU_SRL) begin
        	// shift right
            output_temp = io.port_a >> io.port_b;
        end else if (io.opcode == ALU_ADD) begin
            // add
            output_temp = $signed(io.port_a) + $signed(io.port_b);
            if (io.port_a[31] == io.port_b[31]) begin
                if (io.port_o[31] != io.port_a[31]) begin
                    of_temp = 1;
                end
            end
        end else if (io.opcode == ALU_SUB) begin
            // sub
            output_temp = $signed(io.port_a) - $signed(io.port_b);
            if ((io.port_a[31] != io.port_b[31]) == 1) begin
                if (io.port_o[31] == io.port_b[31]) begin
                    of_temp = 1;
                end
            end
        end else if (io.opcode == ALU_AND) begin
            // and
            output_temp = io.port_a & io.port_b;
        end else if (io.opcode == ALU_OR) begin
            // or
            output_temp = io.port_a | io.port_b;
        end else if (io.opcode == ALU_XOR) begin
            // xor
            output_temp = io.port_a ^ io.port_b;
        end else if (io.opcode == ALU_NOR) begin
            // nor
            output_temp = ~(io.port_a | io.port_b);
        end else if (io.opcode == ALU_SLT) begin
            // set less than signed
            output_temp = ($signed(io.port_a) < $signed(io.port_b)) ? 1 : 0;
        end else if (io.opcode == ALU_SLTU) begin
            // set less than unsigned
            output_temp = (io.port_a < io.port_b) ? 1 : 0;
        end
    end

    assign io.port_o = output_temp[31:0];
    assign io.z_flag = (output_temp == 0) ? 1 : 0;
    assign io.of_flag = of_temp;
    assign io.neg_flag = output_temp[31];

endmodule