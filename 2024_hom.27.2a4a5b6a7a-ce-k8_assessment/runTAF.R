# Script information ------------------------------------------------------

# run TAF analysis for western horse mackerel (WGWIDE)



# Date: 2024


# Load packages -----------------------------------------------------------

library(icesTAF)


# Clean (if needed) -------------------------------------------------------

# clean the TAF directories (all except bootstrap/initial):
#clean()

# Run the TAF analysis ----------------------------------------------------

# once the files bootstrap.R, data.R, model.R and report.R have been created (in that order)
# the whole TAF analysis can be run

# run step by step

sourceTAF("bootstrap")
sourceTAF("data")
sourceTAF("model")
sourceTAF("output")
sourceTAF("report")

# run in a go: utilities.R, data.R, model.R, output.R, and report.R.
# note that bootstrap.R is not run

sourceAll()


# End of script -----------------------------------------------------------


