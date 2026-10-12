# Script information ------------------------------------------------------

# generate outputs from retrospective analysis for WHM (WGWIDE)

# Authors: Rosana Ourens
# Date: Aug 2024

# load libraries ----------------------------------------------------------

library(icesTAF)
library(r4ss)
library(ss3diags)

############## Directories
wd<-getwd()
run_dir <- paste0(wd,"/model/run")
plotretro_dir <- paste0(wd,"/output/plots/diagnosis/retro")


#******************************************
##### Retros 
#*********************************************

retroModels <- SSgetoutput(dirvec=file.path(run_dir, "retrospectives",paste("retro",+0:-5, sep="")))


# Summarize output
retroSummary <- SSsummarize(retroModels)
# Set the ending year of each model in the set
endyrvec <- retroSummary$endyrs + 0:-5
SSplotComparisons(retroSummary,print=T,
                  endyrvec = endyrvec,
                  legendlabels = paste("Data", 0:-5, "years"),plotdir=plotretro_dir)


sspar(mfrow=c(2,2),plot.cex = 0.9)
SSplotRetro(retroSummary,forecastrho = T,add=T,subplots="SSB", endyrvec=2024:2019)
SSplotRetro(retroSummary,forecastrho = T,add=T,legend = F,xmin=2013, endyrvec=2024:2019)
SSplotRetro(retroSummary, subplots = "F",add=T,legendloc = "left",legendcex = 0.8,endyrvec=2023:2018)
SSplotRetro(retroSummary,subplots = "F", xmin=2013,forecastrho = T,add=T,legend = F,endyrvec=2023:2018)

dev.print(jpeg,paste0(plotretro_dir,"/Retros.jpg"), width = 9, height = 5, res = 300, units = "in")

# Do Hindcast with Cross-Validation of CPUE observations
sspar(mfrow=c(2,2),plot.cex = 0.9)
SSplotHCxval(retroSummary,xmin=2006,add=T,legendcex = 0.6)
dev.print(jpeg,paste0(wd,"/output/plots/diagnosis/MASE.jpg"), width = 8, height = 5, res = 300, units = "in")


#****************************************
# Basic Residual Diags
#****************************************
# Reference run
ss3rep = retroModels[[1]]

# Check Runs Test and Joint residuals option for mean composition data
sspar(mfrow=c(2,2),plot.cex = 0.8)

# For surveys
SSplotRunstest(ss3rep,subplots="cpue",add=T,legendcex = 0.6)
dev.print(jpeg,paste0(wd,"/output/plots/diagnosis/Residuals-Surveys.jpg"), width = 8, height = 7, res = 300, units = "in")

# For age
sspar(mfrow=c(1,1),plot.cex = 0.8)

#SSplotRunstest(ss3rep,subplots="len",add=T,legendcex = 0.6)
SSplotRunstest(ss3rep,subplots="age",add=T,legendcex = 0.6)
dev.print(jpeg,paste0(wd,"/output/plots/diagnosis/Residuals-age.jpg"), width = 8, height = 7, res = 300, units = "in")

# Check conflict between indices and mean age
###RMSE < 30% indicates no apparent conflict between data sources

sspar(mfrow=c(1,2),plot.cex = 0.8)
SSplotJABBAres(ss3rep,subplots="cpue",add=T,col=sscol(3)[c(1,3,2)])
#SSplotJABBAres(ss3rep,subplots="len",add=T,col=sscol(3)[c(1,3,2)])
SSplotJABBAres(ss3rep,subplots="age",add=T,col=sscol(3)[c(1,3,2)])

dev.print(jpeg,paste0(wd,"/output/plots/diagnosis/JointResiduals.jpg"), width = 8, height = 3.5, res = 300, units = "in")



sessionInfo()

# End of script -----------------------------------------------------------

rm(list = ls())

