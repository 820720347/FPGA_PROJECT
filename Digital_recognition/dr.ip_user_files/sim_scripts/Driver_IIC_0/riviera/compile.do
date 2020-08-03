vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm

vlog -work xil_defaultlib  -sv2k12 \
"G:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"G:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 \
"../../../../dr.srcs/sources_1/ip/Driver_IIC_0/sim/Driver_IIC.v" \
"../../../../dr.srcs/sources_1/ip/Driver_IIC_0/sim/Driver_IIC_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

