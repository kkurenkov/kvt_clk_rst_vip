// ----------------------------------------------------------------------------
// Author:   Kalistratov Oleg
// Email:    okalistratov
// FileName: kvt_rst_cfg.sv
// Create date: 30/01/2023
//
// Description: Reset configuration file
//
// ----------------------------------------------------------------------------

`ifndef KVT_RST_CFG_SV
`define KVT_RST_CFG_SV

class kvt_rst_cfg extends uvm_object;
    
    `uvm_object_utils(kvt_rst_cfg)

    virtual kvt_rst_if vif;

    function new(string name = "kvt_rst_cfg");
        super.new(name);
    endfunction : new

    // ----------------------------------------------------------------------------
    // function void set_vif
    // ----------------------------------------------------------------------------

    function void set_vif(virtual kvt_rst_if _vif);
        vif_ref_is_not_null: assert(_vif != null)
        else
            `uvm_fatal(get_full_name(), $sformatf("arg ref passed to %s via 'set_vif' is null", get_full_name()))
        vif = _vif;
    endfunction

endclass : kvt_rst_cfg

`endif // KVT_RST_CFG_SV