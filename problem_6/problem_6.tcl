######################
#
#Title: Intermediate Problem 6
#
#Author: Jabin Sultana
#
#Version: 1
#
#Date: 18.11.2022
#
######################



set TIME_start [clock clicks -milliseconds]

set f1 [open all_timing_report.rpt r]
set fo [open all_timing_report.csv w+]
puts $fo " Libcell,Min_delay,Avg_delay,Max_delay\n"

while {[gets $f1 line]>=0} {
	if {[regexp {\/Y } $line] || [regexp {\/Q } $line] || [regexp {\/ECK } $line]} {
		set str [string map {"(" " " ")" " "} [lindex $line 1]]
		if {[llength $line]>=7} {	
			if {[info exists str2($str)]} {
			lappend str2($str) [lindex $line 4]
		} else {
			set str2($str) [lindex $line 4]
		}
	} else {
		gets $f1 line
			if {[info exists str2($str)]} {
				lappend str2($str) [lindex $line 2]
			} else {
			set str2($str) [lindex $line 2]
	  		}
		}
	       	
	}

}
set sum 0		
set avg 0.0
#parray str2
foreach index [array names str2] {
	
	set max [lindex [lsort -decreasing $str2($index)] 0]
	set min [lindex [lsort -decreasing $str2($index)] end]
	set avg [expr "[join $str2($index) "+"]"]
        set avg [expr {$avg/[llength $str2($index)]}]
	puts $fo "$index,$min,$avg,$max"
	}
#puts $max
#puts $min
#puts $avg
close $f1
close $fo

set TIME_taken [expr [clock clicks -milliseconds] - $TIME_start]
puts "TIME STAMP: $TIME_taken milliseconds"

