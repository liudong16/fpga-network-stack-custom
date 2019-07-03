open_project mac_ip_encode_prj

set_top mac_ip_encode

add_files mac_ip_encode.cpp
add_files -tb test_mac_ip_encode.cpp

open_solution "solution1"
#modified by liudong16
set_part {xcku115-flvb2104-2-e}
create_clock -period 3.2 -name default

config_rtl -disable_start_propagation
csynth_design
export_design -format ip_catalog -display_name "MAC IP Encoder for 40G TCP Offload Engine" -description "for 128bit axiword the latest version" -vendor "liudong16" -version "2.1"

exit

