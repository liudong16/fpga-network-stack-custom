/*
 * Copyright (c) 2018, Systems Group, ETH Zurich
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 * 3. Neither the name of the copyright holder nor the names of its contributors
 * may be used to endorse or promote products derived from this software
 * without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
#ifndef IPERF_UDP_CLIENT_HPP
#define IPERF_UDP_CLIENT_HPP

#include "../udp/udp.hpp"
//appended by liudong16
#include "../axi_utils.cpp" //for the lenToKeep function

#ifndef __SYNTHESIS__
static const ap_uint<40> END_TIME_100ms	= 5;
static const ap_uint<40> END_TIME_1s	= 10;
static const ap_uint<40> END_TIME_5s	= 1000;
static const ap_uint<40> END_TIME_30s	= 1000;
static const ap_uint<40> END_TIME_120s	= 1000;

/* modified by liudong16
#else
static const ap_uint<40> END_TIME_100ms	= 15625000;
static const ap_uint<40> END_TIME_1s	= 156250000;
static const ap_uint<40> END_TIME_5s	= 781250000;
static const ap_uint<40> END_TIME_30s	= 4687500000;
static const ap_uint<40> END_TIME_120s	= 18750000000;
#endif
*/
#else
static const ap_uint<40> END_TIME_100ms = 31250000;
static const ap_uint<40> END_TIME_1s    = 312500000;
static const ap_uint<40> END_TIME_5s    = 1562500000;
static const ap_uint<40> END_TIME_30s   = 9375000000;
static const ap_uint<40> END_TIME_120s  = 37500000000;
#endif

//modified by liudong16
//static const ap_uint<16> PKG_SIZE = 1400;

//static const ap_uint<16> PKG_WORDS = PKG_SIZE / 8;

//modified by liudong16
//static const ap_uint<16> MY_PORT = 32768;
static const ap_uint<16> MY_PORT = 0x013f;//my port of moogen


void iperf_udp_client(	hls::stream<ipUdpMeta>&	rxMetaData,
						hls::stream<axiWord>&	rxData,
						hls::stream<ipUdpMeta>&	txMetaData,
						hls::stream<axiWord>&	txData,
						ap_uint<1>		runExperiment,
						ap_uint<1>		size_4,
						ap_uint<1>		size_16,
						ap_uint<1>		size_64,
						ap_uint<1>		size_256,
						ap_uint<1>		size_512,
						ap_uint<1>		size_1024,
						ap_uint<1>		size_2048,
						//modified by liudong16
						//ap_uint<128>	regTargetIpAddress,
						ap_uint<32> regTargetIpAddress,
						ap_uint<8>		regPacketGap);
#endif
