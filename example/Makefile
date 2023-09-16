GUI ?= 0
ifneq ($(GUI), 0)
	ENGUI= -gui
endif

seed ?= $(strip $(shell head -1 /dev/urandom | od -N 2 -D -A n | awk '{print $1}') )

##############################
TOOL = xrun
TOOL_OPTS += -l ./logs/$@_${seed}.log
TOOL_OPTS += -sv
TOOL_OPTS += -timescale 1ns/1ps
TOOL_OPTS += -access +rwc
TOOL_OPTS  += -uvmhome CDNS-1.2
############################
# Source List
SOURCE_LIST = -F ../compile.f
SOURCE_LIST +=   ./tb_top.sv
############################

.DEFAULT_GOAL := base_test

.PHONY: base_test
base_test: ## Run UVM base_test
	${TOOL} $(TOOL_OPTS) $(RTL_OPTS) ${ENGUI} -svseed ${seed} ${SOURCE_LIST} +UVM_TESTNAME=kvt_base_test

.PHONY: clean
clean:
	@rm -rf xcelium.d
	@rm -rf ./logs