######################
#
#Title: Intermediate Problem 5 
#
#Author: Jabin Sultana 
#Version: 1
#
#Date: 15.11.2022
#
######################
set TIME_start [clock clicks -milliseconds]
#all files in a list
set files [exec find -name "data*"]
#output file
set fo [open output_file.csv w+]

foreach f1 $files {
        puts $fo "Filename,Pin,Direction,Max_rise,Max_fall,worst_transition,Limit,Slack\n"
        set file [open "$f1" r]
        while {[gets $file line] >=0} {
	#maximum rise
        set a [string map {"R=" " " "," " "} [lindex $line 6]]
        #maximum fall
	set b [string map {"F=" " " "," " "} [lindex $line 7]]
        #worst time
        proc max {a b} {
        	if {$a > $b} {
                	return $a
        	} else {
                	return $b
       		 }
	}
        set c [max $a $b]
	#threshold time
	set d [string map {"Threshold=" " " "," " "} [lindex $line 8]]
        #slack 
        #set e [expr $c -1]
	if {[regexp -nocase "Pin" $line]} {
		if {[regexp -nocase "in" [lindex $line 5]] || [regexp -nocase "out" [lindex $line 5]]} {
			puts $fo "$f1, [lindex $line 3], [string map {")," " "} [lindex $line 5]], $a, $b, $c, $d,[format %.3f [expr $c-$d]]"
	}
}
}
}
close $file
close $fo

set TIME_taken [expr [clock clicks -milliseconds] - $TIME_start]
puts "TIME STAMP: $TIME_taken milliseconds"

