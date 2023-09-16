# kvt_clk_rst_vip
Easy clock and reset UVM agent

## The structure of agent

```bash
├── compile.f                - File with incdir;
├── example                  - Example with agent;
└── src                      - Source files;
    ├── kvt_clk_rst_pkg.sv   - Package with interface and *cfg files;
    ├── cfg                  - Configuration file for clk and reset interface;
    └── interfaces           - Clock and reset interface files;
```

## How to run example

* You need Xcelium or Incisive

* 1
```bash
    ~$ git clone https://github.com/kkurenkov/kvt_clk_rst_vip.git 
```
* 2
```bash
    ~$ cd ./kvt_clk_rst_vip/example
```

* 3 If you want to change frequency - kvt_base_test.sv line 67-68. 
```bash
    clk_cfg.sml_freq = 100;     // in MHz
    clk_cfg.big_freq = 500;     // in MHz
```

* 4 Run simulation.
```bash
    ~/kvt_clk_rst_vip/example$ make base_test 
```
* Additional option if you want gui mode - GUI=y
```bash
    ~/kvt_clk_rst_vip/example$ make base_test GUI=y
```

* Results 
```bash
   UVM_INFO @ 0: reporter [RNTST] Running test kvt_base_test...
    UVM_INFO kvt_base_test.sv(71) @ 0: uvm_test_top [EXAMPLE] after randomize clk_cfg.clk_period_ns = 4
    UVM_INFO kvt_base_test.sv(81) @ 0: uvm_test_top [EXAMPLE] start clock in pre_reset_phase -> clk_cfg.vif.start(clk_cfg.clk_period_ns)
    UVM_INFO kvt_base_test.sv(94) @ 0: uvm_test_top [EXAMPLE] start reset in reset_phase -> rst_cfg.vif.init_sync(5*clk_cfg.clk_period_ns);
    UVM_INFO kvt_base_test.sv(107) @ 519000: uvm_test_top [EXAMPLE] stop clock in main_phase -> clk_cfg.vif.stop()
    UVM_INFO kvt_base_test.sv(109) @ 519000: uvm_test_top [EXAMPLE] Delay 500ns
    UVM_INFO kvt_base_test.sv(111) @ 1019000: uvm_test_top [EXAMPLE] start clock in main_phase after delay with the same freq -> clk_cfg.vif.start(clk_cfg.clk_period_ns)
    UVM_INFO kvt_base_test.sv(114) @ 1519000: uvm_test_top [EXAMPLE] The End
    --- UVM Report catcher Summary ---


    Number of demoted UVM_FATAL reports  :    0
    Number of demoted UVM_ERROR reports  :    0
    Number of demoted UVM_WARNING reports:    0
    Number of caught UVM_FATAL reports   :    0
    Number of caught UVM_ERROR reports   :    0
    Number of caught UVM_WARNING reports :    0

    --- UVM Report Summary ---

    ** Report counts by severity
    UVM_INFO :   10
    UVM_WARNING :    0
    UVM_ERROR :    0
    UVM_FATAL :    0
    ** Report counts by id
    [EXAMPLE]     7
    [RNTST]     1
    [UVM/RELNOTES]     1
    [UVM/REPORT/CATCHER]     
```


















```bash
      ****************
    *****************    ***       **********                                             ********
  ******************    *****      **********                                             ********
 ******************    *******     **********      ********** *********      *********    ********
*******       ****    *********    **********      ********** *********      *********    ********
*****        *******************   **********     *********** *********      ********* ***************
****        ********************   **********   ************* *********      ********* ***************
***        ********    *********   ********** *************   *********      ********* ***************
**        ********     *********   **********************     *********     *********     ********    
**       ********      ********    **********************      *********   *********      ********    
***     ********      *********    ***********************      ********* *********       ********    
 ***   ********      *********     *************************     *****************        ********    
  ***               *********      ************  ************     ***************         *********   
    ***          **********        **********      **********      *************          ************
      *******************          **********       *********       ***********           ************
         *************             **********        ********        *********             ***********
```