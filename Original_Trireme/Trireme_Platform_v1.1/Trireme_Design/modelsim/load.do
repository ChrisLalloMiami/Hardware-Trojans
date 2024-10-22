#####################################################
# Create Modelsim library and compile design files. #
#####################################################

# Create a library for working in
vlib work

set rtl ../rtl
set compile_arg +define+INCLUDE_FILE="$rtl/includes/params.h"

# Common source and tests
set common_v_dir  $rtl/common/src
set common_tb_dir $rtl/common/tb

vlog -quiet $compile_arg $common_v_dir/*.v
vlog -quiet $compile_arg $common_tb_dir/*.v

# Core source and tests
set core_base_v_dir     $rtl/cores/base/src
set core_base_tb_dir    $rtl/cores/base/tb
set single_cycle_v_dir  $rtl/cores/single_cycle/src
set single_cycle_tb_dir $rtl/cores/single_cycle/tb

vlog -quiet $compile_arg $core_base_v_dir/*.v
vlog -quiet $compile_arg $core_base_tb_dir/*.v
vlog -quiet $compile_arg $single_cycle_v_dir/*.v
vlog -quiet $compile_arg $single_cycle_tb_dir/*.v


# Memory source and tests
set memory_base_v_dir            $rtl/memory/base/src
set memory_base_tb_dir           $rtl/memory/base/tb
set dual_port_BRAM_memory_v_dir  $rtl/memory/dual_port_BRAM_memory/src
set dual_port_BRAM_memory_tb_dir $rtl/memory/dual_port_BRAM_memory/tb
set main_memory_v_dir            $rtl/memory/main_memory/src
set main_memory_tb_dir           $rtl/memory/main_memory/tb
set single_cycle_memory_v_dir    $rtl/memory/single_cycle_memory/src
set single_cycle_memory_tb_dir   $rtl/memory/single_cycle_memory/tb

vlog -quiet $compile_arg $memory_base_v_dir/*.v
vlog -quiet $compile_arg $memory_base_tb_dir/*.v
vlog -quiet $compile_arg $dual_port_BRAM_memory_v_dir/*.v
vlog -quiet $compile_arg $dual_port_BRAM_memory_tb_dir/*.v
vlog -quiet $compile_arg $main_memory_v_dir/*.v
vlog -quiet $compile_arg $main_memory_tb_dir/*.v
vlog -quiet $compile_arg $single_cycle_memory_v_dir/*.v
vlog -quiet $compile_arg $single_cycle_memory_tb_dir/*.v

# IO source and tests
set io_uart_v_dir  $rtl/io/uart/src
set io_uart_tb_dir $rtl/io/uart/tb
set io_reg_v_dir   $rtl/io/register/src
set io_reg_tb_dir  $rtl/io/register/tb

vlog -quiet $compile_arg $io_uart_v_dir/*.v
vlog -quiet $compile_arg $io_uart_tb_dir/*.v
vlog -quiet $compile_arg $io_reg_v_dir/*.v
vlog -quiet $compile_arg $io_reg_tb_dir/*.v

# Top source and tests
set tops_v_dir  $rtl/tops/src
set tops_tb_dir $rtl/tops/tb

vlog -quiet $compile_arg $tops_v_dir/*.v
vlog -quiet $compile_arg $tops_tb_dir/*.v

quit
