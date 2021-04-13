#!/bin/bash

# script to synthesize cv32e40p with Symbiotic EDA yosys 

#paths
SOURCE_PATH="./rtl"
OUTPUT_PATH="./output_files"

# console outputs are logged to ./output_files/log.txt

# yosys invokes the synthesis script(.ys)
../../SymbioticEDA/bin/yosys -s cv32e40p.ys | tee ${OUTPUT_PATH}/log.txt