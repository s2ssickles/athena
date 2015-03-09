#-----------------------------------------------------------------------
# TITLE:
#    pkgModules.tcl
#
# PROJECT:
#    athena - Athena Regional Stability Simulation
#
# DESCRIPTION:
#    athena(n) package modules file
#
#    Generated by Kite.
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Package Definition

# -kite-provide-start  DO NOT EDIT THIS BLOCK BY HAND
package provide athena 6.3.0a7
# -kite-provide-end

#-----------------------------------------------------------------------
# Required Packages

# Add 'package require' statements for this package's external 
# dependencies to the following block.  Kite will update the versions 
# numbers automatically as they change in project.kite.

# -kite-require-start ADD EXTERNAL DEPENDENCIES
package require projectlib
# -kite-require-end

namespace import ::projectlib::*

#-----------------------------------------------------------------------
# Namespace definition

namespace eval ::athena:: {
    variable library [file dirname [info script]]
}

#-----------------------------------------------------------------------
# Modules

# Used to define and query orders.
::marsutil::order_set create ::athena::orders ::athena::athena_order {adb}

source [file join $::athena::library athena.tcl                      ]
source [file join $::athena::library athenadb.tcl                    ]
source [file join $::athena::library athena_order.tcl                ]
source [file join $::athena::library athena_flunky.tcl               ]
source [file join $::athena::library athena_types.tcl                ]
source [file join $::athena::library autogen.tcl                     ]
source [file join $::athena::library dynatypes.tcl                   ]
source [file join $::athena::library exporter.tcl                    ]
source [file join $::athena::library executive.tcl                   ]
source [file join $::athena::library gofer.tcl                       ]
source [file join $::athena::library gofer_rule.tcl                  ]
source [file join $::athena::library gofer_type.tcl                  ]
source [file join $::athena::library helpers.tcl                     ]
source [file join $::athena::library hist.tcl                        ]
source [file join $::athena::library link.tcl                        ]
source [file join $::athena::library paster.tcl                      ]
source [file join $::athena::library parmdb.tcl                      ]
source [file join $::athena::library ptype.tcl                       ]
source [file join $::athena::library rebase.tcl                      ]
source [file join $::athena::library ruleset_manager.tcl             ]
source [file join $::athena::library ruleset.tcl                     ]
source [file join $::athena::library sanity.tcl                      ]
source [file join $::athena::library sigevent.tcl                    ]
source [file join $::athena::library sim.tcl                         ]

# Editable Entities
source [file join $::athena::library absit.tcl                       ]
source [file join $::athena::library actor.tcl                       ]
source [file join $::athena::library block.tcl                       ]
source [file join $::athena::library bsys.tcl                        ]
source [file join $::athena::library cap.tcl                         ]
source [file join $::athena::library civgroup.tcl                    ]
source [file join $::athena::library condition.tcl                   ]
source [file join $::athena::library coop.tcl                        ]
source [file join $::athena::library curse.tcl                       ]
source [file join $::athena::library econ.tcl                        ]
source [file join $::athena::library frcgroup.tcl                    ]
source [file join $::athena::library hrel.tcl                        ]
source [file join $::athena::library hook.tcl                        ]
source [file join $::athena::library inject.tcl                      ]
source [file join $::athena::library iom.tcl                         ]
source [file join $::athena::library map.tcl                         ]
source [file join $::athena::library nbhood.tcl                      ]
source [file join $::athena::library nbrel.tcl                       ]
source [file join $::athena::library orggroup.tcl                    ]
source [file join $::athena::library payload.tcl                     ]
source [file join $::athena::library plant.tcl                       ]
source [file join $::athena::library sat.tcl                         ]
source [file join $::athena::library strategy.tcl                    ]
source [file join $::athena::library tactic.tcl                      ]
source [file join $::athena::library unit.tcl                        ]
source [file join $::athena::library vrel.tcl                        ]

# Non-Editable Entities
source [file join $::athena::library activity.tcl                    ]
source [file join $::athena::library agent.tcl                       ]
source [file join $::athena::library group.tcl                       ]

