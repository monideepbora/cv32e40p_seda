// custom clock gating module for Xilinx FPGAs

//reference : https://forums.xilinx.com/t5/Design-and-Debug-Techniques-Blog/Gated-Clock-Conversion-in-Vivado-Synthesis/ba-p/982650

// this module is based on the clock gating module of OpenMSP430 core
// link: https://opencores.org/projects/openmsp430
// copy of License and copyright information follow.

//----------------------------------------------------------------------------
// Copyright (C) 2009 , Olivier Girard
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions
// are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the authors nor the names of its contributors
//       may be used to endorse or promote products derived from this software
//       without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
// OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
// THE POSSIBILITY OF SUCH DAMAGE
//
//----------------------------------------------------------------------------

module cv32e40p_clock_gate
(
    input  logic clk_i,
    input  logic en_i,
    input  logic scan_cg_en_i,
    output logic clk_o
  );

  //logic clk_en;
    wire clk_en = (en_i | scan_cg_en_i);


    reg enable_latch;
    // latch enable signal when clk_i is low, to be ready for next cycle
    always @(clk_i or clk_en)
        if(~clk_i)
        enable_latch <= clk_en;

    assign clk_o = (clk_i & enable_latch);

  /* always_latch
  begin
     if (clk_i == 1'b0)
       clk_en <= en_i | scan_cg_en_i;
  end */

  //assign clk_o = clk_i & clk_en;

endmodule // cv32e40p_clock_gate