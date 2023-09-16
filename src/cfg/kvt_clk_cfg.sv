// ----------------------------------------------------------------------------
// Author:   Kalistratov Oleg
// Email:    okalistratov
// FileName: kvt_clk_cfg.sv
// Create date: 30/01/2023
//
// Description: Clock configuration file
//
// ----------------------------------------------------------------------------

`ifndef KVT_CLK_CFG_SV
`define KVT_CLK_CFG_SV

class kvt_clk_cfg extends uvm_object;

    virtual kvt_clk_if      vif;

    /* PUBLIC ITEMS */
    real                    clk_period_ns;
    rand bit                enable_freq_drift;
    rand bit                enable_equal_clock;
    int                     sml_freq = 100;     // in MHz
    int                     big_freq = 300;     // in MHz

    /* PRIVATE ITEMS */
    protected      real     clk_freq_mhz;
    protected rand int      clk_freq_int;
    protected rand int      clk_freq_drift;

    constraint basic_range_c {
        clk_freq_int inside {[sml_freq:big_freq]};
    }

    constraint drift_range_c {
        if(enable_freq_drift) {
            clk_freq_drift inside {-1,1};
        } else {
            clk_freq_drift == 0;
        }
    }

    constraint equal_clock_c {
        if (enable_equal_clock) {
            soft clk_freq_drift == clk_freq_drift;
        }
    }

    constraint equal_clock_control_c {
        soft enable_equal_clock == 0;
    }

    constraint freq_drift_control_c {
        soft enable_freq_drift == 1;
    }

    function void post_randomize();
        clk_freq_mhz = real'(clk_freq_int) + (real'(clk_freq_int) * real'(clk_freq_drift))/100.0;
        clk_period_ns = 1000.0/clk_freq_mhz;
    endfunction : post_randomize

    function new(string name = "kvt_clk_cfg");
        super.new(name);
    endfunction : new

    `uvm_object_utils(kvt_clk_cfg)

    // ----------------------------------------------------------------------------
    // function void set_vif
    // ----------------------------------------------------------------------------

    function void set_vif(virtual kvt_clk_if _vif);
        vif_ref_is_not_null: assert(_vif != null)
        else
            `uvm_fatal(get_full_name(), $sformatf("arg ref passed to %s via 'set_vif' is null", get_full_name()))
        vif = _vif;
    endfunction

endclass : kvt_clk_cfg

`endif // kvt_clk_cfg_SV