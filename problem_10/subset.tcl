# This is a faster & more efficient code than that of powerset


proc subset {n} {

                set in [ list ]
                for { set i 0 } { $i < $n } { incr i } {
                                lappend in $i
                }
                set subsets [ list [ list ] ]
                foreach el $in {
                                foreach sub $subsets {
                                                lappend subsets [ lappend sub $el ]
                                }
                }
                return $subsets
 }


