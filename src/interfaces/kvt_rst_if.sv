`ifndef KVT_RST_IF_SV
`define KVT_RST_IF_SV

interface kvt_rst_if (input clk);

    bit reset = 0;
    bit reset_n;

    assign reset_n = ~reset;

    task automatic init_sync(realtime duration_ns);
        reset = 1;
        #(duration_ns);
        @(posedge clk)
        reset = 0;
    endtask

    task automatic init_async(realtime duration_ns);
        reset = 1;
        #(duration_ns);
        reset = 0;
    endtask

endinterface

`endif // KVT_RST_IF_SV