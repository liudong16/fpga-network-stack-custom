//  (c) Copyright  2013 - 2018 Xilinx, Inc. All rights reserved.
//
//  This file contains confidential and proprietary information
//  of Xilinx, Inc. and is protected under U.S. and
//  international copyright and other intellectual property
//  laws.
//
//  DISCLAIMER
//  This disclaimer is not a license and does not grant any
//  rights to the materials distributed herewith. Except as
//  otherwise provided in a valid license issued to you by
//  Xilinx, and to the maximum extent permitted by applicable
//  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
//  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
//  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
//  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
//  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
//  (2) Xilinx shall not be liable (whether in contract or tort,
//  including negligence, or under any other theory of
//  liability) for any loss or damage of any kind or nature
//  related to, arising under or in connection with these
//  materials, including for any direct, or any indirect,
//  special, incidental, or consequential loss or damage
//  (including loss of data, profits, goodwill, or any type of
//  loss or damage suffered as a result of any action brought
//  by a third party) even if such damage or loss was
//  reasonably foreseeable or Xilinx had been advised of the
//  possibility of the same.
//
//  CRITICAL APPLICATIONS
//  Xilinx products are not designed or intended to be fail-
//  safe, or for use in any application requiring fail-safe
//  performance, such as life-support or safety devices or
//  systems, Class III medical devices, nuclear facilities,
//  applications related to the deployment of airbags, or any
//  other applications that could lead to death, personal
//  injury, or severe property or environmental damage
//  (individually and collectively, "Critical
//  Applications"). Customer assumes the sole risk and
//  liability of any use of Xilinx products in Critical
//  Applications, subject only to applicable laws and
//  regulations governing limitations on product liability.
//
//  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
//  PART OF THIS FILE AT ALL TIMES.
//-----------------------------------------------------------------------------
//Author: liudong16
//Data: 08/11/2018

`default_nettype none
`timescale 1ps/1ps

module exdes_top (
  input wire rx_clk,
  input wire tx_clk,
  input wire rst_n,
  //output wire done,
  //output wire locked
  input wire [127:0] input_axis_tdata,
  input wire input_axis_tvalid,
  output wire input_axis_tready,
  input wire input_axis_sop0,
  input wire input_axis_eop0,
  input wire input_axis_err0,
  input wire input_axis_ena0,
  input wire [2:0] input_axis_mty0,
  input wire input_axis_sop1,
  input wire input_axis_eop1,
  input wire input_axis_err1,
  input wire input_axis_ena1,
  input wire [2:0] input_axis_mty1,
  input wire [55:0] input_preamble,

  output reg [127:0] output_axis_tdata,
  //output wire [15:0] output_axis_tkeep,
  //output wire output_axis_tlast,
  output reg output_axis_tvalid,
  input wire output_axis_tready,
  output reg output_axis_sop0,
  output reg output_axis_sop1,
  output reg output_axis_eop0,
  output reg output_axis_eop1,
  output reg output_axis_ena0,
  output reg output_axis_ena1,
  output reg output_axis_err0,
  output reg output_axis_err1,
  output reg [2:0] output_axis_mty0,
  output reg [2:0] output_axis_mty1,
  output wire [55:0] output_preamble,
  output wire output_unfout,
  
  input wire runExperiment_V
);

wire [15:0] input_axis_tkeep;
wire input_axis_tlast;

assign input_axis_tlast = input_axis_eop0 || input_axis_eop1;
assign input_axis_tkeep[7:0] = 8'b11111111 >> input_axis_mty0;
assign input_axis_tkeep[15:8] = 8'b11111111 >> input_axis_mty1;


// ip handler module
wire [31:0] myIpAddress;
assign myIpAddress = 32'h0200000a;
wire iph_to_udp_axis_tvalid;
wire iph_to_udp_axis_tready;
wire [127:0] iph_to_udp_axis_tdata;
wire [15:0] iph_to_udp_axis_tkeep;
wire iph_to_udp_axis_tlast;
//assign iph_to_udp_axis_tready = 1'b1;
wire iph_to_arp_axis_tready;
wire iph_to_icmp_axis_tready;
wire iph_to_tcp_axis_tready;
assign iph_to_arp_axis_tready = 1'b1;
assign iph_to_icmp_axis_tready = 1'b1;
assign iph_to_tcp_axis_tready = 1'b1;

