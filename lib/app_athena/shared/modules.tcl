#-----------------------------------------------------------------------
# FILE: 
#   modules.tcl -- subpackage loader
#
# PACKAGE:
#   app_athena/shared(n) -- Master package for athena(1) shared code.
#
# PROJECT:
#   Athena S&RO Simulation
#
# AUTHOR:
#    Will Duquette
#
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Namespace definition
#
# Because this is an application package, the namespace is mostly
# unused.

namespace eval ::app_athena_shared:: {
    variable library [file dirname [info script]]
}

#-----------------------------------------------------------------------
# Load app_athena_shared(n) modules

# FIRST, load modules that must be defined before the rest.
source [file join $::app_athena_shared::library field_types.tcl        ]

# NEXT, define the remaining modules in alphabetical order.

source [file join $::app_athena_shared::library aam.tcl                ]
source [file join $::app_athena_shared::library appserver.tcl          ]
source [file join $::app_athena_shared::library appserver_actor.tcl    ]
source [file join $::app_athena_shared::library appserver_agent.tcl    ]
source [file join $::app_athena_shared::library appserver_bean.tcl     ]
source [file join $::app_athena_shared::library appserver_cap.tcl      ]
source [file join $::app_athena_shared::library appserver_contribs.tcl ]
source [file join $::app_athena_shared::library appserver_curses.tcl   ]
source [file join $::app_athena_shared::library appserver_docs.tcl     ]
source [file join $::app_athena_shared::library appserver_drivers.tcl  ]
source [file join $::app_athena_shared::library appserver_econ.tcl     ]
source [file join $::app_athena_shared::library appserver_enums.tcl    ]
source [file join $::app_athena_shared::library appserver_firing.tcl   ]
source [file join $::app_athena_shared::library appserver_group.tcl    ]
source [file join $::app_athena_shared::library appserver_home.tcl     ]
source [file join $::app_athena_shared::library appserver_hook.tcl     ]
source [file join $::app_athena_shared::library appserver_image.tcl    ]
source [file join $::app_athena_shared::library appserver_iom.tcl      ]
source [file join $::app_athena_shared::library appserver_mads.tcl     ]
source [file join $::app_athena_shared::library appserver_marsdocs.tcl ]
source [file join $::app_athena_shared::library appserver_nbhood.tcl   ]
source [file join $::app_athena_shared::library appserver_objects.tcl  ]
source [file join $::app_athena_shared::library appserver_overview.tcl ]
source [file join $::app_athena_shared::library appserver_parmdb.tcl   ]
source [file join $::app_athena_shared::library appserver_plant.tcl    ]
source [file join $::app_athena_shared::library appserver_plot.tcl     ]
source [file join $::app_athena_shared::library appserver_sanity.tcl   ]
source [file join $::app_athena_shared::library appserver_sigevents.tcl]
source [file join $::app_athena_shared::library appserver_bsystems.tcl ]
source [file join $::app_athena_shared::library appserver_topics.tcl   ]
source [file join $::app_athena_shared::library apptypes.tcl           ]
source [file join $::app_athena_shared::library autogen.tcl            ]
source [file join $::app_athena_shared::library control_model.tcl      ]
source [file join $::app_athena_shared::library coverage_model.tcl     ]
source [file join $::app_athena_shared::library dam.tcl                ]
source [file join $::app_athena_shared::library driver.tcl             ]
source [file join $::app_athena_shared::library driver_abservice.tcl   ]
source [file join $::app_athena_shared::library driver_consump.tcl     ]
source [file join $::app_athena_shared::library driver_control.tcl     ]
source [file join $::app_athena_shared::library driver_curse.tcl       ]
source [file join $::app_athena_shared::library driver_eni.tcl         ]
source [file join $::app_athena_shared::library driver_iom.tcl         ]
source [file join $::app_athena_shared::library driver_magic.tcl       ]
source [file join $::app_athena_shared::library driver_mood.tcl        ]
source [file join $::app_athena_shared::library driver_unemp.tcl       ]
source [file join $::app_athena_shared::library executive.tcl          ]
source [file join $::app_athena_shared::library exporter.tcl           ]
source [file join $::app_athena_shared::library gofer_helpers.tcl      ]
source [file join $::app_athena_shared::library gofer_actors.tcl       ]
source [file join $::app_athena_shared::library gofer_civgroups.tcl    ]
source [file join $::app_athena_shared::library gofer_frcgroups.tcl    ]
source [file join $::app_athena_shared::library gofer_groups.tcl       ]
source [file join $::app_athena_shared::library gofer_nbhoods.tcl      ]
source [file join $::app_athena_shared::library gofer_number.tcl       ]
source [file join $::app_athena_shared::library gradient.tcl           ]
source [file join $::app_athena_shared::library helpers.tcl            ]
source [file join $::app_athena_shared::library hist.tcl               ]
source [file join $::app_athena_shared::library link.tcl               ]
source [file join $::app_athena_shared::library mad.tcl                ]
source [file join $::app_athena_shared::library nbstat.tcl             ]
source [file join $::app_athena_shared::library parm.tcl               ]
source [file join $::app_athena_shared::library payload.tcl            ]
source [file join $::app_athena_shared::library payload_coop.tcl       ]
source [file join $::app_athena_shared::library payload_hrel.tcl       ]
source [file join $::app_athena_shared::library payload_sat.tcl        ]
source [file join $::app_athena_shared::library payload_vrel.tcl       ]
source [file join $::app_athena_shared::library plant.tcl              ]
source [file join $::app_athena_shared::library ptype.tcl              ]
source [file join $::app_athena_shared::library rebase.tcl             ]
source [file join $::app_athena_shared::library security_model.tcl     ]
source [file join $::app_athena_shared::library service.tcl            ]
source [file join $::app_athena_shared::library service_eni.tcl        ]
source [file join $::app_athena_shared::library service_ais.tcl        ]
source [file join $::app_athena_shared::library view.tcl               ]

