`timescale 1ns / 1ps

module tb_i2c;

  // Inputs
  reg clk;
  reg rst;
  reg newd;
  reg ack;
  reg wr;
  reg [7:0] wdata;
  reg [6:0] addr;

  // Bidirectional
  wire sda;
  wire scl;

  // Outputs
  wire [7:0] rdata;
  wire done;

  // Instantiate the Unit Under Test (UUT)
  eeprom_top uut (
    .clk(clk),
    .rst(rst),
    .newd(newd),
    .ack(ack),
    .wr(wr),
    .scl(scl),
    .sda(sda),
    .wdata(wdata),
    .addr(addr),
    .rdata(rdata),
    .done(done)
  );

  // SDA emulation
  reg sda_slave;
  assign sda = (uut.sda_en == 1'b0) ? sda_slave : 1'bz;

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;  // 100 MHz

  initial begin
    // Initialize Inputs
    rst = 1;
    newd = 0;
    ack = 0;
    wr = 1;             // Write operation
    wdata = 8'hA5;
    addr = 7'h50;       // Example address

    sda_slave = 1'b1;   // Initially high (I2C idle)

    // Reset pulse
    #20;
    rst = 0;

    // Start write transaction
    #20;
    newd = 1;
    #10;
    newd = 0;

    // Simulate ACK for address and data
    #300;
    ack = 1;
    #100;
    ack = 0;

    // Wait for write done
    wait (done == 1);
    #10;

    // Start read transaction
    wr = 0;
    newd = 1;
    #10;
    newd = 0;

    // Simulate ACK for address
    #300;
    ack = 1;
    #100;
    ack = 0;

    // Simulate data bits from slave for read (0x3C)
    sda_slave = 0; #100;
    sda_slave = 0; #100;
    sda_slave = 1; #100;
    sda_slave = 1; #100;
    sda_slave = 1; #100;
    sda_slave = 1; #100;
    sda_slave = 0; #100;
    sda_slave = 0; #100;

    // Wait for read done
    wait (done == 1);
    #10;

    $display("Read Data = %h", rdata);
    $stop;
  end

endmodule