ip_handler_0 ip_handler_inst(
  .m_axis_ARP_TVALID(),
  .m_axis_ARP_TREADY(iph_to_arp_axis_tready),
  .m_axis_ARP_TDATA(),
  .m_axis_ARP_TKEEP(),
  .m_axis_ARP_TLAST(),
  .m_axis_ICMP_TVALID(),
  .m_axis_ICMP_TREADY(iph_to_icmp_axis_tready),
  .m_axis_ICMP_TDATA(),
  .m_axis_ICMP_TKEEP(),
  .m_axis_ICMP_TLAST(),
  .m_axis_TCP_TVALID(),
  .m_axis_TCP_TREADY(iph_to_tcp_axis_tready),
  .m_axis_TCP_TDATA(),
  .m_axis_TCP_TKEEP(),
  .m_axis_TCP_TLAST(),
  .m_axis_UDP_TVALID(iph_to_udp_axis_tvalid),
  .m_axis_UDP_TREADY(iph_to_udp_axis_tready),
  .m_axis_UDP_TDATA(iph_to_udp_axis_tdata),
  .m_axis_UDP_TKEEP(iph_to_udp_axis_tkeep),
  .m_axis_UDP_TLAST(iph_to_udp_axis_tlast),
  .s_axis_raw_TVALID(input_axis_tvalid),
  .s_axis_raw_TREADY(input_axis_tready),
  .s_axis_raw_TDATA(input_axis_tdata),
  .s_axis_raw_TKEEP(input_axis_tkeep),
  .s_axis_raw_TLAST(input_axis_tlast),
  .aclk(rx_clk),
  .aresetn(rst_n)
);

//ipv4 module
wire [31:0] ipv4_address;
assign ipv4_address = 32'h0200000a;
wire ip_to_udp_axis_data_tvalid;
wire ip_to_udp_axis_data_tready;
wire [127:0] ip_to_udp_axis_data_tdata;
wire [15:0] ip_to_udp_axis_data_tkeep;
wire ip_to_udp_axis_data_tlast;
wire [47:0] ip_to_udp_axis_meta_tdata;
wire ip_to_udp_axis_meta_tvalid;
wire ip_to_udp_axis_meta_tready;

wire udp_to_ip_axis_data_tvalid;
wire udp_to_ip_axis_data_tready;
wire [127:0] udp_to_ip_axis_data_tdata;
wire [15:0] udp_to_ip_axis_data_tkeep;
wire udp_to_ip_axis_data_tlast;
wire [47:0] udp_to_ip_axis_meta_tdata;
wire udp_to_ip_axis_meta_tvalid;
wire udp_to_ip_axis_meta_tready;

wire [127:0] udp_to_mie_axis_tdata;
wire [15:0] udp_to_mie_axis_tkeep;
wire udp_to_mie_axis_tlast;
wire udp_to_mie_axis_tvalid;
wire udp_to_mie_axis_tready;
//assign udp_to_mie_axis_tready = 1'b1;

