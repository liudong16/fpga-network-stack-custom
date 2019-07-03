open_project ip_handler_prj

set_top ip_handler

add_files ip_handler.cpp
add_files -tb test_ip_handler.cpp

open_solution "solution1"
set_part {xcku115-flvb2104-2-e}
#modified by liudong16
create_clock -period 3.2 -name default

config_rtl -disable_start_propagation
csynth_design
#modified by liudong16
export_design -format ip_catalog -display_name "IP Handler for 40G TCP Offload Engine" -description "for 128bit axis" -vendor "liudong16" -version "2.0"

exit

