######################
#
#Title: Intermediate Problem 2 (print summer line,in reverse order,replace,     vowel contained)
#
#Author: Jabin Sultana
#
#Version: 1
#
#Date: 14.11.2022
#
######################

set TIME_start [clock clicks -milliseconds]

set f [open  LIF02_Setup_timing.rpt.txt r]
set fo [open timing.txt w+]
set str ""
set str1 ""
set count 0
while {[gets $f line] >=0} {
	if {[regexp -nocase "delay250X" [lindex $line 1]] || [regexp -nocase "delay100X" [lindex $line 1]] || [regexp -nocase {DLY.*} [lindex $line 1]]} {
	         set str [string map {"(" "" ")" "" } [lindex $line 1]]             
		if {[info exists str2($str)]} {
			lappend str2($str) [lindex $line 2]		
	      	} else {
			set str2($str) [lindex $line 2]
		}	
	}
}
#parray str2
foreach index [array names str2] {
	#        puts "str2($index) = "
		set maxval 0
		set maxcount 0
	foreach val $str2($index) {
		if {[llength [lsearch -all -inline $str2($index) $val]] >$maxcount} {
                	set maxcount [llength [lsearch -all -inline $str2($index) $val]]
			set maxval $val
              
			}
		}
		puts $fo "$index : $maxval, $maxcount times"
} 
close $f
close $fo
set TIME_taken [expr [clock clicks -milliseconds] - $TIME_start]
puts "TIME STAMP: $TIME_taken milliseconds"

