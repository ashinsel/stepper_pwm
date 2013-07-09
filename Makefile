# Project name
PROJECT=stepper_controller

# VHDL files
FILES= src/config.vhdl src/stepper_pwm.vhdl 

# Testbench files
SIMTOP = stepper_pwm_test
SIMFILES= testbench/stepper_pwm_test.vhdtst

# Simulation break condition
GHDL_SIM_TIME = 2500ns
GHDL_SIM_OPT = --assert-level=error --stop-time=$(GHDL_SIM_TIME)

SIMDIR = sim

GHDL_CMD	= ghdl
GHDL_FLAGS	= --ieee=synopsys --warn-no-vital-generic

VIEW_CMD	= /usr/bin/gtkwave

compile:
	mkdir -p $(SIMDIR)
	$(GHDL_CMD) -a -Wa,--32 $(GHDL_FLAGS) --workdir=$(SIMDIR) --work=work $(SIMFILES) $(FILES)
	$(GHDL_CMD) -m -Wa,--32 -Wl,-m32 $(GHDL_FLAGS) --workdir=$(SIMDIR) --work=work $(SIMTOP)
	@mv $(SIMTOP) $(SIMDIR)/$(SIMTOP)
 
sim: compile
	@$(SIMDIR)/$(SIMTOP) $(GHDL_SIM_OPT) --vcdgz=$(SIMDIR)/$(SIMTOP).vcdgz

view: sim
	gunzip --stdout $(SIMDIR)/$(SIMTOP).vcdgz | $(VIEW_CMD) --vcd
	
clean:
	$(GHDL_CMD) --clean --workdir=$(SIMDIR)
	
	