ipv4_ipv4_0 ipv4_inst(
  .local_ipv4_address_V(ipv4_address),
  //RX
  .s_axis_rx_data_TVALID(iph_to_udp_axis_tvalid),
  .s_axis_rx_data_TREADY(iph_to_udp_axis_tready),
  .s_axis_rx_data_TDATA(iph_to_udp_axis_tdata),
  .s_axis_rx_data_TKEEP(iph_to_udp_axis_tkeep),
  .s_axis_rx_data_TLAST(iph_to_udp_axis_tlast),
  .m_axis_rx_meta_TVALID(ip_to_udp_axis_meta_tvalid),
  .m_axis_rx_meta_TREADY(ip_to_udp_axis_meta_tready),
  .m_axis_rx_meta_TDATA(ip_to_udp_axis_meta_tdata),
  .m_axis_rx_data_TVALID(ip_to_udp_axis_data_tvalid),
  .m_axis_rx_data_TREADY(ip_to_udp_axis_data_tready),
  .m_axis_rx_data_TDATA(ip_to_udp_axis_data_tdata),
  .m_axis_rx_data_TKEEP(ip_to_udp_axis_data_tkeep),
  .m_axis_rx_data_TLAST(ip_to_udp_axis_data_tlast),
  
  //TX
  .m_axis_tx_data_TVALID(udp_to_mie_axis_tvalid),
  .m_axis_tx_data_TREADY(udp_to_mie_axis_tready),
  .m_axis_tx_data_TDATA(udp_to_mie_axis_tdata),
  .m_axis_tx_data_TKEEP(udp_to_mie_axis_tkeep),
  .m_axis_tx_data_TLAST(udp_to_mie_axis_tlast),
  .s_axis_tx_data_TVALID(udp_to_ip_axis_data_tvalid),
  .s_axis_tx_data_TREADY(udp_to_ip_axis_data_tready),
  .s_axis_tx_data_TDATA(udp_to_ip_axis_data_tdata),
  .s_axis_tx_data_TKEEP(udp_to_ip_axis_data_tkeep),
  .s_axis_tx_data_TLAST(udp_to_ip_axis_data_tlast),
  .s_axis_tx_meta_TVALID(udp_to_ip_axis_meta_tvalid),
  .s_axis_tx_meta_TREADY(udp_to_ip_axis_meta_tready),
  .s_axis_tx_meta_TDATA(udp_to_ip_axis_meta_tdata),
  
  .aclk(rx_clk),
  .aresetn(rst_n)
);

//UDP
wire [15:0] listen_port;
assign listen_port = 16'h013f;//319 in decimal
wire [79:0] udp_to_app_axis_meta_tdata;
wire udp_to_app_axis_meta_tvalid;
wire udp_to_app_axis_meta_tready;
//assign udp_to_app_axis_meta_tready = 1'b1;
wire [127:0] udp_to_app_axis_data_tdata;
wire [15:0] udp_to_app_axis_data_tkeep;
wire udp_to_app_axis_data_tlast;
wire udp_to_app_axis_data_tvalid;
wire udp_to_app_axis_data_tready;
//assign udp_to_app_axis_data_tready = 1'b1;

wire [79:0] app_to_udp_axis_meta_tdata;
wire app_to_udp_axis_meta_tvalid;
wire app_to_udp_axis_meta_tready;
wire [127:0] app_to_udp_axis_data_tdata;
wire [15:0] app_to_udp_axis_data_tkeep;
wire app_to_udp_axis_data_tlast;
wire app_to_udp_axis_data_tvalid;
wire app_to_udp_axis_data_tready;
/* 20190305
assign app_to_udp_axis_meta_tdata = udp_to_app_axis_meta_tdata;
assign app_to_udp_axis_meta_tvalid = udp_to_app_axis_meta_tvalid;
//assign app_to_udp_axis_meta_tready = 1'b1;
assign app_to_udp_axis_data_tdata = ~udp_to_app_axis_data_tdata;
assign app_to_udp_axis_data_tkeep = udp_to_app_axis_data_tkeep;
assign app_to_udp_axis_data_tlast = udp_to_app_axis_data_tlast;
assign app_to_udp_axis_data_tvalid = udp_to_app_axis_data_tvalid;
//assign app_to_udp_axis_data_tready = 1'b1;
*/

//iperf udp client inst 20190305
wire [31:0] regTargetIpAddress_V;
wire [7:0] regPacketGap_V;
assign regTargetIpAddress_V = 32'h0100000a;
assign regPacketGap_V = 0;

