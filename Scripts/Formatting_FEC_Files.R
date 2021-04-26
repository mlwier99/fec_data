library(stringi)
library(RCurl)
library(curl)
library(fs)
library(stringr)
getwd()
list.files()
setwd("/home/michelle/sdc1/FEC/")
setwd("/run/media/sean/Samsung USB/FEC/")
setwd("/home/michelle/sdb1/FEC/")
file_types <- c("Individual_Contributions","Candidate_Master","All_Candidates",
                "Congress_Current_Campaigns","Committee_Master","PAC_Summary",
                "Operating_Expenditures","Candidate_Committee_Links",
                "From_Committee_Contributions","Intercommittee_Transactions")
year <- as.integer(seq.int(from = 1980, to = 2020, by = 2))
year_suffix <- as.character(stri_reverse(substr(stri_reverse(year),0,2)))
file_prefix <- c("indiv", "weball", "cn", "cm", "cc", "ccl", "webl", "oth",
                 "webk","pas2","oppexp")

############################ File Specifications ##############################
#Creating log files in .txt; can be opened in Excel with | deliminater
file.create("./Log_Files/fec_formatting.txt")
log <- "./Log_Files/fec_formatting.txt"
write(c("File", "Prefix", "Year", "Output", "Date", "Time"),
      file=log, sep="\t", append=T,ncolumns = 9)

########################### Writing to Data Frames #############################

files_done <- c()

for(i in 1:length(file_prefix)){
  if(file_prefix[i]=="indiv"){file_type <- "Individual_Contributions"}
  if(file_prefix[i]=="weball"){file_type <-  "All_Candidates"}
  if(file_prefix[i]=="webl"){file_type <- "House_Senate_Current_Campaigns"}
  if(file_prefix[i]=="webk"){file_type <- "PAC_Summary"}
  if(file_prefix[i]=="cn"){file_type <- "Candidate_Master"}
  if(file_prefix[i]=="cm"){file_type <- "Committee_Master"}
  if(file_prefix[i]=="oth"){file_type <- "Intercommittee_Transactions"}
  if(file_prefix[i]=="ccl"){file_type <- "Candidate_Committee_Links"}
  if(file_prefix[i]=="cc"){file_type <- "Individual Contributions"}
  if(file_prefix[i]=="oppexp"){file_type <- "Operating_Expenditures"}
  if(file_prefix[i]=="pas2"){file_type <- "From_Committee_Contributions"}
  for(y in seq(year)){
    path <- paste0("./Data/data_r/",file_type)
    files_done <- c(files_done, list.files(path, all.files = F, full.names = F, 
                                           pattern = ".RData") )
  } 
}
for(j in seq(files_done)){
  files_done <- str_replace_all(files_done, ".RData", "")
}
    
for(i in seq(file_prefix)){
  if(file_prefix[i]=="indiv"){file_type <- "Individual_Contributions"}
  if(file_prefix[i]=="weball"){file_type <-  "All_Candidates"}
  if(file_prefix[i]=="webl"){file_type <- "House_Senate_Current_Campaigns"}
  if(file_prefix[i]=="webk"){file_type <- "PAC_Summary"}
  if(file_prefix[i]=="cn"){file_type <- "Candidate_Master"}
  if(file_prefix[i]=="cm"){file_type <- "Committee_Master"}
  if(file_prefix[i]=="oth"){file_type <- "Intercommittee_Transactions"}
  if(file_prefix[i]=="ccl"){file_type <- "Candidate_Committee_Links"}
  if(file_prefix[i]=="cc"){file_type <- "Individual Contributions"}
  if(file_prefix[i]=="oppexp"){file_type <- "Operating_Expenditures"}
  if(file_prefix[i]=="pas2"){file_type <- "From_Committee_Contributions"}
  for(y in seq(year)){
    start_time <- format(Sys.time(), "%X")
    start_date <- format(Sys.time(), "%x")
    write(c(file_type, file_prefix[i],year[y],"Start", 
            format(Sys.time(), "%x"), format(Sys.time(), "%X")),
          file=log,  sep="\t", append=T, ncolumns=9)
    if(paste0(file_prefix[i],"_",year[y])%in%files_done){
      print(paste0(file_prefix[i],year[y]," already done."))
      write(c(file_type, file_prefix[i], year[y], print("Already done."),
              format(Sys.time(), "%x"), format(Sys.time(), "%X")),
            file=log, sep="\t", append=T, ncolumns = 9)
      next}
    if(!paste0(file_prefix[i],"_",year[y])%in%files_done){
      print(paste0(file_prefix[i],year[y]," starting."))
      write(c(file_type, file_prefix[i], year[y], print("Already done."),
              format(Sys.time(), "%x"), format(Sys.time(), "%X")),
            file=log, sep="\t", append=T, ncolumns = 9)
      next}
    file_raw <- paste0("./Data/data_raw/",file_type,"/",file_prefix[i],"_",year[y])
    tryCatch(
      expr = {
        assign(paste0(file_prefix[i],"_",year[y],"_df"),
               read.table(file=paste0(file_raw,".txt"), sep="|", quote="", comment.char=""))
        df <- read.table(file=paste0(file_raw,".txt"), sep="|", quote="", comment.char="")
        if (dim(df)[1] == 0) {
          write(c(file_type, file_prefix[i], year[y], print("Empty dataframe."),
                  format(Sys.time(), "%x"), format(Sys.time(), "%X")),
                file=log, sep="\t", append=T, ncolumns = 9)
        }
        if (dim(df)[1] != 0) {
          save(df, file = paste0("./Data/data_r/",file_type,"/",
                                 file_prefix[i],"_",year[y],".RData"))
          write(c(file_type, file_prefix[i],year[y], "Done", format(Sys.time(), "%x"), 
                  format(Sys.time(), "%X")),file=log,  sep="\t", append=T, ncolumns=9)
        }
      },
      error = function(e){
        write(c(file_type, file_prefix[i],year[y], toString(e),
                format(Sys.time(), "%x"), format(Sys.time(), "%X")),
              file=log,  sep="\t", append=T, ncolumns=9)
      },
      warning = function(w){
        write(c(file_type, file_prefix[i],year[y], toString(w), 
              format(Sys.time(), "%x"), format(Sys.time(), "%X")), 
	file=log,  sep="\t", append=T, ncolumns=9)
      },
      finally = {
      }
    )
  }
}



