module apb_tb_slave;

reg clk;
reg reset_n;

reg transfer;
reg [31:0] addr;
reg [31:0] wdata;
reg write;
reg pready;

wire pselx;
wire penable;
wire [31:0] paddr;
wire [31:0] pwdata;
wire pwrite;

apb_master dut(
    .clk(clk),
    .reset_n(reset_n),
    .transfer(transfer),
    .addr(addr),
    .wdata(wdata),
    .write(write),
    .pready(pready),
    .pselx(pselx),
    .penable(penable),
    .paddr(paddr),
    .pwdata(pwdata),
    .pwrite(pwrite)
);

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, apb_tb_slave);
end

initial begin
    clk = 0;
    transfer = 0;
    addr = 0;
    wdata = 0;
    write = 0;
end

always #5 clk = ~clk;

initial begin

    reset_n = 0;
    write = 1'b1;
    pready = 1'b0;

    #20;
    reset_n = 1'b1;

    @(posedge clk);
    transfer = 1'b1;
    addr = 32'habcd_1234;
    wdata = 32'hface_cafe;
    write = 1'b1;

    @(posedge clk);
    transfer = 1'b0;

    repeat(3)
        @(posedge clk);

    pready = 1'b1;

    @(posedge clk);
    pready = 1'b0;

    #50;
    $finish;

end

endmodule
