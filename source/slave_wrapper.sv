/*module slave_wrapper (
  input  logic        clk,
  input  logic        reset,
 // input  logic        boot_wr_en,
  //input  logic [31:0] boot_wr_addr,
  //input  logic [7:0]  boot_wr_data,

  input logic HSEL1,HSEL2,

  input  logic [31:0] haddr,
  input  logic [31:0] hwdata,
  input  logic [3:0]  hprot,
  input  logic        hwrite,
  input  logic [2:0]  hsize,
  input  logic        is_signed,

  output logic [31:0] instruction,   // From Instruction_Memory
  output logic [31:0] load_out,
//  output logic [31:0] store_data,
  output logic        hready_inst,
  output logic        hready_data,
  output logic        hresp_inst,
  output logic        hresp_data
);

  // Internal wires
  logic        wr_en_ram;
  logic        rd_en_ram;
  logic        rd_en_rom;
  logic [31:0] wr_data_ram;
  logic [31:0] address_rom;
  logic [31:0] address_ram;
  //logic [31:0] ramdata;
  logic [31:0] read_data;
  logic [31:0] store_out; 

  //--------------------------------------
  // Glue Logic
  //--------------------------------------
  slave_glue slave_glue_logic (
    .haddr(haddr),
    .hwdata(hwdata),
    .hprot(hprot),
    .hwrite(hwrite),
    //.hsize(hsize),
   // .is_signed(is_signed),
    .wr_en_ram(wr_en_ram),
    .rd_en_ram(rd_en_ram),
    .rd_en_rom(rd_en_rom),
    .wr_data_ram(wr_data_ram),
    .address_rom(address_rom),
    .address_ram(address_ram),
    .hready_inst(hready_inst),
    .hready_data(hready_data),
    .hresp_inst(hresp_inst),
    .hresp_data(hresp_data)
  );

  //--------------------------------------
  // Load Unit
  //--------------------------------------
  slave_load load_addressing (
    .hsize(hsize),
    .is_signed(is_signed),
    .read_data(read_data),
    .load_out(load_out)
  );

  //--------------------------------------
  // Store Unit
  //--------------------------------------
  slave_store store_addressing (
    .hsize(hsize),
    .read_data(read_data),
    .wr_data_ram(wr_data_ram),
    .store_out(store_out)
  );

  //--------------------------------------
  // Data Memory Instance
  //--------------------------------------
  Data_Memory data_memory (
    .clk(clk),
    .reset(reset),
    .mem_write(wr_en_ram),
    .mem_read(rd_en_ram),
    .address_ram(address_ram),
    .write_data(store_out),
    .read_data(read_data),
    .HSEL2(HSEL2)
    
  );

  //--------------------------------------
  // Instruction Memory Instance
  //--------------------------------------
  Instruction_Memory instruction_memory (
    .clk(clk),
    .reset(reset),
    .HSEL1(HSEL1), // Always enabled for this wrapper
    .rd_en_rom(rd_en_rom),
   // .boot_wr_en(boot_wr_en),
   // .boot_wr_addr(boot_wr_addr),
   // .boot_wr_data(boot_wr_data),
    .address_rom(address_rom),
    .instruction(instruction)
  );

  // Assign output load
 // assign load_out = load_temp;

endmodule
*/
module slave_wrapper (
  input  logic        clk,
  input  logic        reset,
  input  logic        boot_wr_en,
  input  logic [31:0] boot_wr_addr,
  input  logic [7:0]  boot_wr_data,

  input logic HSEL1,HSEL2,

  input  logic [31:0] haddr,
  input  logic [31:0] hwdata,
  input  logic [3:0]  hprot,
  input  logic        hwrite,
  input  logic [2:0]  hsize,
  input  logic        is_signed,
  //input logic [1:0] htrans,

  output logic [31:0] instruction,   // From Instruction_Memory
  output logic [31:0] load_out,
//  output logic [31:0] store_data,
  output logic        hready_inst,
  output logic        hready_data,
  output logic        hresp_inst,
  output logic        hresp_data
);

  // Internal wires
  logic        wr_en_ram;
  logic        rd_en_ram;
  logic        rd_en_rom;
  logic [31:0] wr_data_ram;
  logic [31:0] address_rom;
  logic [31:0] address_ram;
  logic [31:0] read_data;
  logic [31:0] store_out; 

  //--------------------------------------
  // Glue Logic
  //--------------------------------------
  slave_glue slave_glue_logic (
    .haddr(haddr),
    .hwdata(hwdata),
    .hprot(hprot),
    .hwrite(hwrite),
    //.hsize(hsize),
    //.htrans(htrans),
   // .is_signed(is_signed),
    .wr_en_ram(wr_en_ram),
    .rd_en_ram(rd_en_ram),
    .rd_en_rom(rd_en_rom),
    .wr_data_ram(wr_data_ram),
    .address_rom(address_rom),
    .address_ram(address_ram),
    .hready_inst(hready_inst),
    .hready_data(hready_data),
    .hresp_inst(hresp_inst),
    .hresp_data(hresp_data)
  );

  //--------------------------------------
  // Load Unit
  //--------------------------------------
  slave_load load_addressing (
    .hsize(hsize),
    .is_signed(is_signed),
    .read_data(read_data),
    .load_out(load_out)
  );

  //--------------------------------------
  // Store Unit
  //--------------------------------------
  slave_store store_addressing (
    .hsize(hsize),
    .read_data(read_data),
    .wr_data_ram(wr_data_ram),
    .store_out(store_out)
  );

  //--------------------------------------
  // Data Memory Instance
  //--------------------------------------
  Data_Memory data_memory (
    .clk(clk),
    .mem_write(wr_en_ram),
    .mem_read(rd_en_ram),
    .address_ram(address_ram),
    .write_data(store_out),
    .read_data(read_data),
    .HSEL2(HSEL2)
    
  );

  //--------------------------------------
  // Instruction Memory Instance
  //--------------------------------------
  Instruction_Memory instruction_memory (
    .clk(clk),
    .reset(reset),
    .HSEL1(HSEL1), // Always enabled for this wrapper
    .rd_en_rom(rd_en_rom),
    .boot_wr_en(boot_wr_en),
    .boot_wr_addr(boot_wr_addr),
    .boot_wr_data(boot_wr_data),
    .address_rom(address_rom),
    .instruction(instruction)
  );

  // Assign output load
 // assign load_out = load_temp;

endmodule