########################### Header to Data Frames #############################

for(i in seq(file_prefix)){
  if(file_prefix[i]=="indiv"){file_type <- "Individual_Contributions"}
  if(file_prefix[i]=="weball"){file_type <-  "All_Candidates"}
  if(file_prefix[i]=="webl"){file_type <- "House_Senate_Current_Campaigns"}
  if(file_prefix[i]=="webk"){file_type <- "PAC_Summary"}
  if(file_prefix[i]=="cn"){file_type <- "Candidate_Master"}
  if(file_prefix[i]=="cm"){file_type <- "Committee_Master"}
  if(file_prefix[i]=="oth"){file_type <- "Intercommittee_Transactions"}
  if(file_prefix[i]=="ccl"){file_type <- "Candidate_Committee_Links"}
  if(file_prefix[i]=="cc"){file_type <- "Individual Contributions"}
  if(file_prefix[i]=="oppexp"){file_type <- "Operating_Expenditures"}
  if(file_prefix[i]=="pas2"){file_type <- "From_Committee_Contributions"}
  
  write(c(file_type, file_prefix[i],"Header","Start", 
          format(Sys.time(), "%x"), format(Sys.time(), "%X")),
        file=log,  sep="\t", append=T, ncolumns=9)
  file_raw <- paste0("./Data/data_raw/",file_type,"/",file_prefix[i],"_header.csv")
    tryCatch(
      expr = {
        assign(paste0(file_prefix[i],"_header_df"),
               read.table(file=paste0(file_raw,".csv"), sep="|", quote="", comment.char=""))
        df <- read.table(file=paste0(file_raw,".csv"), sep="|", quote="", comment.char="")
        if (dim(df)[1] == 0) {
          write(c(file_type, file_prefix[i], "Header", print("No header."),
                  format(Sys.time(), "%x"), format(Sys.time(), "%X")),
                file=log, sep="\t", append=T, ncolumns = 9)
        }
        if (dim(df)[1] != 0) {
          save(df, file = paste0("./Data/data_r/",file_type,"/",
                                 file_prefix[i],"_header.RData"))
          write(c(file_type, file_prefix[i],"Header", "Done", format(Sys.time(), "%x"), 
                  format(Sys.time(), "%X")),file=log,  sep="\t", append=T, ncolumns=9)
        }
      },
      error = function(e){
        write(c(file_type, file_prefix[i],"Header", toString(e),
                format(Sys.time(), "%x"), format(Sys.time(), "%X")),
              file=log,  sep="\t", append=T, ncolumns=9)
      },
      warning = function(w){
        write(c(file_type, file_prefix[i],"Header", toString(w), 
                format(Sys.time(), "%x"), format(Sys.time(), "%X")), 
              file=log,  sep="\t", append=T, ncolumns=9)
      },
      finally = {
      }
    )
  }
}





