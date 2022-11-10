#open the file
#read the file line by line
set f [open test.txt r]
set linenumber 0
while {[gets $f line] >=0} {
      incr linenumber
      if {[regexp -nocase "summer" $line]} {
	      	#use regexp for pattern match
		puts "Number of summer in the line :[llength [lsearch -all -regexp -all $line summer]]"

	     puts "$linenumber: $line"	     
}
}