iperf_udp_client_0 iperf_udp_client_inst (
  .runExperiment_V(runExperiment_V),
  .regTargetIpAddress_V(regTargetIpAddress_V),
  .regPacketGap_V(regPacketGap_V),
  .m_axis_tx_data_TVALID(app_to_udp_axis_data_tvalid),
  .m_axis_tx_data_TREADY(app_to_udp_axis_data_tready),
  .m_axis_tx_data_TDATA(app_to_udp_axis_data_tdata),
  .m_axis_tx_data_TKEEP(app_to_udp_axis_data_tkeep),
  .m_axis_tx_data_TLAST(app_to_udp_axis_data_tlast),
  .m_axis_tx_metadata_TVALID(app_to_udp_axis_meta_tvalid),
  .m_axis_tx_metadata_TREADY(app_to_udp_axis_meta_tready),
  .m_axis_tx_metadata_TDATA(app_to_udp_axis_meta_tdata),
  .s_axis_rx_data_TVALID(udp_to_app_axis_data_tvalid),
  .s_axis_rx_data_TREADY(udp_to_app_axis_data_tready),
  .s_axis_rx_data_TDATA(udp_to_app_axis_data_tdata),
  .s_axis_rx_data_TKEEP(udp_to_app_axis_data_tkeep),
  .s_axis_rx_data_TLAST(udp_to_app_axis_data_tlast),
  .s_axis_rx_metadata_TVALID(udp_to_app_axis_meta_tvalid),
  .s_axis_rx_metadata_TREADY(udp_to_app_axis_meta_tready),
  .s_axis_rx_metadata_TDATA(udp_to_app_axis_meta_tdata),
  .aclk(rx_clk),
  .aresetn(rst_n)
);

udp_udp_0 udp_inst(
  .reg_listen_port_V(listen_port),
  //RX
  .m_axis_rx_data_TVALID(udp_to_app_axis_data_tvalid),
  .m_axis_rx_data_TREADY(udp_to_app_axis_data_tready),
  .m_axis_rx_data_TDATA(udp_to_app_axis_data_tdata),
  .m_axis_rx_data_TKEEP(udp_to_app_axis_data_tkeep),
  .m_axis_rx_data_TLAST(udp_to_app_axis_data_tlast),
  .m_axis_rx_meta_TVALID(udp_to_app_axis_meta_tvalid),
  .m_axis_rx_meta_TREADY(udp_to_app_axis_meta_tready),
  .m_axis_rx_meta_TDATA(udp_to_app_axis_meta_tdata),
  .s_axis_rx_data_TVALID(ip_to_udp_axis_data_tvalid),
  .s_axis_rx_data_TREADY(ip_to_udp_axis_data_tready),
  .s_axis_rx_data_TDATA(ip_to_udp_axis_data_tdata),
  .s_axis_rx_data_TKEEP(ip_to_udp_axis_data_tkeep),
  .s_axis_rx_data_TLAST(ip_to_udp_axis_data_tlast),
  .s_axis_rx_meta_TVALID(ip_to_udp_axis_meta_tvalid),
  .s_axis_rx_meta_TREADY(ip_to_udp_axis_meta_tready),
  .s_axis_rx_meta_TDATA(ip_to_udp_axis_meta_tdata),
  
  //TX
  .m_axis_tx_data_TVALID(udp_to_ip_axis_data_tvalid),
  .m_axis_tx_data_TREADY(udp_to_ip_axis_data_tready),
  .m_axis_tx_data_TDATA(udp_to_ip_axis_data_tdata),
  .m_axis_tx_data_TKEEP(udp_to_ip_axis_data_tkeep),
  .m_axis_tx_data_TLAST(udp_to_ip_axis_data_tlast),
  .m_axis_tx_meta_TVALID(udp_to_ip_axis_meta_tvalid),
  .m_axis_tx_meta_TREADY(udp_to_ip_axis_meta_tready),
  .m_axis_tx_meta_TDATA(udp_to_ip_axis_meta_tdata),
  .s_axis_tx_data_TVALID(app_to_udp_axis_data_tvalid),
  .s_axis_tx_data_TREADY(app_to_udp_axis_data_tready),
  .s_axis_tx_data_TDATA(app_to_udp_axis_data_tdata),
  .s_axis_tx_data_TKEEP(app_to_udp_axis_data_tkeep),
  .s_axis_tx_data_TLAST(app_to_udp_axis_data_tlast),
  .s_axis_tx_meta_TVALID(app_to_udp_axis_meta_tvalid),
  .s_axis_tx_meta_TREADY(app_to_udp_axis_meta_tready),
  .s_axis_tx_meta_TDATA(app_to_udp_axis_meta_tdata),
  
  .aclk(rx_clk),
  .aresetn(rst_n)
);


