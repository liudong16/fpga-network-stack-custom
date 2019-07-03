////------------------------------------------------------------------------------
////  (c) Copyright 2015 Xilinx, Inc. All rights reserved.
////
////  This file contains confidential and proprietary information
////  of Xilinx, Inc. and is protected under U.S. and
////  international copyright and other intellectual property
////  laws.
////
////  DISCLAIMER
////  This disclaimer is not a license and does not grant any
////  rights to the materials distributed herewith. Except as
////  otherwise provided in a valid license issued to you by
////  Xilinx, and to the maximum extent permitted by applicable
////  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
////  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
////  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
////  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
////  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
////  (2) Xilinx shall not be liable (whether in contract or tort,
////  including negligence, or under any other theory of
////  liability) for any loss or damage of any kind or nature
////  related to, arising under or in connection with these
////  materials, including for any direct, or any indirect,
////  special, incidental, or consequential loss or damage
////  (including loss of data, profits, goodwill, or any type of
////  loss or damage suffered as a result of any action brought
////  by a third party) even if such damage or loss was
////  reasonably foreseeable or Xilinx had been advised of the
////  possibility of the same.
////
////  CRITICAL APPLICATIONS
////  Xilinx products are not designed or intended to be fail-
////  safe, or for use in any application requiring fail-safe
////  performance, such as life-support or safety devices or
////  systems, Class III medical devices, nuclear facilities,
////  applications related to the deployment of airbags, or any
////  other applications that could lead to death, personal
////  injury, or severe property or environmental damage
////  (individually and collectively, "Critical
////  Applications"). Customer assumes the sole risk and
////  liability of any use of Xilinx products in Critical
////  Applications, subject only to applicable laws and
////  regulations governing limitations on product liability.
////
////  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
////  PART OF THIS FILE AT ALL TIMES.
////------------------------------------------------------------------------------


`timescale 1fs/1fs

(* DowngradeIPIdentifiedWarnings="yes" *)
module top_design
(
  input  wire gt_rxp_in_0,
  input  wire gt_rxn_in_0,
  output wire gt_txp_out_0,
  output wire gt_txn_out_0,
  input  wire gt_rxp_in_1,
  input  wire gt_rxn_in_1,
  output wire gt_txp_out_1,
  output wire gt_txn_out_1,
  input  wire gt_rxp_in_2,
  input  wire gt_rxn_in_2,
  output wire gt_txp_out_2,
  output wire gt_txn_out_2,
  input  wire gt_rxp_in_3,
  input  wire gt_rxn_in_3,
  output wire gt_txp_out_3,
  output wire gt_txn_out_3,
//modified by liudong16
    //output wire       rx_gt_locked_led,
    //output wire       rx_aligned_led,
    //output wire [4:0] completion_status,

//modified by liudong16
    //input             sys_reset,
    //input             restart_tx_rx,

    input             gt_refclk_p,
    input             gt_refclk_n,
    input             dclk_p,
    input             dclk_n
    //input dclk
);


//modified by liudong16

wire dclk_temp;
wire dclk;
IBUFDS ibufds(
    .O(dclk_temp),
    .I(dclk_p),
    .IB(dclk_n)
    );
    
clk_wiz_1 i_CLK_GEN_1
 (
 //// Clock in ports
  .clk_in1    (dclk_temp), 
  .clk_out1   (dclk),
  .reset      (1'b0),
  .locked     ()
);

//modified by liudong16
//to simulate, please comment the vio module
  
wire sys_reset;
wire restart_tx_rx;
wire runExperiment_V;

vio_0 vio(
    .clk(dclk),
    
    .probe_out0(sys_reset),
    .probe_out1(restart_tx_rx),
    .probe_out2(runExperiment_V)
    );  
        

`ifdef SIM_SPEED_UP
  parameter PKT_NUM         = 20;    //// Many Internal Counters are based on PKT_NUM = 20
