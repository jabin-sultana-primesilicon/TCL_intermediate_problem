######################
#
#Title: Intermediate Problem 10
#
#Author: Jabin Sultana
#Version: 1
#
#Date: 27.11.2022
#
######################

set TIME_start [clock clicks -milliseconds]

set f [open "Input.txt" r]
set fo [open "Output.txt" w+]
source "subset.tcl"
set flag 0
set flag1 0
set l1 {}
set slack_value {}
while {[gets $f line] >=0} {
	if {[regexp {Startpoint} $line]} {
		puts $fo $line
		while { ![regexp {Path Type: max} $line]} {
			gets $f line
			puts $fo $line
		}
		#startpoint to path type print above lines
		gets $f line
		set l1 {} ; #list of cells + cell value
		while { ![ regexp {slack \(VIOLATED\)} $line ] } { 
			puts $fo $line
			lappend l1 $line
			gets $f line
		}
		puts $fo $line
		set slack_value [lindex $line 2]
		set sort_list [lsort -real -index 2 $l1]
		set buffer_cells {}
		set cell_values {}
		foreach val $sort_list {
			lappend buffer_cells "[lindex $val 0] [lindex $val 1]"
			lappend cell_values [lindex $val 2]
		}
		#length of cell_value 
		set n [llength $cell_values]
		set low [expr {0-$slack_value}]
		set high [expr {0.1-$slack_value}]
		if {[lindex $cell_values 0] > $low } {
			puts $fo "\n Cann't be corrected by buffer removal. the smallest buffer removal causes hold violation\n" 
		} else {
			set cell_indexes [subset $n]
			set cell_out [list]
			foreach val $cell_indexes {
				set slack_value 0
				for { set i 0} { $i < [llength $val]} {incr i} {
					set slack_value [expr {$slack_value + [lindex $cell_values [lindex $val $i]]}]
				}
				if {$slack_value >= $low && $slack_value <= $high} {
					lappend cell_out "[format %.4f $slack_value] $val"
					puts -nonewline $fo "\nNew Slack = [format %.4f [expr $slack_value - $low]] ; Delay values are: "
					foreach a $val {
						puts -nonewline $fo "[lindex $cell_values $a]  "
					}
				}
			}
			set cell_out [lsort -real -index 0 $cell_out]
			set cell_out [lindex $cell_out 0]
			puts $fo "\n \nBuffers to remove:"
			for {set i 1} {$i <[llength $cell_out] } {incr i} {
				puts $fo "[lindex $buffer_cells [lindex $cell_out $i]]"
			}
			puts $fo "Resulting slack is [format %.4f [expr {[expr [lindex $cell_out 0]]}]]\n\n\n"
		}
	}
}
close $f
close $fo
set TIME_taken [expr [clock clicks -milliseconds] - $TIME_start]
puts "TIME STAMP: $TIME_taken milliseconds"
