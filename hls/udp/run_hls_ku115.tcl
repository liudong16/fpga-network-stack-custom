
open_project udp_prj

set_top udp

add_files ../packet.hpp
add_files udp.hpp
add_files udp.cpp


#add_files -tb test_udp.cpp

open_solution "solution1"
# modified by liudong16
set_part {xcku115-flvb2104-2-e}
create_clock -period 3.2 -name default

config_rtl -disable_start_propagation
config_rtl -prefix udp_
csynth_design
export_design -format ip_catalog -display_name "UDP for 40G TCP Offload Engine" -description "delete the HEADER state of generate_udp module" -vendor "liudong16" -version "2.2"

exit
