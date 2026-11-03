$date
	Tue Nov  3 12:21:04 2026
$end
$version
	Icarus Verilog
$end
$timescale
	1ps
$end
$scope module gray_counter_tb $end
$var wire 4 ! gray_code [3:0] $end
$var reg 1 " clk $end
$var reg 1 # rst $end
$var reg 1 $ up_down $end
$scope module dut $end
$var wire 1 " clk $end
$var wire 4 % gray_code [3:0] $end
$var wire 1 # rst $end
$var wire 1 $ up_down $end
$var wire 1 & prescale_tick $end
$var reg 4 ' binary_code_count [3:0] $end
$var reg 4 ( gray_code_count [3:0] $end
$var reg 27 ) prescale_count [26:0] $end
$scope begin GrayCodeConverter $end
$upscope $end
$upscope $end
$scope task check_gray $end
$upscope $end
$scope task clock_edge $end
$upscope $end
$scope task wait_for_tick $end
$upscope $end
$upscope $end
$enddefinitions $end
#0
$dumpvars
b0 )
b0 (
b0 '
0&
b0 %
1$
1#
1"
b0 !
$end
#5000
0"
#10000
b1 )
1"
0#
#15000
0"
#20000
b10 )
1"
#25000
0"
#30000
1&
b11 )
1"
#35000
0"
#40000
b1 !
b1 %
b1 (
0&
b0 )
b1 '
1"
#45000
0"
#50000
b1 )
1"
#55000
0"
#60000
b10 )
1"
#65000
0"
#70000
1&
b11 )
1"
#75000
0"
#80000
b11 !
b11 %
b11 (
0&
b0 )
b10 '
1"
#85000
0"
#90000
b1 )
1"
#95000
0"
#100000
b10 )
1"
#105000
0"
#110000
1&
b11 )
1"
#115000
0"
#120000
b10 !
b10 %
b10 (
0&
b0 )
b11 '
1"
#125000
0"
#130000
b1 )
1"
0$
#135000
0"
#140000
b10 )
1"
#145000
0"
#150000
1&
b11 )
1"
#155000
0"
#160000
b11 !
b11 %
b11 (
0&
b0 )
b10 '
1"
#165000
0"
#170000
b0 !
b0 %
b0 (
b0 '
1"
1#
#175000
0"
#180000
0#
