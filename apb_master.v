module apb_master(
    input clk,
    input reset_n,
    input transfer,
    input [31:0] addr,
    input [31:0] wdata,
    input write,
    input pready,

    output reg pselx,
    output reg penable,
    output reg [31:0] paddr,
    output reg [31:0] pwdata,
    output reg pwrite
);

// State Encoding
parameter IDLE   = 2'b00;
parameter SETUP  = 2'b01;
parameter ACCESS = 2'b10;

// State Registers
reg [1:0] current_state, next_state;

//--------------------------------------------------
// Present State Logic
//--------------------------------------------------
always @(posedge clk or negedge reset_n)
begin
    if (!reset_n)
        current_state <= IDLE;
    else
        current_state <= next_state;
end

//--------------------------------------------------
// Next State Logic
//--------------------------------------------------
always @(*)
begin
    case (current_state)

        IDLE:
        begin
            if (transfer)
                next_state = SETUP;
            else
                next_state = IDLE;
        end

        SETUP:
        begin
            next_state = ACCESS;
        end

        ACCESS:
        begin
            if (pready)
            begin
                if (transfer)
                    next_state = SETUP;
                else
                    next_state = IDLE;
            end
            else
                next_state = ACCESS;
        end

        default:
            next_state = IDLE;

    endcase
end

//--------------------------------------------------
// Output Logic
//--------------------------------------------------
always @(posedge clk or negedge reset_n)
begin
    if (!reset_n)
    begin
        pselx   <= 1'b0;
        penable <= 1'b0;
        paddr   <= 32'd0;
        pwdata  <= 32'd0;
        pwrite  <= 1'b0;
    end

    else
    begin
        case (next_state)

            IDLE:
            begin
                pselx   <= 1'b0;
                penable <= 1'b0;
            end

            SETUP:
            begin
                pselx   <= 1'b1;
                penable <= 1'b0;
                paddr   <= addr;
                pwdata  <= wdata;
                pwrite  <= write;
            end

            ACCESS:
            begin
                pselx   <= 1'b1;
                penable <= 1'b1;
            end

            default:
            begin
                pselx   <= 1'b0;
                penable <= 1'b0;
            end

        endcase
    end
end

endmodule
