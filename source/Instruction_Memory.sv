//module Instruction_Memory (
//    input  logic        clk,
//    input  logic        reset,          // High: boot phase (write), Low: run phase (read)
//    input  logic        HSEL1,
//    input  logic        rd_en_rom,
//   // input  logic        boot_wr_en,     // Write enable from bootloader
//   // input  logic [31:0] boot_wr_addr,   // Write address from bootloader
//   // input  logic [7:0]  boot_wr_data,   // Data from bootloader
//    input  logic [31:0] address_rom,    // Instruction fetch address (PC)
//    output logic [31:0] instruction     // Instruction to processor
//);

//    // Fixed-size 1KB byte-addressable memory (1024 bytes)
//    logic [7:0] mem [0:1023];

//    always_ff @(posedge clk) begin
//    if (reset) begin
//        // Clear old memory contents
//        for (int i = 0; i < 1024; i++) begin
//            mem[i] <= 8'b0;
//        end
//        // Simultaneously accept boot writes during reset
//     //   if (boot_wr_en && boot_wr_addr < 1024) begin
//       //     mem[boot_wr_addr] <= boot_wr_data;
//       // end
//    end
//end


//     Instruction fetch interface (active only when reset is low)
////    always_ff @(posedge clk) begin
//        if (!reset && rd_en_rom && HSEL1) 
//        begin
//            if ((address_rom [1:0] == 2'b00) && (address_rom <= 1020)) 
//            begin
//                instruction <= {
//                    mem[address_rom + 3],
//                    mem[address_rom + 2],
//                    mem[address_rom + 1],
//                    mem[address_rom + 0]
//                };
//            end else begin
//                instruction <= 32'h00000000;  
//            end
//        end else begin
//            instruction <= 32'h00000000;
//        end
//    end

//endmodule
module Instruction_Memory (
    input  logic        clk,
    input  logic        reset,
    input  logic        HSEL1,
    input  logic        rd_en_rom,
    input  logic [31:0] address_rom,
    output logic [31:0] instruction
);

    logic [7:0] mem [0:1023];  // 1KB byte-addressable

    always_ff @(posedge clk) begin
        if (!reset && rd_en_rom && HSEL1) begin
            if ((address_rom[1:0] == 2'b00) && (address_rom <= 1020)) begin
                instruction <= {
                    mem[address_rom + 3],
                    mem[address_rom + 2],
                    mem[address_rom + 1],
                    mem[address_rom + 0]
                };
            end else begin
                instruction <= 32'h00000000;
            end
        end else begin
            instruction <= 32'h00000000;
        end
    end

endmodule
