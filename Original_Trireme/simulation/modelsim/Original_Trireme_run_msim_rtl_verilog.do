transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/tops/src {C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/tops/src/single_cycle_top.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/memory/single_cycle_memory/src {C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/memory/single_cycle_memory/src/single_cycle_memory_subsystem.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/memory/base/src {C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/memory/base/src/memory_interface.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/memory/base/src {C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/memory/base/src/BSRAM_byte_en.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/memory/base/src {C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/memory/base/src/BSRAM.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/single_cycle/src {C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/single_cycle/src/single_cycle_core.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/single_cycle/src {C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/single_cycle/src/single_cycle_control_unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/base/src {C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/base/src/writeback_unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/base/src {C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/base/src/regFile.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/base/src {C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/base/src/memory_receive.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/base/src {C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/base/src/memory_issue.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/base/src {C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/base/src/hazard_detection_unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/base/src {C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/base/src/fetch_receive.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/base/src {C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/base/src/fetch_issue.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/base/src {C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/base/src/execution_unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/base/src {C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/base/src/decode_unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/base/src {C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/base/src/control_unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/base/src {C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/cores/base/src/ALU.v}

vlog -vlog01compat -work work +incdir+C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/tops/tb {C:/Users/Chris/Desktop/Projects/Senior_Design/Original_Trireme/Trireme_Platform_v1.1/Trireme_Design/rtl/tops/tb/tb_single_cycle_top_primes.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  tb_single_cycle_top_primes

add wave *
view structure
view signals
run -all
