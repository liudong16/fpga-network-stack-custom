
open_project iperf_udp_client_prj

set_top iperf_udp_client

#add_files ../udp/udpCore/sources/udp.h
add_files iperf_udp_client.hpp
add_files iperf_udp_client.cpp


add_files -tb test_iperf_udp_client.cpp

open_solution "solution1"
#modified by liudong16
set_part {xcku115-flvb2104-2-e}
create_clock -period 3.2 -name default

config_rtl -disable_start_propagation
csynth_design
export_design -format ip_catalog -display_name "iperf udp client for 40G TOE" -description "added tx packet size selection" -vendor "liudong16" -version "2.1"

exit
