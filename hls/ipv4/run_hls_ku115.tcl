
open_project ipv4_prj

set_top ipv4

add_files ../packet.hpp
add_files ipv4.hpp
add_files ipv4.cpp


#add_files -tb test_ipv4.cpp

open_solution "solution1"
#modified by liudong16
set_part {xcku115-flvb2104-2-e}
create_clock -period 3.2 -name default

config_rtl -disable_start_propagation
#appended by liudong16
#to avoid the name conflicts
config_rtl -prefix ipv4_ 

csynth_design
#modified by liudong16
export_design -format ip_catalog -display_name "IPv4 for 40G TCP Offload Engine" -description "128bit the latest version" -vendor "liudong16" -version "2.1"

exit
