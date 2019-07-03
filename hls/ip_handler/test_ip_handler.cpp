/************************************************
Copyright (c) 2016, Xilinx, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, 
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, 
this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, 
this list of conditions and the following disclaimer in the documentation 
and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors 
may be used to endorse or promote products derived from this software 
without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.// Copyright (c) 2015 Xilinx, Inc.
************************************************/
#include "ip_handler.hpp"


using namespace hls;
using namespace std;

//modified by liudong16
int main(int argc, char* argv[]) {
	axiWord inData;
	axiWord outData;
	stream<axiWord> inFIFO("inFIFO");
	stream<axiWord> outFifoARP("outFifoARP");
	stream<axiWord> outFifoshiftIP("outFifoshiftIP");
	stream<axiWord> outFifoIP("outFifoIP");
	stream<axiWord> outFifoTCP("outFifoTCP");
	stream<axiWord> outFifoUDP("outFifoUDP");
	stream<axiWord> outFifoICMP("outFifoICMP");
	//stream<axiWord> outFifoICMPexp("outFifoICMPexp");

	std::ifstream inputFile;
	//std::ifstream goldenFile;
	std::ofstream outputFile1;
	std::ofstream outputFile2;
	std::ofstream outputFile3;

	ap_uint<32> ipAddress 	= 0x01010101;
        int		errCount 	= 0;

	inputFile.open("../../../../in_128bit.dat");
	if (!inputFile) {
		cout << "Error: could not open test input file." << endl;
		return -1;
	}
	outputFile1.open("../../../../outIP_128bit.dat");
	if (!outputFile1) {
		cout << "Error: could not open test output file." << endl;
		return -1;
	}
	outputFile2.open("../../../../outshiftIP_128bit.dat");
	if (!outputFile2) {
		cout << "Error: could not open test output file." << endl;
		return -1;
	}
	outputFile3.open("../../../../outUDP_128bit.dat");
	if (!outputFile3) {
		cout << "Error: could not open test output file." << endl;
		return -1;
	}


	/*
	goldenFile.open("../../../../out.gold");
	if (!goldenFile) {
		cerr << " Error opening golden output file!" << endl;
		return -1;
	}
	*/

	uint16_t keepTemp;
	uint64_t dataHighTemp;
	uint64_t dataLowTemp;
	uint16_t lastTemp;
	int count = 0;
	while (inputFile >> std::hex >> dataHighTemp >> dataLowTemp >> keepTemp >> lastTemp) {
		inData.data(127, 64) = dataHighTemp;
		inData.data(63, 0) = dataLowTemp;
		inData.keep = keepTemp;
		//inData.user = 0;
		inData.last = lastTemp;
		inFIFO.write(inData);
	}
	while (count < 100)	{
		//ip_handler(inFIFO, outFifoARP, outFifoICMP, outFifoUDP, outFifoTCP, ipAddress);
		ip_handler(inFIFO, outFifoARP, outFifoICMP, outFifoUDP, outFifoTCP);
		count++;
	}
	outputFile1 << std::hex << std::noshowbase;
	outputFile1 << std::setfill('0');
	while (!(outFifoARP.empty())) {
		outFifoARP.read(outData);
		outputFile1 << std::setw(8) << ((uint32_t) outData.data(127, 96));
		outputFile1 << std::setw(8) << ((uint32_t) outData.data(95, 64));
		outputFile1 << std::setw(8) << ((uint32_t) outData.data(63, 32));
		outputFile1 << std::setw(8) << ((uint32_t) outData.data(31, 0));
		outputFile1 << " " << std::setw(2) << (uint32_t) outData.keep(15,8) << std::setw(2) << (uint32_t) outData.keep(7, 0) << " ";
		outputFile1 << std::setw(1) << ((uint32_t) outData.last) << std::endl;
		/*
		goldenFile >> std::hex >> dataTemp >> keepTemp >> lastTemp;
		if (outData.data != dataTemp || outData.keep != keepTemp ||
			outData.last != lastTemp) {
			errCount++;
			cerr << "X";
		} else {
			cerr << ".";
		}
		*/
	}
/*
	outputFile2 << std::hex << std::noshowbase;
	outputFile2 << std::setfill('0');
	while (!(outFifoshiftIP.empty())) {
		outFifoshiftIP.read(outData);
		outputFile2 << std::setw(8) << ((uint32_t) outData.data(127, 96));
		outputFile2 << std::setw(8) << ((uint32_t) outData.data(95, 64));
		outputFile2 << std::setw(8) << ((uint32_t) outData.data(63, 32));
		outputFile2 << std::setw(8) << ((uint32_t) outData.data(31, 0));
		outputFile2 << " " << std::setw(2) << ((uint32_t) outData.keep) << " ";
		outputFile2 << std::setw(1) << ((uint32_t) outData.last) << std::endl;

		goldenFile >> std::hex >> dataTemp >> keepTemp >> lastTemp;
		if (outData.data != dataTemp || outData.keep != keepTemp ||
			outData.last != lastTemp) {
			errCount++;
			cerr << "X";
		} else {
			cerr << ".";
		}

	}
*/
	outputFile3 << std::hex << std::noshowbase;
	outputFile3 << std::setfill('0');
	while (!(outFifoUDP.empty())) {
		outFifoUDP.read(outData);
		outputFile3 << std::setw(8) << ((uint32_t) outData.data(127, 96));
		outputFile3 << std::setw(8) << ((uint32_t) outData.data(95, 64));
		outputFile3 << std::setw(8) << ((uint32_t) outData.data(63, 32));
		outputFile3 << std::setw(8) << ((uint32_t) outData.data(31, 0));
		outputFile3 << " " << std::setw(2) << ((uint32_t) outData.keep) << " ";
		outputFile3 << std::setw(1) << ((uint32_t) outData.last) << std::endl;
		/*
		goldenFile >> std::hex >> dataTemp >> keepTemp >> lastTemp;
		if (outData.data != dataTemp || outData.keep != keepTemp ||
			outData.last != lastTemp) {
			errCount++;
			cerr << "X";
		} else {
			cerr << ".";
		}
		*/
	}
	/*
	while (!(outFifoICMP.empty())) {
		outFifoICMP.read(outData);
		outputFile << std::setw(8) << ((uint32_t) outData.data(127, 96));
		outputFile << std::setw(8) << ((uint32_t) outData.data(95, 64));
		outputFile << std::setw(8) << ((uint32_t) outData.data(63, 32));
		outputFile << std::setw(8) << ((uint32_t) outData.data(31, 0));
		outputFile << " " << std::setw(2) << ((uint32_t) outData.keep) << " ";
		outputFile << std::setw(1) << ((uint32_t) outData.last) << std::endl;
		goldenFile >> std::hex >> dataTemp >> keepTemp >> lastTemp;
		if (outData.data != dataTemp || outData.keep != keepTemp ||
			outData.last != lastTemp) {
			errCount++;
			cerr << "X";
		} else {
			cerr << ".";
		}
	}
	while (!(outFifoUDP.empty())) {
		outFifoUDP.read(outData);
		outputFile << std::setw(8) << ((uint32_t) outData.data(127, 96));
		outputFile << std::setw(8) << ((uint32_t) outData.data(95, 64));
		outputFile << std::setw(8) << ((uint32_t) outData.data(63, 32));
		outputFile << std::setw(8) << ((uint32_t) outData.data(31, 0));
		outputFile << " " << std::setw(2) << ((uint32_t) outData.keep) << " ";
		outputFile << std::setw(1) << ((uint32_t) outData.last) << std::endl;
		goldenFile >> std::hex >> dataTemp >> keepTemp >> lastTemp;
		if (outData.data != dataTemp || outData.keep != keepTemp ||
			outData.last != lastTemp) {
			errCount++;
			cerr << "X";
		} else {
			cerr << ".";
		}
	}
	while (!(outFifoTCP.empty())) {
		outFifoTCP.read(outData);
		outputFile << std::setw(8) << ((uint32_t) outData.data(127, 96));
		outputFile << std::setw(8) << ((uint32_t) outData.data(95, 64));
		outputFile << std::setw(8) << ((uint32_t) outData.data(63, 32));
		outputFile << std::setw(8) << ((uint32_t) outData.data(31, 0));
		outputFile << " " << std::setw(2) << ((uint32_t) outData.keep) << " ";
		outputFile << std::setw(1) << ((uint32_t) outData.last) << std::endl;
		goldenFile >> std::hex >> dataTemp >> keepTemp >> lastTemp;
		if (outData.data != dataTemp || outData.keep != keepTemp ||
			outData.last != lastTemp) {
			errCount++;
			cerr << "X";
		} else {
			cerr << ".";
		}
	}
	cerr << " done." << endl << endl;
	if (errCount == 0) {
	   	cerr << "*** Test Passed ***" << endl << endl;
	    return 0;
	} else {
	    cerr << "!!! TEST FAILED -- " << errCount << " mismatches detected !!!";
	    cerr << endl << endl;
	    return -1;
	}
	*/
	inputFile.close();
	outputFile1.close();
	outputFile2.close();
	outputFile3.close();
	//goldenFile.close();
}

