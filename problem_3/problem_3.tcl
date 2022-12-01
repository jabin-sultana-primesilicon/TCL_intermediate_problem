######################
#
#Title: Intermediate Problem 3
#
#Author: Jabin Sultana
#Version: 1 
#
#Date: 21.11.2022
#
######################

set TIME_start [clock clicks -milliseconds]
exec mkdir pathgroup
set f [open timing.lifcc.rpt.txt  r];     #input file
#set str2 [lsort -u $str1]
#foreach filename $str2 {
#       puts [set output_file $filename.txt]
set flag 0
while {[gets $f line] >= 0} {
	if {[regexp "Startpoint" $line]} {
		set flag 1
		set value ""
	}
	if { $flag ==1} {
		lappend value $line; #value 
	}
	if {[regexp {slack \(with no derating\) \(VIOLATED\)} $line]} {
		lappend value $line

		set fo [open "pathgroup/$str.txt" a+]
		puts $fo $value
	        close $fo	
		set flag 0
	#	set value ""
		set str ""
	}
	
	if {[regexp {Path Group:} $line]} {
		set str [lindex $line 2]
	}
}
close $f
set TIME_taken [expr [clock clicks -milliseconds] - $TIME_start]
puts "TIME STAMP: $TIME_taken milliseconds"