`else
  parameter PKT_NUM         = 1000;    //// Many Internal Counters are based on PKT_NUM = 1000
`endif
  wire gt_refclk_out;

  wire gtwiz_reset_tx_datapath_0; 
  wire gtwiz_reset_rx_datapath_0; 
  wire rx_gt_locked_led_0;
  wire rx_aligned_led_0;

  wire rx_core_clk_0;
  wire rx_clk_out_0;
  wire tx_clk_out_0;


//// For other GT loopback options please change the value appropriately
//// For example, for internal loopback gt_loopback_in[2:0] = 3'b010;
//// For more information and settings on loopback, refer GT Transceivers user guide

  wire [11:0] gt_loopback_in_0;

//// RX_0 Signals
  wire rx_reset_0;
  wire user_rx_reset_0;

//// RX_0 User Interface Signals
  wire rx_axis_tvalid_0;
  wire [127:0] rx_axis_tdata_0;
  wire [69:0] rx_axis_tuser_0;

//// RX_0 Control Signals
  wire ctl_rx_test_pattern_0;
  wire ctl_rx_enable_0;
  wire ctl_rx_delete_fcs_0;
  wire ctl_rx_ignore_fcs_0;
  wire [14:0] ctl_rx_max_packet_len_0;
  wire [7:0] ctl_rx_min_packet_len_0;
  wire ctl_rx_check_sfd_0;
  wire ctl_rx_check_preamble_0;
  wire ctl_rx_process_lfi_0;
  wire ctl_rx_force_resync_0;


//// RX_0 Stats Signals
  wire [3:0] stat_rx_block_lock_0;
  wire stat_rx_framing_err_valid_0_0;
  wire stat_rx_framing_err_0_0;
  wire stat_rx_framing_err_valid_1_0;
  wire stat_rx_framing_err_1_0;
  wire stat_rx_framing_err_valid_2_0;
  wire stat_rx_framing_err_2_0;
  wire stat_rx_framing_err_valid_3_0;
  wire stat_rx_framing_err_3_0;
  wire [3:0] stat_rx_vl_demuxed_0;
  wire [1:0] stat_rx_vl_number_0_0;
  wire [1:0] stat_rx_vl_number_1_0;
  wire [1:0] stat_rx_vl_number_2_0;
  wire [1:0] stat_rx_vl_number_3_0;
  wire [3:0] stat_rx_synced_0;
  wire stat_rx_misaligned_0;
  wire stat_rx_aligned_err_0;
  wire [3:0] stat_rx_synced_err_0;
  wire [3:0] stat_rx_mf_len_err_0;
  wire [3:0] stat_rx_mf_repeat_err_0;
  wire [3:0] stat_rx_mf_err_0;
  wire stat_rx_bip_err_0_0;
  wire stat_rx_bip_err_1_0;
  wire stat_rx_bip_err_2_0;
  wire stat_rx_bip_err_3_0;
  wire stat_rx_aligned_0;
  wire stat_rx_hi_ber_0;
  wire stat_rx_status_0;
  wire [1:0] stat_rx_bad_code_0;
  wire [1:0] stat_rx_total_packets_0;
  wire stat_rx_total_good_packets_0;
  wire [5:0] stat_rx_total_bytes_0;
  wire [13:0] stat_rx_total_good_bytes_0;
  wire [1:0] stat_rx_packet_small_0;
  wire stat_rx_jabber_0;
  wire stat_rx_packet_large_0;
  wire stat_rx_oversize_0;
  wire [1:0] stat_rx_undersize_0;
  wire stat_rx_toolong_0;
  wire [1:0] stat_rx_fragment_0;
  wire stat_rx_packet_64_bytes_0;
  wire stat_rx_packet_65_127_bytes_0;
  wire stat_rx_packet_128_255_bytes_0;
  wire stat_rx_packet_256_511_bytes_0;
  wire stat_rx_packet_512_1023_bytes_0;
  wire stat_rx_packet_1024_1518_bytes_0;
  wire stat_rx_packet_1519_1522_bytes_0;
  wire stat_rx_packet_1523_1548_bytes_0;
  wire [1:0] stat_rx_bad_fcs_0;
  wire stat_rx_packet_bad_fcs_0;
  wire [1:0] stat_rx_stomped_fcs_0;
  wire stat_rx_packet_1549_2047_bytes_0;
  wire stat_rx_packet_2048_4095_bytes_0;
  wire stat_rx_packet_4096_8191_bytes_0;
  wire stat_rx_packet_8192_9215_bytes_0;
  wire stat_rx_bad_preamble_0;
  wire stat_rx_bad_sfd_0;
  wire stat_rx_got_signal_os_0;
  wire [1:0] stat_rx_test_pattern_mismatch_0;
  wire stat_rx_truncated_0;
  wire stat_rx_local_fault_0;
  wire stat_rx_remote_fault_0;
  wire stat_rx_internal_local_fault_0;
  wire stat_rx_received_local_fault_0;


