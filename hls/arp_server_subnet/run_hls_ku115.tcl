open_project arp_server_subnet_prj

set_top arp_server_subnet

add_files arp_server_subnet.cpp
add_files -tb test_arp_server_subnet.cpp

open_solution "solution1"
set_part {xcku115-flvb2104-2-e}
create_clock -period 5.0 -name default

config_rtl -disable_start_propagation
csynth_design
export_design -format ip_catalog -display_name "ARP Subnet Server for 40G TOE Design" -description "Replies to ARP queries and resolves IP addresses." -vendor "liudong16" -version "1.0"
exit
