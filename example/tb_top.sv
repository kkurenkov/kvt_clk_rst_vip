// ----------------------------------------------------------------------------
// Author:      Konstantin Kurenkov
// Email:       kkurenkov
// FileName:    tb_top.sv
// Create date: 2023-09-16
// Company:     KVT Verification Team
// ----------------------------------------------------------------------------

`ifndef INC_TB_TOP
  `define INC_TB_TOP
  
    `include "uvm_macros.svh"
    `include "kvt_clk_rst_pkg.sv"
    
    import uvm_pkg::*;
    import kvt_clk_rst_pkg::*;

    `include "kvt_base_test.sv"
  
  module tb_top();

    // -------------------- //
    //  Clock and the reset interface.
    // -------------------- //
    kvt_clk_if clk_if ();
    kvt_rst_if rst_if(clk_if.clk);

    // -----------------------------------------------------------------------------
    /** UVM test phase initiator */
    // -----------------------------------------------------------------------------
    initial begin
        uvm_config_db#(virtual kvt_clk_if)::set(uvm_root::get(), "uvm_test_top", "clk_vif", clk_if);
        uvm_config_db#(virtual kvt_rst_if)::set(uvm_root::get(), "uvm_test_top", "rst_vif", rst_if);
        
        /** Start the UVM tests */
        run_test();
    end

  endmodule : tb_top
  
`endif // INC_TB_TOP