######################
#
#Title: Intermediate Problem 7
#
#Author: Jabin Sultana
#
#Version: 1
#
#Date: 17.11.2022
#
######################

set f [open employee.txt r]
puts "Input file name"
gets stdin fileName
puts "Input Information for employee"
gets stdin a
#set f [open $fileName r]
while {[gets $f line]>=0} {
	if {[lindex $line 0]=="Name:"} {
		set employeeName [lrange $line 1 end]
	}
	foreach attr $a {
		if {[regexp -nocase $attr [string map {":" ""} $line]]} {
			dict set employees($employeeName) $attr [lrange $line 1 end]
		}
	}
}

puts "\nNumber of employee: [array size employees]\n"

foreach employee [lsort [array names employees]] {
	puts "------Info of $employee------"
	foreach attr [lsort [dict keys $employees($employee)]] {
		puts "$attr => [dict get $employees($employee) $attr]"
	}
	puts ""
}
  

	     


