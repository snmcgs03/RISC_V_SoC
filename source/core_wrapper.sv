module core_wrapper (
    input  logic        clk,
    input  logic        reset,

    // AHB-lite slave response
    input  logic        hready,
    input  logic        hresp,
    input  logic [31:0] hr_data,    // From AHB interconnect

    input  logic        HSEL1,
    input  logic        HSEL2,

    // Outputs to AHB interconnect
    output logic [31:0] haddr,
    output logic [1:0]  htrans,
    output logic        hwrite,
    output logic [2:0]  hsize,
    output logic [3:0]  hprot,
    output logic [31:0] hwdata,
    output logic        is_signed
);

    // Internal wires between core and glue
    logic [31:0] instruction;
    logic [31:0] mem_out;
    logic [31:0] rs2_data;
    logic [31:0] alu_out;
    logic [31:0] address;
    logic [2:0]  fn3;
    logic        mem_read;
    logic        mem_write;

    // Instantiate RISC-V single cycle processor
    single_cycle_riscV core (
        .clk(clk),
        .reset(reset),
        .instruction(instruction), 
        .rs2_data(rs2_data),
        .alu_out(alu_out),
        .address(address),
        .mem_out(mem_out),         
        .mem_read(mem_read),
        .mem_write(mem_write),
        .fn3(fn3)
    );

    // Instantiate glue logic to convert to AHB-Lite
    master_glue_logic glue (
        .hr_data(hr_data), // Input from AHB interconnect
        .hready(hready),
        .hresp(hresp),
        .fn3(fn3),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .rs2_data(rs2_data),
        .alu_out(alu_out),
        .address(address),
        .htrans(htrans),
        .haddr(haddr),
        .hwdata(hwdata),
        .hprot(hprot),
        .hwrite(hwrite),
        .hsize(hsize),
        .mem_out(mem_out),
        .instruction(instruction),
        .is_signed(is_signed),
        .HSEL1(HSEL1),
        .HSEL2(HSEL2)
    );

endmodule
