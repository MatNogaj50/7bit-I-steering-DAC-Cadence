# 7 bit DAC NMOS I-steering

This repository contains the documentation and Verilog files of a 7-bit NMOS Current Steering Digital to Analog Converter, developed as a course project for the Design of Integrated Circuits in CMOS Technology in Cadence Virtuoso.

## Overview

The goal of this project is to implement a 7-bit current steering architecture. The design is optimized for specific signal-tracking requirements. The project focuses on schematic design and simulation; layout is also included.

## Specifications

Resolution -- 7 bit  
Digital steering -- 3 types of signals: Sawtooth/Square/Triangle  
Period -- 2* 128t_clk (t_clk = 1ms)  
6 incline rates  
Vout range -- 0.5-3V  
Keys -- SPDT TGates  
OPamp -- 2-stage amplifier, phase margin +70, gain ~75dB, max Iout ~ 110uA  

