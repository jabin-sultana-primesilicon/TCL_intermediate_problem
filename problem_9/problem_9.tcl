######################
#
#Title: Intermediate Problem 9
#
#Author: Jabin Sultana
#Version: 1
#
#Date: 14.11.2022
#
######################
set TIME_start [clock clicks -milliseconds]

set f [open "library_spec_14_05_18.txt" r]

puts "Enter Memory Name:"
gets stdin memory_name
puts "Enter Extension:"
gets stdin extension

set height 0.0
set width 0.0

while {![eof $f]} {
        gets $f line
        #lc_dimension
        if {[regexp {lc_dimension: } $line]} {
                foreach val [lindex $line 1] {
                        set lc_dim([lindex $val 0]) [lindex $val 1]
                }
        }
        #lib_cells
        if {[regexp {lib_cell } $line]} {
                foreach val [lindex $line 1] {
                        set lib_cells([lindex $val 0]) [lindex $val 1]
                }
        }
        #memory_origin
        if {[regexp {memory_origin\s\{} $line]} {
                while {[gets $f line]>=0} {
                        if {[regexp {\}} $line]} {
                                break
                        } else {
                                set memory_origin([lindex $line 0]) [lindex $line 1]
                        }
                }
        }
        # die_area
        if {[regexp {die_area} $line]} {
                set die_area [lindex $line 1]
        }
        # die_aspect_ratio
        if {[regexp {die_aspect_ratio} $line]} {
                set die_aspect_ratio [lindex $line 1]
        }
        #core2die
        if {[regexp {core2die} $line]} {
               set core2die [lrange $line 1 2]
        }
}


#height
set height [expr {sqrt ($die_area/$die_aspect_ratio)}]
puts "Height: $height"
#width
set width [expr {$height * $die_aspect_ratio}]
puts "Width: $width"
#Upper right corner of core : value will be subtract from core2die
#remove ' sign
set core2die1 [string map -nocase {"'" ""} $core2die]
#Upper right corner of core : value will be subtract from core2die
#remove ' sign
set core2die_origin [string map -nocase {"'" ""} $core2die]
set core2die_X [lindex $core2die_origin 0]
set core2die_Y [lindex $core2die_origin 1]
set X_side [expr {$width -$core2die_X}]; #core width
set Y_side [expr {$height - $core2die_Y}]; #core height
puts "Upper right corner of core: [format %.3f $X_side], [format %.3f $Y_side]"

set corewidth [expr int($X_side/$core2die_X)*$core2die_X]
set coreheight [expr int($Y_side/$core2die_Y)*$core2die_Y]

puts "Upper right of core align with pitch: $corewidth $coreheight"

set llx [lindex $memory_origin($memory_name) 0]
set lly [lindex $memory_origin($memory_name) 1]
puts "LL of memory = $llx $lly"

set uux [expr [lindex $memory_origin($memory_name) 0] + [lindex $lc_dim($lib_cells($memory_name)) 0]]
set uuy [expr [lindex $memory_origin($memory_name) 1] + [lindex $lc_dim($lib_cells($memory_name)) 1]]
puts "UR of MEmory: $uux $uuy"

puts "Extension is: $extension"
if {[llength $extension]==1} {
        set east [expr $llx - $extension]
        set north [expr $uuy + $extension]
        set west [expr $uux + $extension]
        set south [expr $llx - $extension]
} else {
        set east [expr $llx - [lindex $extension 0]]
        set north [expr $uuy + [lindex $extension 1]]
        set west [expr $uux + [lindex $extension 2]]
        set south [expr $llx - [lindex $extension 3]]
}
puts "Extension (E N W S) = $east $west $north $south"

puts "LL is: $core2die_X $core2die_Y"
puts "UP is: $west $north"

close $f

set TIME_taken [expr [clock clicks -milliseconds] - $TIME_start]
puts "TIME STAMP: $TIME_taken milliseconds"
