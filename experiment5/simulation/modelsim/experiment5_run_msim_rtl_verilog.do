transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FPGA_Lab/FPGA_Lab/experiment5 {F:/FPGA_Lab/FPGA_Lab/experiment5/GenClockDCF.v}
vlog -vlog01compat -work work +incdir+F:/FPGA_Lab/FPGA_Lab/experiment5 {F:/FPGA_Lab/FPGA_Lab/experiment5/setClock.v}
vlog -vlog01compat -work work +incdir+F:/FPGA_Lab/FPGA_Lab/experiment5 {F:/FPGA_Lab/FPGA_Lab/experiment5/dcf77_decoder.v}
vlog -vlog01compat -work work +incdir+F:/FPGA_Lab/FPGA_Lab/experiment5 {F:/FPGA_Lab/FPGA_Lab/experiment5/control_unit.v}
vlog -vlog01compat -work work +incdir+F:/FPGA_Lab/FPGA_Lab/experiment5 {F:/FPGA_Lab/FPGA_Lab/experiment5/pll10.v}
vlog -vlog01compat -work work +incdir+F:/FPGA_Lab/FPGA_Lab/experiment5/db {F:/FPGA_Lab/FPGA_Lab/experiment5/db/pll10_altpll.v}
vlog -vlog01compat -work work +incdir+F:/FPGA_Lab/FPGA_Lab/experiment5 {F:/FPGA_Lab/FPGA_Lab/experiment5/timeanddateclock.v}
vcom -93 -work work {F:/FPGA_Lab/FPGA_Lab/experiment5/LCDsteuerung.vhd}
vcom -93 -work work {F:/FPGA_Lab/FPGA_Lab/experiment5/lcddriver.vhd}
vcom -93 -work work {F:/FPGA_Lab/FPGA_Lab/experiment5/FIFO.vhd}