//MAC-IP encode inst
wire [47:0] myMacAddress;
assign myMacAddress = 48'h0c0b0a090807;
//wire [31:0] regSubNetMask;
//assign regSubNetMask = 32'h00ffffff;
//wire [31:0] regDefaultGateway;
//assign regDefaultGateway = 32'h0100000a;

wire [127:0] mie_to_tx_axis_tdata;
wire [15:0] mie_to_tx_axis_tkeep;
wire mie_to_tx_axis_tlast;
wire mie_to_tx_axis_tvalid;
wire mie_to_tx_axis_tready;
assign mie_to_tx_axis_tready = 1'b1;

//wire arp_lookup_request_tvalid;
//wire arp_lookup_request_tready;
//assign arp_lookup_request_tready = 1'b1;
//wire [31:0] arp_lookup_request_tdata;
wire arp_lookup_reply_tvalid;
assign arp_lookup_reply_tvalid = 1'b1;
wire arp_lookup_reply_tready;
wire [55:0] arp_lookup_reply_tdata;
assign arp_lookup_reply_tdata = 56'h01_060504030201;

mac_ip_encode_0 mac_ip_encode_inst(
  .myMacAddress_V(myMacAddress),
  //.regSubNetMask_V(regSubNetMask),
  //.regDefaultGateway_V(regDefaultGateway),
  //.m_axis_arp_lookup_request_TVALID(arp_lookup_request_tvalid),
  //.m_axis_arp_lookup_request_TREADY(arp_lookup_request_tready), //input
  //.m_axis_arp_lookup_request_TDATA(arp_lookup_request_tdata),
  .m_axis_ip_TVALID(mie_to_tx_axis_tvalid),
  .m_axis_ip_TREADY(mie_to_tx_axis_tready), 
  .m_axis_ip_TDATA(mie_to_tx_axis_tdata),
  .m_axis_ip_TKEEP(mie_to_tx_axis_tkeep),
  .m_axis_ip_TLAST(mie_to_tx_axis_tlast),
  
  .s_axis_arp_lookup_reply_TVALID(arp_lookup_reply_tvalid),
  .s_axis_arp_lookup_reply_TREADY(arp_lookup_reply_tready), //output
  .s_axis_arp_lookup_reply_TDATA(arp_lookup_reply_tdata),
  .s_axis_ip_TVALID(udp_to_mie_axis_tvalid),
  .s_axis_ip_TREADY(udp_to_mie_axis_tready), //output
  .s_axis_ip_TDATA(udp_to_mie_axis_tdata),
  .s_axis_ip_TKEEP(udp_to_mie_axis_tkeep),
  .s_axis_ip_TLAST(udp_to_mie_axis_tlast),
  .aclk(rx_clk),
  .aresetn(rst_n)
);

/*
// output width converter
wire [127:0] tx_axis_tdata;
wire tx_axis_tvalid;
wire [15:0] tx_axis_tkeep;
wire tx_axis_tlast;
wire [31:0] tx_s00_fifo_data_count;
wire [31:0] tx_m00_fifo_data_count;

axis_interconnect_1 output_width_converter(
  .ACLK(tx_clk_200),
  .ARESETN(rst_n),
  .S00_AXIS_ACLK(tx_clk_200),
  .S00_AXIS_ARESETN(rst_n),
  .S00_AXIS_TVALID(mie_to_tx_axis_tvalid),
  .S00_AXIS_TREADY(mie_to_tx_axis_tready),
  .S00_AXIS_TDATA(mie_to_tx_axis_tdata),
  .S00_AXIS_TKEEP(mie_to_tx_axis_tkeep),
  .S00_AXIS_TLAST(mie_to_tx_axis_tlast),
  .M00_AXIS_ACLK(tx_clk),
  .M00_AXIS_ARESETN(rst_n),
  .M00_AXIS_TVALID(tx_axis_tvalid),
  .M00_AXIS_TREADY(output_axis_tready),
  .M00_AXIS_TDATA(tx_axis_tdata),
  .M00_AXIS_TKEEP(tx_axis_tkeep),
  .M00_AXIS_TLAST(tx_axis_tlast),
  .S00_FIFO_DATA_COUNT(tx_s00_fifo_data_count),
  .M00_FIFO_DATA_COUNT(tx_m00_fifo_data_count)
);
*/

