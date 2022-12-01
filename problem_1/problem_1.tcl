######################
#
#Title: Intermediate Problem 1 (print summer line,in reverse order,replace,     vowel contained)
#
#Author: Jabin Sultana
#Version: 1
#
#Date: 14.11.2022
#
######################



set TIME_start [clock clicks -milliseconds]

#open the file
#read the file line by line
set f [open test.txt r]
set linenumber 0
set count 0
set vowel {a e i u o}
set tmp ""
set res 0
set sum 0
set vin ""
while {[gets $f line] >=0} {
      incr linenumber
	#use regexp for pattern match
      if {[regexp -nocase "summer" $line]} {
	     puts "$linenumber: $line"	     
	     #print reverse order those lines
	     puts "Reverse string: [string reverse $line]"
	     puts "Replace last word: [lreplace $line end end "Replaced"]"
	     #print the vowels contained in the line 
	     set l [split $line ""]
	     puts $l; #del
	     set str ""
	     foreach item $l {
		if { [regexp -nocase $item $vowel] && $item!=" "} {
			lappend str $item
		}
             }
	     puts [join $str ""]
	     puts [llength $str]
	     puts  [join [lsort -u -nocase $str] ""]
	     foreach val $vowel {
		    puts "vowel $val: [lsearch -all -nocase [split $line ""] $val]"
	    }
	    
}
}

set TIME_taken [expr [clock clicks -milliseconds] - $TIME_start]
puts "TIME STAMP: $TIME_taken milliseconds"

