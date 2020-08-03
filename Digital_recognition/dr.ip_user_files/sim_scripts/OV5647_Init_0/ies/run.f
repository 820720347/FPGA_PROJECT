-makelib ies_lib/xil_defaultlib -sv \
  "G:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "G:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../dr.srcs/sources_1/ip/OV5647_Init_0/sim/OV5647_Init.v" \
  "../../../../dr.srcs/sources_1/ip/OV5647_Init_0/sim/OV5647_Init_0.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

