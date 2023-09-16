`ifndef KVT_CLK_IF_SV
`define KVT_CLK_IF_SV

interface kvt_clk_if ();

    bit       started     = 0;
    realtime  half_period = 0ns;
    bit       clk         = 0;

    always @(posedge started) begin
        while (started) begin
            clk ^= 1;
            #(half_period);
        end
    end

    function automatic void start(realtime period_ns);
        set_period(period_ns);
        started = 1;
    endfunction

    function automatic void set_period(realtime period_ns);
        half_period = period_ns / 2.0;
    endfunction

    function automatic void stop();
        half_period = 0ns;
        started     = 0;
    endfunction
    
endinterface

`endif // KVT_CLK_IF_SV