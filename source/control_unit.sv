/*
  Katie Bauschka
  ECE 437

  Control Unit File
*/

// interface include
`include "control_unit_if.vh"

// all types
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module control_unit (
  control_unit_if cuif
);

  r_t r_instr;
  i_t i_instr;
  j_t j_instr;

  assign r_instr = r_t'(cuif.instr);

  always_comb begin
    cuif.r_type = 1;
    cuif.r_opcode = ADD;
    cuif.opcode = ADDI;
    cuif.aluop = ALU_ADD;
    cuif.RegDst = 0;
    cuif.branch = 0;
    cuif.dREN = 0;
    cuif.MemtoReg = 0;
    cuif.dWEN = 0;
    cuif.ALUsrc = 0;
    cuif.RegWrite = 0;
    cuif.ExtOp = 0;
    cuif.back_pad = 0;
    cuif.jump = 0;
    cuif.shamt = 0;

    if (r_instr.opcode == RTYPE) begin
      cuif.r_type = 1;

      casez (r_instr.funct)
        // R TYPE
        SLL : begin
            cuif.r_opcode = SLL;
            cuif.aluop = ALU_SLL;
            cuif.RegDst = 1;
            cuif.branch = 0;
            cuif.dREN = 0;
            cuif.MemtoReg = 0;
            cuif.dWEN = 0;
            cuif.ALUsrc = 0;
            cuif.RegWrite = 1;
            cuif.ExtOp = 0;
            cuif.back_pad = 0;
            cuif.jump = 0;
            cuif.shamt = {27'b0, r_instr.shamt};
          end
        SRL : begin
            cuif.r_opcode = SRL;
            cuif.aluop = ALU_SRL;
            cuif.RegDst = 1;
            cuif.branch = 0;
            cuif.dREN = 0;
            cuif.MemtoReg = 0;
            cuif.dWEN = 0;
            cuif.ALUsrc = 0;
            cuif.RegWrite = 1;
            cuif.ExtOp = 0;
            cuif.back_pad = 0;
            cuif.jump = 0;
            cuif.shamt = {27'b0, r_instr.shamt};
          end
        JR : begin
            cuif.r_opcode = JR;
            cuif.aluop = ALU_ADD; //this is really a don't care
            cuif.RegDst = 0; //don't care
            cuif.branch = 0;
            cuif.dREN = 0;
            cuif.MemtoReg = 0;
            cuif.dWEN = 0;
            cuif.ALUsrc = 0;
            cuif.RegWrite = 0;
            cuif.ExtOp = 0;
            cuif.back_pad = 0;
            cuif.jump = 2'b01;
            cuif.shamt = 0;
          end
        ADD : begin
            cuif.r_opcode = ADD;
            cuif.aluop = ALU_ADD;
            cuif.RegDst = 1;
            cuif.branch = 0;
            cuif.dREN = 0;
            cuif.MemtoReg = 0;
            cuif.dWEN = 0;
            cuif.ALUsrc = 0;
            cuif.RegWrite = 1;
            cuif.ExtOp = 0;
            cuif.back_pad = 0;
            cuif.jump = 0;
            cuif.shamt = 0;
          end
        ADDU : begin
            cuif.r_opcode = ADDU;
            cuif.aluop = ALU_ADD;
            cuif.RegDst = 1;
            cuif.branch = 0;
            cuif.dREN = 0;
            cuif.MemtoReg = 0;
            cuif.dWEN = 0;
            cuif.ALUsrc = 0;
            cuif.RegWrite = 1;
            cuif.ExtOp = 0;
            cuif.back_pad = 0;
            cuif.jump = 0;
            cuif.shamt = 0;
          end
        SUB : begin
            cuif.r_opcode = SUB;
            cuif.aluop = ALU_SUB;
            cuif.RegDst = 1;
            cuif.branch = 0;
            cuif.dREN = 0;
            cuif.MemtoReg = 0;
            cuif.dWEN = 0;
            cuif.ALUsrc = 0;
            cuif.RegWrite = 1;
            cuif.ExtOp = 0;
            cuif.back_pad = 0;
            cuif.jump = 0;
            cuif.shamt = 0;
          end
        SUBU : begin
            cuif.r_opcode = SUBU;
            cuif.aluop = ALU_SUB;
            cuif.RegDst = 1;
            cuif.branch = 0;
            cuif.dREN = 0;
            cuif.MemtoReg = 0;
            cuif.dWEN = 0;
            cuif.ALUsrc = 0;
            cuif.RegWrite = 1;
            cuif.ExtOp = 0;
            cuif.back_pad = 0;
            cuif.jump = 0;
            cuif.shamt = 0;
          end
        AND : begin
            cuif.r_opcode = AND;
            cuif.aluop = ALU_AND;
            cuif.RegDst = 1;
            cuif.branch = 0;
            cuif.dREN = 0;
            cuif.MemtoReg = 0;
            cuif.dWEN = 0;
            cuif.ALUsrc = 0;
            cuif.RegWrite = 1;
            cuif.ExtOp = 0;
            cuif.back_pad = 0;
            cuif.jump = 0;
            cuif.shamt = 0;
          end
        OR : begin
            cuif.r_opcode = OR;
            cuif.aluop = ALU_OR;
            cuif.RegDst = 1;
            cuif.branch = 0;
            cuif.dREN = 0;
            cuif.MemtoReg = 0;
            cuif.dWEN = 0;
            cuif.ALUsrc = 0;
            cuif.RegWrite = 1;
            cuif.ExtOp = 0;
            cuif.back_pad = 0;
            cuif.jump = 0;
            cuif.shamt = 0;
          end
        XOR : begin
            cuif.r_opcode = XOR;
            cuif.aluop = ALU_XOR;
            cuif.RegDst = 1;
            cuif.branch = 0;
            cuif.dREN = 0;
            cuif.MemtoReg = 0;
            cuif.dWEN = 0;
            cuif.ALUsrc = 0;
            cuif.RegWrite = 1;
            cuif.ExtOp = 0;
            cuif.back_pad = 0;
            cuif.jump = 0;
            cuif.shamt = 0;
          end
        NOR : begin
            cuif.r_opcode = NOR;
            cuif.aluop = ALU_NOR;
            cuif.RegDst = 1;
            cuif.branch = 0;
            cuif.dREN = 0;
            cuif.MemtoReg = 0;
            cuif.dWEN = 0;
            cuif.ALUsrc = 0;
            cuif.RegWrite = 1;
            cuif.ExtOp = 0;
            cuif.back_pad = 0;
            cuif.jump = 0;
            cuif.shamt = 0;
          end
        SLT : begin
            cuif.r_opcode = SLT;
            cuif.aluop = ALU_SLT;
            cuif.RegDst = 1;
            cuif.branch = 0;
            cuif.dREN = 0;
            cuif.MemtoReg = 0;
            cuif.dWEN = 0;
            cuif.ALUsrc = 0;
            cuif.RegWrite = 1;
            cuif.ExtOp = 0;
            cuif.back_pad = 0;
            cuif.jump = 0;
            cuif.shamt = 0;
          end
        SLTU : begin
            cuif.r_opcode = SLTU;
            cuif.aluop = ALU_SLTU;
            cuif.RegDst = 1;
            cuif.branch = 0;
            cuif.dREN = 0;
            cuif.MemtoReg = 0;
            cuif.dWEN = 0;
            cuif.ALUsrc = 0;
            cuif.RegWrite = 1;
            cuif.ExtOp = 0;
            cuif.back_pad = 0;
            cuif.jump = 0;
            cuif.shamt = 0;
          end
      endcase
    end else begin //temp_instr.opcode != RTYPE
      cuif.r_type = 0;

      if ((r_instr.opcode == J) || (r_instr.opcode == JAL)) begin
        cuif.r_type = 0;

        casez (r_instr.opcode)
          J : begin
              cuif.opcode = J;
              cuif.aluop = ALU_ADD; //don't care
              cuif.RegDst = 1;
              cuif.branch = 0;
              cuif.dREN = 0;
              cuif.MemtoReg = 0;
              cuif.dWEN = 0;
              cuif.ALUsrc = 0;
              cuif.RegWrite = 0;
              cuif.ExtOp = 0;
              cuif.back_pad = 0;
              cuif.jump = 2'b10;
              cuif.shamt = 0;
            end
          JAL : begin
              cuif.opcode = JAL;
              cuif.aluop = ALU_ADD; //don't care - connects will be "hardwired"
              cuif.RegDst = 1; // jump will be used with this to pick "31"
              cuif.branch = 0;
              cuif.dREN = 0;
              cuif.MemtoReg = 0;
              cuif.dWEN = 0;
              cuif.ALUsrc = 0;
              cuif.RegWrite = 1;
              cuif.ExtOp = 0;
              cuif.back_pad = 0;
              cuif.jump = 2'b11;
              cuif.shamt = 0;
            end
          endcase
      end else begin //temp_instr.opcode != J or JAL (i_type)
        cuif.r_type = 0;

        casez (r_instr.opcode)
          BEQ : begin
              cuif.opcode = BEQ;
              cuif.aluop = ALU_SUB;
              cuif.RegDst = 1;
              cuif.branch = 2'b01;
              cuif.dREN = 0;
              cuif.MemtoReg = 0;
              cuif.dWEN = 0;
              cuif.ALUsrc = 0;
              cuif.RegWrite = 0;
              cuif.ExtOp = 0;
              cuif.back_pad = 0;
              cuif.jump = 0;
              cuif.shamt = 0;
            end
          BNE : begin
              cuif.opcode = BNE;
              cuif.aluop = ALU_SUB;
              cuif.RegDst = 1;
              cuif.branch = 2'b10;
              cuif.dREN = 0;
              cuif.MemtoReg = 0;
              cuif.dWEN = 0;
              cuif.ALUsrc = 0;
              cuif.RegWrite = 0;
              cuif.ExtOp = 0;
              cuif.back_pad = 0;
              cuif.jump = 0;
              cuif.shamt = 0;
            end
          ADDI : begin
              cuif.opcode = ADDI;
              cuif.aluop = ALU_ADD;
              cuif.RegDst = 0;
              cuif.branch = 0;
              cuif.dREN = 0;
              cuif.MemtoReg = 0;
              cuif.dWEN = 0;
              cuif.ALUsrc = 1;
              cuif.RegWrite = 1;
              cuif.ExtOp = 1; //sign extend
              cuif.back_pad = 0;
              cuif.jump = 0;
              cuif.shamt = 0;
           end
          ADDIU : begin
              cuif.opcode = ADDIU;
              cuif.aluop = ALU_ADD;
              cuif.RegDst = 0;
              cuif.branch = 0;
              cuif.dREN = 0;
              cuif.MemtoReg = 0;
              cuif.dWEN = 0;
              cuif.ALUsrc = 1;
              cuif.RegWrite = 1;
              cuif.ExtOp = 1;
              cuif.back_pad = 0;
              cuif.jump = 0;
              cuif.shamt = 0;
          end
          SLTI : begin
              cuif.opcode = SLTI;
              cuif.aluop = ALU_SLT;
              cuif.RegDst = 0;
              cuif.branch = 0;
              cuif.dREN = 0;
              cuif.MemtoReg = 0;
              cuif.dWEN = 0;
              cuif.ALUsrc = 1;
              cuif.RegWrite = 1;
              cuif.ExtOp = 1;
              cuif.back_pad = 0;
              cuif.jump = 0;
              cuif.shamt = 0;
           end
         SLTIU : begin
              cuif.opcode = SLTIU;
              cuif.aluop = ALU_SLTU;
              cuif.RegDst = 0;
              cuif.branch = 0;
              cuif.dREN = 0;
              cuif.MemtoReg = 0;
              cuif.dWEN = 0;
              cuif.ALUsrc = 1;
              cuif.RegWrite = 1;
              cuif.ExtOp = 1;
              cuif.back_pad = 0;
              cuif.jump = 0;
              cuif.shamt = 0;
           end
          ANDI : begin
              cuif.opcode = ANDI;
              cuif.aluop = ALU_AND;
              cuif.RegDst = 0;
              cuif.branch = 0;
              cuif.dREN = 0;
              cuif.MemtoReg = 0;
              cuif.dWEN = 0;
              cuif.ALUsrc = 1;
              cuif.RegWrite = 1;
              cuif.ExtOp = 0;
              cuif.back_pad = 0;
              cuif.jump = 0;
              cuif.shamt = 0;
           end
          ORI : begin
              cuif.opcode = ORI;
              cuif.aluop = ALU_OR;
              cuif.RegDst = 0;
              cuif.branch = 0;
              cuif.dREN = 0;
              cuif.MemtoReg = 0;
              cuif.dWEN = 0;
              cuif.ALUsrc = 1;
              cuif.RegWrite = 1;
              cuif.ExtOp = 0;
              cuif.back_pad = 0;
              cuif.jump = 0;
              cuif.shamt = 0;
           end
          XORI : begin
              cuif.opcode = XORI;
              cuif.aluop = ALU_XOR;
              cuif.RegDst = 0;
              cuif.branch = 0;
              cuif.dREN = 0;
              cuif.MemtoReg = 0;
              cuif.dWEN = 0;
              cuif.ALUsrc = 1;
              cuif.RegWrite = 1;
              cuif.ExtOp = 0;
              cuif.back_pad = 0;
              cuif.jump = 0;
              cuif.shamt = 0;
           end
          LUI : begin
              cuif.opcode = LUI;
              cuif.aluop = ALU_OR;
              cuif.RegDst = 0;
              cuif.branch = 0;
              cuif.dREN = 0;
              cuif.MemtoReg = 0;
              cuif.dWEN = 0;
              cuif.ALUsrc = 1;
              cuif.RegWrite = 1;
              cuif.ExtOp = 0;
              cuif.back_pad = 1;
              cuif.jump = 0;
              cuif.shamt = 0;
           end
          LW : begin
              cuif.opcode = LW;
              cuif.aluop = ALU_ADD;
              cuif.RegDst = 0;
              cuif.branch = 0;
              cuif.dREN = 1;
              cuif.MemtoReg = 1;
              cuif.dWEN = 0;
              cuif.ALUsrc = 1;
              cuif.RegWrite = 1;
              cuif.ExtOp = 1;
              cuif.back_pad = 0;
              cuif.jump = 0;
              cuif.shamt = 0;
           end
          SW : begin
              cuif.opcode = SW;
              cuif.aluop = ALU_ADD;
              cuif.RegDst = 0;
              cuif.branch = 0;
              cuif.dREN = 0;
              cuif.MemtoReg = 0;
              cuif.dWEN = 1;
              cuif.ALUsrc = 1;
              cuif.RegWrite = 0;
              cuif.ExtOp = 1;
              cuif.back_pad = 0;
              cuif.jump = 0;
              cuif.shamt = 0;
           end
          HALT : begin
              cuif.opcode = HALT;
              cuif.aluop = ALU_ADD; //don't care
              cuif.RegDst = 0;
              cuif.branch = 0;
              cuif.dREN = 0;
              cuif.MemtoReg = 0;
              cuif.dWEN = 0;
              cuif.ALUsrc = 0;
              cuif.RegWrite = 0;
              cuif.ExtOp = 0;
              cuif.back_pad = 0;
              cuif.jump = 0;
              cuif.shamt = 0;
           end
        endcase
      end
    end
  end

endmodule