//// TX_0 Signals
  wire tx_reset_0;
  wire user_tx_reset_0;

//// TX_0 User Interface Signals
  wire tx_axis_tready_0;
  wire tx_axis_tvalid_0;
  wire [127:0] tx_axis_tdata_0;
  wire [69:0] tx_axis_tuser_0;
  wire tx_unfout_0;

//// TX_0 Control Signals
  wire ctl_tx_test_pattern_0;
  wire ctl_tx_enable_0;
  wire ctl_tx_fcs_ins_enable_0;
  wire [3:0] ctl_tx_ipg_value_0;
  wire ctl_tx_send_lfi_0;
  wire ctl_tx_send_rfi_0;
  wire ctl_tx_send_idle_0;
  wire ctl_tx_custom_preamble_enable_0;
  wire ctl_tx_ignore_fcs_0;


//// TX_0 Stats Signals
  wire stat_tx_total_packets_0;
  wire [4:0] stat_tx_total_bytes_0;
  wire stat_tx_total_good_packets_0;
  wire [13:0] stat_tx_total_good_bytes_0;
  wire stat_tx_packet_64_bytes_0;
  wire stat_tx_packet_65_127_bytes_0;
  wire stat_tx_packet_128_255_bytes_0;
  wire stat_tx_packet_256_511_bytes_0;
  wire stat_tx_packet_512_1023_bytes_0;
  wire stat_tx_packet_1024_1518_bytes_0;
  wire stat_tx_packet_1519_1522_bytes_0;
  wire stat_tx_packet_1523_1548_bytes_0;
  wire stat_tx_packet_small_0;
  wire stat_tx_packet_large_0;
  wire stat_tx_packet_1549_2047_bytes_0;
  wire stat_tx_packet_2048_4095_bytes_0;
  wire stat_tx_packet_4096_8191_bytes_0;
  wire stat_tx_packet_8192_9215_bytes_0;
  wire stat_tx_bad_fcs_0;
  wire stat_tx_frame_error_0;
  wire stat_tx_local_fault_0;







  wire [4:0] completion_status_0;
  wire [3:0] rxrecclkout_0;
  wire [3:0] gtpowergood_out_0;

//modified by liudong16
/*
  wire usr_fsm_clk;
  clk_wiz_0 i_CLK_GEN_0
   (
   //// Clock in ports
    .clk_in1    (dclk), 
    .clk_out1   (usr_fsm_clk),
    .reset      (1'b0),
    .locked     ()
 );
*/