//to get the tx_axis_user signal
localparam [47:0] tx_dst_mac = 48'h0c_0b_0a_09_08_07;
localparam [47:0] tx_src_mac = 48'h06_05_04_03_02_01;
localparam [95:0] eth_header = {tx_dst_mac, tx_src_mac}; //cause the stream is put from the lower bit, so eth_header should be put reversely.

always @(posedge tx_clk or negedge rst_n) begin
    if (!rst_n) begin
        output_axis_tdata <= 128'b0;
        output_axis_tvalid <= 0;
        output_axis_sop0 <= 0;
        output_axis_sop1 <= 0;
        output_axis_eop0 <= 0;
        output_axis_eop1 <= 0;
        output_axis_ena0 <= 0;
        output_axis_ena1 <= 0;
        output_axis_err0 <= 0;
        output_axis_err1 <= 0;
        output_axis_mty0 <= 3'b0;
        output_axis_mty1 <= 3'b0;
    end
    else begin
        output_axis_tdata <= mie_to_tx_axis_tdata;
        output_axis_tvalid <= mie_to_tx_axis_tvalid;
        output_axis_sop0 <= mie_to_tx_axis_tdata[95:0] == eth_header;
        output_axis_sop1 <= 0;
        output_axis_eop0 <= (mie_to_tx_axis_tkeep[7:0] < 8'hff) & mie_to_tx_axis_tlast;
        output_axis_eop1 <= (mie_to_tx_axis_tkeep[15:8] < 8'hff) & mie_to_tx_axis_tlast;
        output_axis_ena0 <= mie_to_tx_axis_tvalid;
        output_axis_ena1 <= mie_to_tx_axis_tvalid;
        output_axis_err0 <= 0;
        output_axis_err1 <= 0;
        //conversion between tkeep vs mty, the conversion should be done in 1 cycle
        case (mie_to_tx_axis_tkeep[7:0])
            8'b11111111: output_axis_mty0 <= 3'b000;
            8'b01111111: output_axis_mty0 <= 3'b001;
            8'b00111111: output_axis_mty0 <= 3'b010;
            8'b00011111: output_axis_mty0 <= 3'b011;            
            8'b00001111: output_axis_mty0 <= 3'b100;
            8'b00000111: output_axis_mty0 <= 3'b101;            
            8'b00000011: output_axis_mty0 <= 3'b110;
            8'b00000001: output_axis_mty0 <= 3'b111;
            default: output_axis_mty0 <= 3'b000;
        endcase
        
        case (mie_to_tx_axis_tkeep[15:8])
            8'b11111111: output_axis_mty1 <= 3'b000;
            8'b01111111: output_axis_mty1 <= 3'b001;
            8'b00111111: output_axis_mty1 <= 3'b010;
            8'b00011111: output_axis_mty1 <= 3'b011;            
            8'b00001111: output_axis_mty1 <= 3'b100;
            8'b00000111: output_axis_mty1 <= 3'b101;            
            8'b00000011: output_axis_mty1 <= 3'b110;
            8'b00000001: output_axis_mty1 <= 3'b111;
            default: output_axis_mty0 <= 3'b000;
        endcase            
    end
end

assign output_preamble = {7{8'h55}};
assign output_unfout = 1'b0;

endmodule // exdes_top
`default_nettype wire
