#-----------------------------------------------------------------------
# TITLE:
#    unit.tcl
#
# AUTHOR:
#    Will Duquette
#
# DESCRIPTION:
#    athena(n): Unit Manager
#
#    This module is responsible for managing units of all kinds, and 
#    operations upon them.  As such, it is a type ensemble.
#
#-----------------------------------------------------------------------

snit::type ::athena::unit {
    #-------------------------------------------------------------------
    # Components

    component adb ;# The athenadb(n) instance

    #-------------------------------------------------------------------
    # Constructor

    # constructor adb_
    #
    # adb_    - The athenadb(n) that owns this instance.
    #
    # Initializes instances of the type.

    constructor {adb_} {
        set adb $adb_
    }

    #-------------------------------------------------------------------
    # Queries
    #
    # These routines query information about the entities; they are
    # not allowed to modify them.


    # names
    #
    # Returns the list of unit names

    method names {} {
        $adb eval {SELECT u FROM units}
    }


    # validate u
    #
    # u         Possibly, a unit name.
    #
    # Validates a unit name

    method validate {u} {
        if {![$adb exists {SELECT u FROM units WHERE u=$u}]} {
            return -code error -errorcode INVALID \
                "Invalid unit name: \"$u\""
        }

        return $u
    }


    # get u ?parm?
    #
    # u      The unit ID
    # parm   A parameter name
    #
    # Retrieves a unit dictionary, or a particular parm value.
    # This is for use when dealing with one single unit, e.g., in
    # an order routine; when dealing with many units in a loop, always
    # use $adb eval.

    method get {u {parm ""}} {
        # FIRST, get the unit
        $adb eval {SELECT * FROM units WHERE u=$u} row {
            if {$parm ne ""} {
                return $row($parm)
            } else {
                unset row(*)
                return [array get row]
            }
        }

        return ""
    }

    #-------------------------------------------------------------------
    # Non-Mutators
    #
    # The following commands act on units on behalf of other simulation
    # modules.  They should not be used from orders, as they are not
    # mutators.
    #
    # NOTE: No notification is sent to the GUI!  These routines are
    # for use during time advances and at simulation start, each of
    # which have their own updates.


    # reset
    #
    # Deactivates all units, setting their personnel to 0.  Units will
    # be activated as strategy execution proceeds.  Also, deletes 
    # units that are no longer needed.
    #
    # NOTE: This routine is called at the *beginning* of strategy execution.

    method reset {} {
        # FIRST, delete all units associated with tactics that no longer
        # exist.

        $adb eval {
            SELECT u, tactic_id
            FROM units
            WHERE tactic_id > 0
        } {
            if {![$adb bean hasa ::athena::tactic $tactic_id]} {
                $self delete $u
            }
        }

        # NEXT, deactivate all of the remaining units.
        $adb eval {
            UPDATE units
            SET personnel = 0,
                active    = 0
        }
    }

    # makebase
    #
    # Makes base units for all civilian groups and force and org 
    # deployments.
    #
    # NOTE: This routine is called at the *end* of strategy execution
    # to create base units for all unassigned personnel.

    method makebase {} {
        # FIRST, make base units for all FRC and ORG personnel
        $adb eval {
            SELECT n, g, unassigned 
            FROM deploy_ng
            WHERE personnel > 0
        } {
            $self PositionBaseUnit $n $g $unassigned
        }
        
        # NEXT, make base units for the civilians
        $adb eval {
            SELECT g, n, population
            FROM demog_g JOIN civgroups USING (g)
        } {
            $self PositionBaseUnit $n $g $population
        }
    }

    # PositionBaseUnit
    #
    #   n          The unit's neighborhood of origin
    #   g          The group to which it belongs
    #   personnel  The number of personnel unassigned
    #projectlib/
    # Creates a base unit with these parameters if one doesn't already
    # exist, Otherwise, assigns it the specified number of personnel.

    method PositionBaseUnit {n g personnel} {
        # FIRST, does the desired unit already exist?
        set u [format "%s/%s" $g $n]
 
        if {[$adb exists {SELECT u FROM units WHERE u=$u}]} {
            $self personnel $u $personnel
        } else {
            # FIRST, generate a random location in n
            set location [$adb nbhood randloc $n]

            # NEXT, retrieve the group type
            set gtype [$adb group gtype $g]

            # NEXT, save the unit in the database.
            $adb eval {
                INSERT INTO units(u,active,n,g,gtype,a,
                                  personnel,location)
                VALUES($u,
                       1,
                       $n,
                       $g,
                       $gtype,
                       'NONE',
                       $personnel,
                       $location);
            }
        }
    }

    

    # assign tactic_id g n a personnel
    #
    # tactic_id   - The tactic ID for which the personnel are being
    #               assigned.
    # g           - The group providing the personnel
    # n           - The nbhood in which the personnel are assigned
    # a           - The activity to which they will be assigned
    # personnel   - The number of personnel to assign.
    #
    # Creates a unit with these parameters if one doesn't already exist.
    # The unit will be given a random location in n if it is new, or
    # if it isn't already in n.  The unit will be active.
    #
    # NOTE: The main point here is it retain the (possibly user-set) 
    # location for the unit, if at all possible, while allowing all of
    # the rest of the data to change as the tactic changes.
    #
    # Returns the unit name.

    method assign {tactic_id g n a personnel} {
        # FIRST, try to retrieve the unit data.
        set unit(u) ""

        $adb eval {SELECT * FROM units WHERE tactic_id=$tactic_id} unit {}

        # NEXT, create it or update it.
        if {$unit(u) eq ""} {
            # FIRST, Compute required fields.
            set unit(u)  [format "UT%04d" $tactic_id]
            set location [$adb nbhood randloc $n]
            set gtype    [$adb group gtype $g]

            # NEXT, save the unit in the database.
            $adb eval {
                INSERT INTO units(u,tactic_id,active,n,g,gtype,a,
                                  personnel,location)
                VALUES($unit(u),
                       $tactic_id,
                       1,
                       $n,
                       $g,
                       $gtype,
                       $a,
                       $personnel,
                       $location);
            }
        } else {
            # FIRST, the group type might have changed.
            set gtype [$adb group gtype $g]

            # NEXT, the neighborhood might have changed.  If so,
            # pick a random location in the new neighborhood.
            if {[$adb nbhood find {*}$unit(location)] ne $n} {
                set unit(location) [$adb nbhood randloc $n]
            }

            # NEXT, update the unit
            $adb eval {
                UPDATE units
                SET active    = 1,
                    n         = $n,
                    g         = $g,
                    gtype     = $gtype,
                    a         = $a,
                    personnel = $personnel,
                    location  = $unit(location)
                WHERE tactic_id=$tactic_id;
            }
        }

        return $unit(u)
    }


    # personnel u personnel
    #
    # u              The unit's ID
    # personnel      The new number of personnel
    #
    # Sets the unit's personnel and marks the unit active.

    method personnel {u personnel} {
        $adb eval {
            UPDATE units
            SET   personnel = $personnel,
                  active    = 1
            WHERE u=$u
        }

        return
    }


    # delete u
    #
    # u    A unit name
    #
    # Deletes the unit altogether.

    method delete {u} {
        $adb delete units {u=$u}
        return
    }

    #-------------------------------------------------------------------
    # Mutators
    #
    # Mutators are used to implement orders that change the scenario in
    # some way.  Mutators assume that their inputs are valid, and returns
    # a script of one or more commands that will undo the change.  When
    # a change cannot be undone, the mutator returns the empty string.


    # move u location
    #
    # u              The unit's ID
    # location       A new location (map coords) or ""
    #
    # Moves a unit given the parms, which are presumed to be
    # valid.

    method move {u location} {
        # FIRST, get the undo information
        $adb eval {
            SELECT location AS oldLocation FROM units
            WHERE u=$u
        } {}

        # NEXT, Update the unit
        $adb eval {
            UPDATE units
            SET location = $location
            WHERE u=$u
        }

        # NEXT, Return the undo command
        return [mymethod move $u $oldLocation]
    }

    # personnel u personnel
    #
    # u              The unit's ID
    # personnel      The new number of personnel
    #
    # Sets the unit's personnel given the parms, which are presumed to be
    # valid, and marks the unit active.  This is used only by the ATTRIT:*
    # orders.

    method personnel {u personnel} {
        # FIRST, get the undo information
        $adb eval {
            SELECT personnel AS oldPersonnel FROM units
            WHERE u=$u
        } {}

        # NEXT, Update the unit
        $adb eval {
            UPDATE units
            SET   personnel = $personnel,
                  active    = 1
            WHERE u=$u
        }

        # NEXT, Return the undo command
        return [mymethod personnel $u $oldPersonnel]
    }
}

#-------------------------------------------------------------------
# Orders: UNIT:*

# UNIT:MOVE
#
# Moves an existing unit.

::athena::orders define UNIT:MOVE {
    meta title      "Move Unit"
    meta sendstates {PREP PAUSED}
    meta parmlist   {u location}

    meta form {
        rcc "Unit" -for u
        dbkey u -table gui_units -keys u \
            -loadcmd {$order_ keyload u *}

        rcc "Location" -for location
        text location
    }

    meta parmtags {
        location point
    }

    method _validate {} {
        my prepare u          -toupper -required -type [list $adb unit]
        my prepare location   -toupper -required -type refpoint
    
        my returnOnError
    
        my checkon location {
            set n [$adb nbhood find {*}$parms(location)]
    
            if {$n ne [$adb unit get $parms(u) n]} {
                my reject location "Cannot remove unit from its neighborhood"
            }
        }
    }

    method _execute {{flunky ""}} {
        lappend undo [$adb unit move $parms(u) $parms(location)]
    
        my setundo [join $undo \n]
    }
}










