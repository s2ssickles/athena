#-----------------------------------------------------------------------
# TITLE:
#   vardiff_mood.tcl
#
# AUTHOR:
#   Dave Hanks
#
# DESCRIPTION:
#   athena(n) variable differences: mood.g
#
#-----------------------------------------------------------------------

oo::class create ::athena::vardiff::mood {
    superclass ::athena::vardiff
    meta type     mood.g
    meta category social

    constructor {comp_ val1_ val2_ n_} {
        next $comp_ [list n $n_] $val1_ $val2_
    }

    method significant {} {
        set lim 20.0 ;# TBD: Need parameter

        expr {[my score] >= $lim}
    }

    method format {val} {
        return [qsat longname $val]
    }

    method context {} {
        format "%.1f vs %.1f" [my val1] [my val2]
    }

    method score {} {
        format "%.1f" [next]
    }
}