######################
#
#Title: Intermediate Problem 4
#
#Author: Jabin Sultana
#
#Version: 1
#
#Date: 14.11.2022
#
######################

set TIME_start [clock clicks -milliseconds]

puts "enter 1st number:"
gets stdin num1 
puts "enter 2nd number:"
gets stdin num2
proc compositenumber {x y} {
	for {set i $x} {$i<=$y} {incr i} {
		set count 0
		for {set j 1} {$j<=$i} {incr j} {
			if {$i % $j ==0 } {
				incr count
			}
		}
			if {$count >2} {
			     puts -nonewline "$i "
			   set count 0
			  }
		  
	  	  }
		  
	return 0
}
puts "composite numbers between $num1 and $num2:"
compositenumber $num1 $num2 

proc primenumber {x y} {
	for {set i $x} {$i<=$y} {incr i} {
		set count 0
		for {set j 1} {$j<=$i} {incr j} {
			if {$i % $j ==0 } {
				incr count
			}
			
		  }
			if {$count == 2} {
			     puts -nonewline "$i "
			   set count 0
			  }
	  	  }
		  
	return 0
}

puts "\nPrime numbers between $num1 and $num2:"
primenumber $num1 $num2

set TIME_taken [expr [clock clicks -milliseconds] - $TIME_start]
puts "\nTIME STAMP: $TIME_taken milliseconds"

