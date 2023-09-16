`ifndef KVT_CLK_RST_PKG_SV
`define KVT_CLK_RST_PKG_SV

`include  "kvt_clk_if.sv"
`include  "kvt_rst_if.sv"

package kvt_clk_rst_pkg;
    
    import  uvm_pkg::*;

    `include  "kvt_clk_cfg.sv"
    `include  "kvt_rst_cfg.sv"

endpackage

`endif // KVT_CLK_RST_PKG_SV