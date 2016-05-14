`ifndef ALU_IF_VH
`define ALU_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface alu_if;
    // import types
    import cpu_types_pkg::*;

    word_t port_a, port_b, port_o;
    aluop_t opcode;
    logic neg_flag, of_flag, z_flag;

    // alu ports
    modport ula (
        input port_a, port_b, opcode,
        output neg_flag, port_o, of_flag, z_flag
        );
    // alu ports tb
    modport tb (
        input neg_flag, port_o, of_flag, z_flag,
        output port_a, port_b, opcode
        );
endinterface

`endif //ALU_IF_VH