`timescale 1ns/1ps

module RISCV_SoC_tb;

  logic clk;
  logic reset;

  // Clock generation: 100 MHz (10 ns)
  always #5 clk = ~clk;

  // Instantiate DUT
  RISCV_SoC dut (
    .clk(clk),
    .reset(reset)
  );

  // Load instruction memory from hex file using hierarchical reference
  initial begin
    // Initialize signals
    clk = 0;
    reset = 1;

    $display("Simulation started...");

    // Load instructions into memory (assumes byte-wise memory inside slave_wrapper)
   $readmemh("C:/Users/DELL/Desktop/riscvsoc/riscvsoc.srcs/sim_1/new/machine_code_fibonnaci.hex",dut.slave_mem.instruction_memory.mem);

    $display("Instruction memory loaded.");

    // Deassert reset after few cycles
    repeat (5) @(posedge clk);
    reset = 0;

    // Run simulation
    repeat (1000) @(posedge clk);

    $display("Simulation finished.");
    $finish;
  end

endmodule