# Tactic APIs
source [file join $::athena::library abevent.tcl                     ]
source [file join $::athena::library broadcast.tcl                   ]
source [file join $::athena::library cash.tcl                        ]
source [file join $::athena::library coffer.tcl                      ]
source [file join $::athena::library control.tcl                     ]
source [file join $::athena::library personnel.tcl                   ]
source [file join $::athena::library stance.tcl                      ]

# Models
source [file join $::athena::library aam.tcl                         ]
source [file join $::athena::library control_model.tcl               ]
source [file join $::athena::library coverage_model.tcl              ]
source [file join $::athena::library demog.tcl                       ]
source [file join $::athena::library security_model.tcl              ]
source [file join $::athena::library service.tcl                     ]

# Conditions
source [file join $::athena::library conditions condition_compare.tcl]
source [file join $::athena::library conditions condition_control.tcl]
source [file join $::athena::library conditions condition_expr.tcl   ]

# Gofer Types
source [file join $::athena::library gofers gofer_actors.tcl         ]
source [file join $::athena::library gofers gofer_civgroups.tcl      ]
source [file join $::athena::library gofers gofer_frcgroups.tcl      ]
source [file join $::athena::library gofers gofer_groups.tcl         ]
source [file join $::athena::library gofers gofer_nbhoods.tcl        ]
source [file join $::athena::library gofers gofer_number.tcl         ]

# Rulesets
source [file join $::athena::library rulesets ruleset_abevent.tcl    ]
source [file join $::athena::library rulesets ruleset_abservice.tcl  ]
source [file join $::athena::library rulesets ruleset_absit.tcl      ]
source [file join $::athena::library rulesets ruleset_actsit.tcl     ]
source [file join $::athena::library rulesets ruleset_civcas.tcl     ]
source [file join $::athena::library rulesets ruleset_consump.tcl    ]
source [file join $::athena::library rulesets ruleset_control.tcl    ]
source [file join $::athena::library rulesets ruleset_curse.tcl      ]
source [file join $::athena::library rulesets ruleset_eni.tcl        ]
source [file join $::athena::library rulesets ruleset_iom.tcl        ]
source [file join $::athena::library rulesets ruleset_mood.tcl       ]
source [file join $::athena::library rulesets ruleset_unemp.tcl      ]

# Tactics
source [file join $::athena::library tactics tactic_absit.tcl        ]
source [file join $::athena::library tactics tactic_accident.tcl     ]
source [file join $::athena::library tactics tactic_assign.tcl       ]
source [file join $::athena::library tactics tactic_attrit.tcl       ]
source [file join $::athena::library tactics tactic_broadcast.tcl    ]
source [file join $::athena::library tactics tactic_build.tcl        ]
source [file join $::athena::library tactics tactic_curse.tcl        ]
source [file join $::athena::library tactics tactic_damage.tcl       ]
source [file join $::athena::library tactics tactic_demo.tcl         ]
source [file join $::athena::library tactics tactic_demob.tcl        ]
source [file join $::athena::library tactics tactic_deploy.tcl       ]
source [file join $::athena::library tactics tactic_deposit.tcl      ]
source [file join $::athena::library tactics tactic_executive.tcl    ]
source [file join $::athena::library tactics tactic_explosion.tcl    ]
source [file join $::athena::library tactics tactic_flow.tcl         ]
source [file join $::athena::library tactics tactic_fund.tcl         ]
source [file join $::athena::library tactics tactic_fundeni.tcl      ]
source [file join $::athena::library tactics tactic_grant.tcl        ]
source [file join $::athena::library tactics tactic_maintain.tcl     ]
source [file join $::athena::library tactics tactic_mobilize.tcl     ]
source [file join $::athena::library tactics tactic_riot.tcl         ]
source [file join $::athena::library tactics tactic_service.tcl      ]
source [file join $::athena::library tactics tactic_sigevent.tcl     ]
source [file join $::athena::library tactics tactic_spend.tcl        ]
source [file join $::athena::library tactics tactic_stance.tcl       ]
source [file join $::athena::library tactics tactic_support.tcl      ]
source [file join $::athena::library tactics tactic_violence.tcl     ]
source [file join $::athena::library tactics tactic_withdraw.tcl     ]


# Tk Code (loaded only if Tk is already present)
if {[info command tk] ne ""} {
    source [file join $::athena::library tk goferfield.tcl           ]
    source [file join $::athena::library tk rolemapfield.tcl         ]
}
