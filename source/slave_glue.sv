/*module slave_glue (
    input  logic [31:0] haddr,
    input  logic [31:0] hwdata,
    input  logic [1:0]  htrans,
    input  logic [3:0]  hprot,
    input  logic        hwrite,
  //  input  logic [2:0]  hsize,

    output logic        wr_en_ram,
    output logic        rd_en_ram,
    output logic        rd_en_rom,
    output logic [31:0] wr_data_ram,
    output logic [31:0] address_rom,
    output logic [31:0] address_ram,
    output logic        hready_inst,
    output logic        hresp_inst,
    output logic        hresp_data,
    output logic        hready_data
);

always_comb begin
    wr_en_ram    = 0;
    rd_en_ram    = 0;
    rd_en_rom    = 0;
    wr_data_ram  = 32'b0;
    address_ram  = 32'b0;
    address_rom  = 32'b0;
    hready_inst     = 1;
    hready_data     = 1;
    hresp_inst      = 0;
    hresp_data      = 0;

    if (haddr[31:24] == 8'hB0) begin  // RAM access
        address_ram = haddr;
        if (hwrite) begin
            wr_en_ram   = 1;
            wr_data_ram = hwdata;
        end else begin
            rd_en_ram = 1;
        end
        hresp_data  = 0;
        hready_data = 1;

    end else if (haddr[31:24] == 8'hA0) begin  // ROM access
        address_rom = haddr;
        if (hwrite) begin
            hresp_inst  = 1;  // write not allowed
            hready_inst = 1;

        end else if (hprot[0]) begin  // opcode fetch not allowed
            hresp_inst  = 1;
            hready_inst = 1;

        end else begin  // valid ROM read
            rd_en_rom = 1;
            hresp_inst   = 0;
            hready_inst  = 1;
        end
    end
end

endmodule
module slave_glue (
    input  logic [31:0] haddr,
    input  logic [31:0] hwdata,
    //input  logic [1:0]  htrans,
    input  logic [3:0]  hprot,
    input  logic        hwrite,
    //input  logic [2:0]  hsize,

    output logic        wr_en_ram,
    output logic        rd_en_ram,
    output logic        rd_en_rom,
    output logic [31:0] wr_data_ram,
    output logic [31:0] address_rom,
    output logic [31:0] address_ram,
    output logic        hready_inst,
    output logic        hresp_inst,
    output logic        hresp_data,
    output logic        hready_data
);

always_comb begin
    wr_en_ram    = 0;
    rd_en_ram    = 0;
    rd_en_rom    = 0;
    wr_data_ram  = 32'b0;
    address_ram  = 32'b0;
    address_rom  = 32'b0;
    hready_inst     = 1;
    hready_data     = 1;
    hresp_inst      = 0;
    hresp_data      = 0;

    if (haddr[31:24] == 8'hB0) begin  // RAM access
        address_ram = haddr;
        if (hwrite) begin
            wr_en_ram   = 1;
            wr_data_ram = hwdata;
        end else begin
            rd_en_ram = 1;
        end
        hresp_data  = 0;
        hready_data = 1;

    end else if (haddr[31:24] == 8'hA0) begin  // ROM access
        address_rom = haddr;
        if (hwrite) begin
            hresp_inst  = 1;  // write not allowed
            hready_inst = 1;

        end else if (hprot[0]) begin  // opcode fetch not allowed
            hresp_inst  = 1;
            hready_inst = 1;

        end else begin  // valid ROM read
            rd_en_rom = 1;
            hresp_inst   = 0;
            hready_inst  = 1;
        end
    end
end

endmodule*/
module slave_glue (
    input  logic [31:0] haddr,
    input  logic [31:0] hwdata,
    //input  logic [1:0]  htrans,
    input  logic [3:0]  hprot,
    input  logic        hwrite,
    //input  logic [2:0]  hsize,

    output logic        wr_en_ram,
    output logic        rd_en_ram,
    output logic        rd_en_rom,
    output logic [31:0] wr_data_ram,
    output logic [31:0] address_rom,
    output logic [31:0] address_ram,
    output logic        hready_inst,
    output logic        hresp_inst,
    output logic        hresp_data,
    output logic        hready_data
);

always_comb begin
    wr_en_ram    = 0;
    rd_en_ram    = 0;
    rd_en_rom    = 0;
    wr_data_ram  = 32'b0;
    address_ram  = 32'b0;
    address_rom  = 32'b0;
    hready_inst     = 1;
    hready_data     = 1;
    hresp_inst      = 0;
    hresp_data      = 0;

    if (haddr[31:24] == 8'hB0) begin  // RAM access
        address_ram = haddr;
        if (hwrite) begin
            wr_en_ram   = 1;
            wr_data_ram = hwdata;
        end else begin
            rd_en_ram = 1;
        end
        hresp_data  = 0;
        hready_data = 1;

    end else if (haddr[31:24] == 8'hA0) begin  // ROM access
        address_rom = haddr;
        if (hwrite) begin
            hresp_inst  = 1;  // write not allowed
            hready_inst = 1;

        end else if (hprot[0]) begin  // opcode fetch not allowed
            hresp_inst  = 1;
            hready_inst = 1;

        end else begin  // valid ROM read
            rd_en_rom = 1;
            hresp_inst   = 0;
            hready_inst  = 1;
        end
    end
end

endmodule