//modified by liudong16
//assign rx_core_clk_0 = tx_clk_out_0;
assign rx_core_clk_0 = rx_clk_out_0;
assign gtwiz_reset_tx_datapath_0 = 1'b0; 
assign gtwiz_reset_rx_datapath_0 = 1'b0; 
assign gt_loopback_in_0 = {4{3'b000}};
assign rx_reset_0 = sys_reset;
assign tx_reset_0 = sys_reset;
//// RX Control Signals tieoff
assign ctl_rx_check_preamble_0 = 1'b1;
assign ctl_rx_check_sfd_0 = 1'b1;
assign ctl_rx_delete_fcs_0 = 1'b1;
assign ctl_rx_enable_0 = 1'b1;
assign ctl_rx_force_resync_0 = 1'b0;
assign ctl_rx_ignore_fcs_0 = 1'b0;
assign ctl_rx_max_packet_len_0 = 15'h2580;
assign ctl_rx_min_packet_len_0 = 8'h40;
assign ctl_rx_process_lfi_0 = 1'b0;
assign ctl_rx_test_pattern_0 = 1'b0;
assign ctl_rx_custom_preamble_enable_0 = 1'b0;

//// TX Control Signals tieoff
assign ctl_tx_enable_0 = 1'b1;
assign ctl_tx_fcs_ins_enable_0 = 1'b1;
assign ctl_tx_ignore_fcs_0 = 1'b0;
assign ctl_tx_send_idle_0 = 1'b0;
assign ctl_tx_send_lfi_0 = 1'b0;
assign ctl_tx_send_rfi_0 = 1'b0;
assign ctl_tx_test_pattern_0 = 1'b0;
assign ctl_tx_ipg_value_0 = 4'hC;
assign ctl_tx_custom_preamble_enable_0 = 1'b0;

l_ethernet_0 DUT
(
    .gt_rxp_in_0 (gt_rxp_in_0),
    .gt_rxn_in_0 (gt_rxn_in_0),
    .gt_txp_out_0 (gt_txp_out_0),
    .gt_txn_out_0 (gt_txn_out_0),
    .gt_rxp_in_1 (gt_rxp_in_1),
    .gt_rxn_in_1 (gt_rxn_in_1),
    .gt_txp_out_1 (gt_txp_out_1),
    .gt_txn_out_1 (gt_txn_out_1),
    .gt_rxp_in_2 (gt_rxp_in_2),
    .gt_rxn_in_2 (gt_rxn_in_2),
    .gt_txp_out_2 (gt_txp_out_2),
    .gt_txn_out_2 (gt_txn_out_2),
    .gt_rxp_in_3 (gt_rxp_in_3),
    .gt_rxn_in_3 (gt_rxn_in_3),
    .gt_txp_out_3 (gt_txp_out_3),
    .gt_txn_out_3 (gt_txn_out_3),

    .tx_clk_out_0 (tx_clk_out_0),
    .rx_core_clk_0 (rx_core_clk_0),
    .rx_clk_out_0 (rx_clk_out_0),
    .rxrecclkout_0 (rxrecclkout_0),

    .gt_loopback_in_0 (gt_loopback_in_0),
    .rx_reset_0 (rx_reset_0),
    .user_rx_reset_0 (user_rx_reset_0),
//// RX User Interface Signals
    .rx_axis_tvalid_0 (rx_axis_tvalid_0),
    .rx_axis_tdata_0 (rx_axis_tdata_0),
    .rx_axis_tuser_0 (rx_axis_tuser_0),



//// RX Control Signals
    .ctl_rx_test_pattern_0 (ctl_rx_test_pattern_0),
    .ctl_rx_enable_0 (ctl_rx_enable_0),
    .ctl_rx_delete_fcs_0 (ctl_rx_delete_fcs_0),
    .ctl_rx_ignore_fcs_0 (ctl_rx_ignore_fcs_0),
    .ctl_rx_max_packet_len_0 (ctl_rx_max_packet_len_0),
    .ctl_rx_min_packet_len_0 (ctl_rx_min_packet_len_0),
    .ctl_rx_custom_preamble_enable_0 (ctl_rx_custom_preamble_enable_0),
    .ctl_rx_check_sfd_0 (ctl_rx_check_sfd_0),
    .ctl_rx_check_preamble_0 (ctl_rx_check_preamble_0),
    .ctl_rx_process_lfi_0 (ctl_rx_process_lfi_0),
    .ctl_rx_force_resync_0 (ctl_rx_force_resync_0),




//// RX Stats Signals
    .stat_rx_block_lock_0 (stat_rx_block_lock_0),
    .stat_rx_framing_err_valid_0_0 (stat_rx_framing_err_valid_0_0),
    .stat_rx_framing_err_0_0 (stat_rx_framing_err_0_0),
    .stat_rx_framing_err_valid_1_0 (stat_rx_framing_err_valid_1_0),
    .stat_rx_framing_err_1_0 (stat_rx_framing_err_1_0),
    .stat_rx_framing_err_valid_2_0 (stat_rx_framing_err_valid_2_0),
    .stat_rx_framing_err_2_0 (stat_rx_framing_err_2_0),
    .stat_rx_framing_err_valid_3_0 (stat_rx_framing_err_valid_3_0),
    .stat_rx_framing_err_3_0 (stat_rx_framing_err_3_0),
    .stat_rx_vl_demuxed_0 (stat_rx_vl_demuxed_0),
    .stat_rx_vl_number_0_0 (stat_rx_vl_number_0_0),
    .stat_rx_vl_number_1_0 (stat_rx_vl_number_1_0),
    .stat_rx_vl_number_2_0 (stat_rx_vl_number_2_0),
    .stat_rx_vl_number_3_0 (stat_rx_vl_number_3_0),
    .stat_rx_synced_0 (stat_rx_synced_0),
    .stat_rx_misaligned_0 (stat_rx_misaligned_0),
    .stat_rx_aligned_err_0 (stat_rx_aligned_err_0),
    .stat_rx_synced_err_0 (stat_rx_synced_err_0),
    .stat_rx_mf_len_err_0 (stat_rx_mf_len_err_0),
    .stat_rx_mf_repeat_err_0 (stat_rx_mf_repeat_err_0),
    .stat_rx_mf_err_0 (stat_rx_mf_err_0),
    .stat_rx_bip_err_0_0 (stat_rx_bip_err_0_0),
    .stat_rx_bip_err_1_0 (stat_rx_bip_err_1_0),
    .stat_rx_bip_err_2_0 (stat_rx_bip_err_2_0),
    .stat_rx_bip_err_3_0 (stat_rx_bip_err_3_0),
    .stat_rx_aligned_0 (stat_rx_aligned_0),
    .stat_rx_hi_ber_0 (stat_rx_hi_ber_0),
    .stat_rx_status_0 (stat_rx_status_0),
    .stat_rx_bad_code_0 (stat_rx_bad_code_0),
    .stat_rx_total_packets_0 (stat_rx_total_packets_0),
    .stat_rx_total_good_packets_0 (stat_rx_total_good_packets_0),
    .stat_rx_total_bytes_0 (stat_rx_total_bytes_0),
    .stat_rx_total_good_bytes_0 (stat_rx_total_good_bytes_0),
    .stat_rx_packet_small_0 (stat_rx_packet_small_0),
    .stat_rx_jabber_0 (stat_rx_jabber_0),
    .stat_rx_packet_large_0 (stat_rx_packet_large_0),
    .stat_rx_oversize_0 (stat_rx_oversize_0),
    .stat_rx_undersize_0 (stat_rx_undersize_0),
    .stat_rx_toolong_0 (stat_rx_toolong_0),
    .stat_rx_fragment_0 (stat_rx_fragment_0),
    .stat_rx_packet_64_bytes_0 (stat_rx_packet_64_bytes_0),
    .stat_rx_packet_65_127_bytes_0 (stat_rx_packet_65_127_bytes_0),
    .stat_rx_packet_128_255_bytes_0 (stat_rx_packet_128_255_bytes_0),
    .stat_rx_packet_256_511_bytes_0 (stat_rx_packet_256_511_bytes_0),
    .stat_rx_packet_512_1023_bytes_0 (stat_rx_packet_512_1023_bytes_0),
    .stat_rx_packet_1024_1518_bytes_0 (stat_rx_packet_1024_1518_bytes_0),
    .stat_rx_packet_1519_1522_bytes_0 (stat_rx_packet_1519_1522_bytes_0),
    .stat_rx_packet_1523_1548_bytes_0 (stat_rx_packet_1523_1548_bytes_0),
    .stat_rx_bad_fcs_0 (stat_rx_bad_fcs_0),
    .stat_rx_packet_bad_fcs_0 (stat_rx_packet_bad_fcs_0),
    .stat_rx_stomped_fcs_0 (stat_rx_stomped_fcs_0),
    .stat_rx_packet_1549_2047_bytes_0 (stat_rx_packet_1549_2047_bytes_0),
    .stat_rx_packet_2048_4095_bytes_0 (stat_rx_packet_2048_4095_bytes_0),
    .stat_rx_packet_4096_8191_bytes_0 (stat_rx_packet_4096_8191_bytes_0),
    .stat_rx_packet_8192_9215_bytes_0 (stat_rx_packet_8192_9215_bytes_0),
    .stat_rx_bad_preamble_0 (stat_rx_bad_preamble_0),
    .stat_rx_bad_sfd_0 (stat_rx_bad_sfd_0),
    .stat_rx_got_signal_os_0 (stat_rx_got_signal_os_0),
    .stat_rx_test_pattern_mismatch_0 (stat_rx_test_pattern_mismatch_0),
    .stat_rx_truncated_0 (stat_rx_truncated_0),
    .stat_rx_local_fault_0 (stat_rx_local_fault_0),
    .stat_rx_remote_fault_0 (stat_rx_remote_fault_0),
    .stat_rx_internal_local_fault_0 (stat_rx_internal_local_fault_0),
    .stat_rx_received_local_fault_0 (stat_rx_received_local_fault_0),



    .tx_reset_0 (tx_reset_0),
    .user_tx_reset_0 (user_tx_reset_0),
//// TX User Interface Signals
    .tx_axis_tready_0 (tx_axis_tready_0),
    .tx_axis_tvalid_0 (tx_axis_tvalid_0),
    .tx_axis_tdata_0 (tx_axis_tdata_0),
    .tx_axis_tuser_0 (tx_axis_tuser_0),
    .tx_unfout_0 (tx_unfout_0),


//// TX Control Signals
    .ctl_tx_test_pattern_0 (ctl_tx_test_pattern_0),
    .ctl_tx_enable_0 (ctl_tx_enable_0),
    .ctl_tx_fcs_ins_enable_0 (ctl_tx_fcs_ins_enable_0),
    .ctl_tx_ipg_value_0 (ctl_tx_ipg_value_0),
    .ctl_tx_send_lfi_0 (ctl_tx_send_lfi_0),
    .ctl_tx_send_rfi_0 (ctl_tx_send_rfi_0),
    .ctl_tx_send_idle_0 (ctl_tx_send_idle_0),
    .ctl_tx_custom_preamble_enable_0 (ctl_tx_custom_preamble_enable_0),
    .ctl_tx_ignore_fcs_0 (ctl_tx_ignore_fcs_0),


//// TX Stats Signals
    .stat_tx_total_packets_0 (stat_tx_total_packets_0),
    .stat_tx_total_bytes_0 (stat_tx_total_bytes_0),
    .stat_tx_total_good_packets_0 (stat_tx_total_good_packets_0),
    .stat_tx_total_good_bytes_0 (stat_tx_total_good_bytes_0),
    .stat_tx_packet_64_bytes_0 (stat_tx_packet_64_bytes_0),
    .stat_tx_packet_65_127_bytes_0 (stat_tx_packet_65_127_bytes_0),
    .stat_tx_packet_128_255_bytes_0 (stat_tx_packet_128_255_bytes_0),
    .stat_tx_packet_256_511_bytes_0 (stat_tx_packet_256_511_bytes_0),
    .stat_tx_packet_512_1023_bytes_0 (stat_tx_packet_512_1023_bytes_0),
    .stat_tx_packet_1024_1518_bytes_0 (stat_tx_packet_1024_1518_bytes_0),
    .stat_tx_packet_1519_1522_bytes_0 (stat_tx_packet_1519_1522_bytes_0),
    .stat_tx_packet_1523_1548_bytes_0 (stat_tx_packet_1523_1548_bytes_0),
    .stat_tx_packet_small_0 (stat_tx_packet_small_0),
    .stat_tx_packet_large_0 (stat_tx_packet_large_0),
    .stat_tx_packet_1549_2047_bytes_0 (stat_tx_packet_1549_2047_bytes_0),
    .stat_tx_packet_2048_4095_bytes_0 (stat_tx_packet_2048_4095_bytes_0),
    .stat_tx_packet_4096_8191_bytes_0 (stat_tx_packet_4096_8191_bytes_0),
    .stat_tx_packet_8192_9215_bytes_0 (stat_tx_packet_8192_9215_bytes_0),
    .stat_tx_bad_fcs_0 (stat_tx_bad_fcs_0),
    .stat_tx_frame_error_0 (stat_tx_frame_error_0),
    .stat_tx_local_fault_0 (stat_tx_local_fault_0),





    .gtwiz_reset_tx_datapath_0 (gtwiz_reset_tx_datapath_0),
    .gtwiz_reset_rx_datapath_0 (gtwiz_reset_rx_datapath_0),
    .gtpowergood_out_0 (gtpowergood_out_0),
    .gt_refclk_p(gt_refclk_p),
    .gt_refclk_n(gt_refclk_n),
    .gt_refclk_out(gt_refclk_out),
    .sys_reset (sys_reset),
    .dclk (dclk)
);

//TODO It is liudong16's logic
exdes_top network_stack_inst(
  .rx_clk(rx_clk_out_0),
  .tx_clk(tx_clk_out_0),
  //input wire clk_n,
  .rst_n(~sys_reset), //low valid
  .runExperiment_V(runExperiment_V),
  //output wire done,
  //output wire locked
  .input_axis_tdata(rx_axis_tdata_0),
  .input_axis_tvalid(rx_axis_tvalid_0),
  .input_axis_tready(),
  .input_axis_sop0(rx_axis_tuser_0[57:57]),
  .input_axis_eop0(rx_axis_tuser_0[58:58]),
  .input_axis_err0(rx_axis_tuser_0[62:62]),
  .input_axis_ena0(rx_axis_tuser_0[56:56]),
  .input_axis_mty0(rx_axis_tuser_0[61:59]),
  .input_axis_sop1(rx_axis_tuser_0[64:64]),
  .input_axis_eop1(rx_axis_tuser_0[65:65]),
  .input_axis_err1(rx_axis_tuser_0[69:69]),
  .input_axis_ena1(rx_axis_tuser_0[63:63]),
  .input_axis_mty1(rx_axis_tuser_0[68:66]),
  .input_preamble(rx_axis_tuser_0[55:0]),

  .output_axis_tdata(tx_axis_tdata_0),
  //output wire [15:0] output_axis_tkeep,
  //output wire output_axis_tlast,
  .output_axis_tvalid(tx_axis_tvalid_0),
  .output_axis_tready(tx_axis_tready_0),
  .output_axis_sop0(tx_axis_tuser_0[57:57]),
  .output_axis_sop1(tx_axis_tuser_0[64:64]),
  .output_axis_eop0(tx_axis_tuser_0[58:58]),
  .output_axis_eop1(tx_axis_tuser_0[65:65]),
  .output_axis_ena0(tx_axis_tuser_0[56:56]),
  .output_axis_ena1(tx_axis_tuser_0[63:63]),
  .output_axis_err0(tx_axis_tuser_0[62:62]),
  .output_axis_err1(tx_axis_tuser_0[69:69]),
  .output_axis_mty0(tx_axis_tuser_0[61:59]),
  .output_axis_mty1(tx_axis_tuser_0[68:66]),
  .output_preamble(tx_axis_tuser_0[55:0])
);

//assign rx_gt_locked_led  = rx_gt_locked_led_0;
//assign rx_aligned_led = rx_aligned_led_0;
//assign completion_status = completion_status_0;


endmodule



