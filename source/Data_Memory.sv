module Data_Memory (
    input  logic        clk,
    input  logic        mem_write,
    input  logic        mem_read,
    input  logic [31:0] address_ram,
    input  logic        HSEL2,
    input  logic [31:0] write_data,
    input  logic        reset,
    output logic [31:0] read_data
);

    logic [7:0] mem [0:1023]; // 1024 bytes (byte-addressable)

    // Write + Reset logic
    always_ff @(posedge clk) begin
        if (reset) begin
            // Clear memory on reset
            for (int i = 0; i < 1024; i++) begin
                mem[i] <= 8'b0;
            end
        end else if (mem_write && HSEL2) begin
            mem[address_ram]     <= write_data[7:0];
            mem[address_ram + 1] <= write_data[15:8];
            mem[address_ram + 2] <= write_data[23:16];
            mem[address_ram + 3] <= write_data[31:24];
        end
    end

    // Read operation (combinational)
    always_comb begin
        if (mem_read && HSEL2) begin
            read_data = {mem[address_ram + 3], mem[address_ram + 2], mem[address_ram + 1], mem[address_ram]};
        end else begin
            read_data = 32'b0;
        end
    end

endmodule
