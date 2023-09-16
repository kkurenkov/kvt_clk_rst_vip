// ----------------------------------------------------------------------------
// Author:      Konstantin Kurenkov
// Email:       kkurenkov
// FileName:    kvt_base_test.sv
// Create date: 2023-09-16
// Company:     KVT Verification Team
// ----------------------------------------------------------------------------

`ifndef INC_KVT_BASE_TEST
    `define INC_KVT_BASE_TEST
    
  class kvt_base_test extends uvm_test;
    `uvm_component_utils(kvt_base_test)

    // Virtual interface
    virtual kvt_clk_if clk_vif;
    virtual kvt_rst_if rst_vif;

    // Configuration
    kvt_clk_cfg clk_cfg;
    kvt_rst_cfg rst_cfg;

    // ----------------------------------------------------------------------------
    // Constructor
    // ----------------------------------------------------------------------------
    extern         function      new                     (string name = "kvt_base_test",
                                                    uvm_component parent=null);
    // ----------------------------------------------------------------------------
    // Primary UVM functions/tasks
    // ----------------------------------------------------------------------------
    extern virtual function void build_phase               (uvm_phase phase);
    extern virtual function void start_of_simulation_phase (uvm_phase phase);
    extern virtual task          pre_reset_phase           (uvm_phase phase);
    extern virtual task          reset_phase               (uvm_phase phase);
    extern virtual task          main_phase                (uvm_phase phase);
  endclass : kvt_base_test

  // ----------------------------------------------------------------------------
  // Constructor
  // ----------------------------------------------------------------------------
  function kvt_base_test::new(string name = "kvt_base_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction : new

  // ----------------------------------------------------------------------------
  // function build_phase
  // ----------------------------------------------------------------------------
  function void kvt_base_test::build_phase(uvm_phase phase);
    super.build_phase(phase);

    clk_cfg = kvt_clk_cfg::type_id::create("clk_cfg");
    void'(uvm_config_db#(virtual kvt_clk_if)::get(this, "", "clk_vif", clk_vif));
    clk_cfg.set_vif(clk_vif);

    rst_cfg = kvt_rst_cfg::type_id::create("rst_cfg");
    void'(uvm_config_db#(virtual kvt_rst_if)::get(this, "", "rst_vif", rst_vif));
    rst_cfg.set_vif(rst_vif);
    
  endfunction : build_phase

  // ----------------------------------------------------------------------------
  // function start_of_simulation_phase
  // ----------------------------------------------------------------------------
  function void kvt_base_test::start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    // Generate configurations set
    clk_cfg.sml_freq = 100;     // in MHz
    clk_cfg.big_freq = 500;     // in MHz
    assert(clk_cfg.randomize());

    `uvm_info("EXAMPLE", $sformatf("after randomize clk_cfg.clk_period_ns = %0h", clk_cfg.clk_period_ns), UVM_LOW);    
  endfunction : start_of_simulation_phase
      
  // ----------------------------------------------------------------------------
  // task pre_reset_phase
  // ----------------------------------------------------------------------------
  task kvt_base_test::pre_reset_phase(uvm_phase phase);
    super.pre_reset_phase(phase);
    // Setup clocks
    phase.raise_objection(this, "Starting sequences");
      `uvm_info("EXAMPLE", $sformatf("start clock in pre_reset_phase -> clk_cfg.vif.start(clk_cfg.clk_period_ns)"), UVM_LOW);
      clk_cfg.vif.start(clk_cfg.clk_period_ns); 
    phase.drop_objection(this, "Ending sequences");

  endtask : pre_reset_phase

  // ----------------------------------------------------------------------------
  // task reset_phase
  // ----------------------------------------------------------------------------
  task kvt_base_test::reset_phase(uvm_phase phase);
    super.reset_phase(phase);
    // Run resets
    phase.raise_objection(this, "Starting sequences");
      `uvm_info("EXAMPLE", $sformatf("start reset in reset_phase -> rst_cfg.vif.init_sync(5*clk_cfg.clk_period_ns);"), UVM_LOW);
      rst_cfg.vif.init_sync(5*clk_cfg.clk_period_ns);
    phase.drop_objection(this, "Ending sequences");

  endtask : reset_phase

  // ----------------------------------------------------------------------------
  // task main_phase
  // ----------------------------------------------------------------------------
  task kvt_base_test::main_phase(uvm_phase phase);
    super.main_phase(phase);
    phase.raise_objection(this, "Starting sequences");
      #500;
      `uvm_info("EXAMPLE", $sformatf("stop clock in main_phase -> clk_cfg.vif.stop()"), UVM_LOW);
       clk_cfg.vif.stop();
      `uvm_info("EXAMPLE", $sformatf("Delay 500ns"), UVM_LOW);
       #500;
      `uvm_info("EXAMPLE", $sformatf("start clock in main_phase after delay with the same freq -> clk_cfg.vif.start(clk_cfg.clk_period_ns)"), UVM_LOW);
       clk_cfg.vif.start(clk_cfg.clk_period_ns);
       #500;
      `uvm_info("EXAMPLE", $sformatf("The End"), UVM_LOW);

    phase.drop_objection(this, "Ending sequences");

  endtask : main_phase

`endif // INC_KVT_BASE_TEST