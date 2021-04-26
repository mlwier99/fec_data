library(stringi)
library(RCurl)
library(curl)
library(fs)

getwd()
list.files()
setwd("/home/michelle/sdb1/FEC/") 
setwd("/run/media/sean/mwier/FEC/")


file_types <- c("Individual_Contributions","Candidate_Master","All_Candidates",
                "Congress_Current_Campaigns","Committee_Master","PAC_Summary",
                "Operating_Expenditures","Candidate_Committee_Links",
                "From_Committee_Contributions","Intercommittee_Transactions")

for(i in 1:length(file_types)){
  if(dir.exists(paste0("./Data/data_zipped/",file_types[i]))==FALSE){
    dir.create(paste0("./Data/data_zipped/",file_types[i]),recursive=T)
  }
  if(dir.exists(paste0("./Data/data_r/",file_types[i]))==FALSE){
    dir.create(paste0("./Data/data_r/",file_types[i]),recursive=T)
  }
  if(dir.exists(paste0("./Data/data_raw/",file_types[i]))==FALSE){
    dir.create(paste0("./Data/data_raw/",file_types[i]),recursive=T)
  }
}


year <- as.integer(seq.int(from = 1980, to = 2020, by = 2))
year_suffix <- as.character(stri_reverse(substr(stri_reverse(year),0,2)))
url_prefix <- c("indiv","weball", "cn", "cm", "cc", "ccl", "webl", "oth", 
                "webk","pas2","oppexp", "pass")
url_base = "https://www.fec.gov/files/bulk-downloads/"
dest_base = "./Data/data_zipped/"

################################## Data Files ################################## 

if(file.exists("Log_Files/fec_download_output.txt")==T){
  write(c("Status", "URL_Prefix", "Year", "Year_Suffix", "Time"), 
      file = "Log_Files/fec_download_output_temp.txt", 
      sep="\t", append=F, ncolumns=5)
  write(c("Rerun", "Rerun", "Rerun", "Rerun", "Rerun"), 
        file = "Log_Files/fec_download_output.txt", 
        sep="\t", append=T, ncolumns=6)
}
if(file.exists("Log_Files/fec_download_output.txt")==F){
  write(c("Status", "URL_Prefix", "Year", "Year_Suffix", "Time"), 
        file = "Log_Files/fec_download_output.txt", 
        sep="\t", append=F, ncolumns=6)
}

for(u in 1:length(url_prefix)){
  for(i in 1:length(year)){
    for(j in 1:length(year_suffix)){
      full_url <- paste0(url_base, year[i], "/", url_prefix[u],
                         year_suffix[j], ".zip")
      if(url_prefix[u]=="indiv"){
        dest_file <- paste0(dest_base, "/Individual Contributions/", 
                            url_prefix[u], "_", year[i], ".zip")
      }
      if(url_prefix[u]=="weball"){
        dest_file <- paste0(dest_base, "/All_Candidates/", 
                            url_prefix[u], "_", year[i], ".zip")
      }
      if(url_prefix[u]=="webl"){
        dest_file <- paste0(dest_base, "/House_Senate_Current_Campaigns/", 
                            url_prefix[u], "_", year[i], ".zip")
      }
      if(url_prefix[u]=="webk"){
        dest_file <- paste0(dest_base, "/PAC_Summary/", 
                            url_prefix[u], "_", year[i], ".zip")
      }
      if(url_prefix[u]=="cn"){
        dest_file <- paste0(dest_base, "/Candidate_Master/", 
                            url_prefix[u], "_", year[i], ".zip")
      }
      if(url_prefix[u]=="cm"){
        dest_file <- paste0(dest_base, "/Committee_Master/", 
                            url_prefix[u], "_", year[i], ".zip")
      }
      if(url_prefix[u]=="oth"){
        dest_file <- paste0(dest_base, "/Intercommittee_Transactions/", 
                            url_prefix[u], "_", year[i], ".zip")
      }
      if(url_prefix[u]=="ccl"){
        dest_file <- paste0(dest_base, "/Candidate_Committee_Links/", 
                            url_prefix[u], "_", year[i], ".zip")
      }
      if(url_prefix[u]=="cc"){
        dest_file <- paste0(dest_base, "/Individual Contributions/", 
                            url_prefix[u], "_", year[i], ".zip")
      }
      if(url_prefix[u]=="oppexp"){
        dest_file <- paste0(dest_base, "/Operating_Expenditures/", 
                            url_prefix[u], "_", year[i], ".zip")
      }
      if(url_prefix[u]=="pas2"){
        dest_file <- paste0(dest_base, "/From_Committee_Contributions/", 
                            url_prefix[u], "_", year[i], ".zip")
      }
      if(url.exists(full_url)==T){
        download.file(url = full_url, destfile = dest_file, mode = "w")
        write(c("Success", url_prefix[u], year[i], year_suffix[j], Sys.time()), 
              file = "Scripts/Log_Files/fec_download_output.txt",
              sep="\t", append=T, ncolumns=4)
      }
      if(url.exists(full_url)==F){
      write(c("Fail", url_prefix[u], year[i], year_suffix[j]), Sys.time(), 
            file = "Log_Files/fec_download_output.txt", 
            sep="\t", append=T, ncolumns=4)
    }
    }
  }
}

################################ Header Files ################################## 

header_base <- c("https://www.fec.gov/files/bulk-downloads/data_dictionaries/")
header_end <- c("_header_file.csv")
       
for(u in 1:length(url_prefix)){
  head_url <- paste0("https://www.fec.gov/files/bulk-downloads/data_dictionaries/"
                     , url_prefix[u], "_header_file.csv") 
  if(url_prefix[u]=="indiv"){dest_file <- paste0(dest_base, "/Individual Contributions/", url_prefix[u], "_header.csv")}
  if(url_prefix[u]=="weball"){dest_file <- paste0(dest_base, "/All_Candidates/", url_prefix[u], "_header.csv")}
  if(url_prefix[u]=="webl"){dest_file <- paste0(dest_base, "/House_Senate_Current_Campaigns/", url_prefix[u], "_header.csv")}
  if(url_prefix[u]=="webk"){dest_file <- paste0(dest_base, "/PAC_Summary/", url_prefix[u], "_header.csv")}
  if(url_prefix[u]=="cn"){dest_file <- paste0(dest_base, "/Candidate_Master/", url_prefix[u], "_header.csv")}
  if(url_prefix[u]=="cm"){dest_file <- paste0(dest_base, "/Committee_Master/", url_prefix[u], "_header.csv")}
  if(url_prefix[u]=="oth"){dest_file <- paste0(dest_base, "/Intercommittee_Transactions/", url_prefix[u], "_header.csv")}
  if(url_prefix[u]=="ccl"){dest_file <- paste0(dest_base, "/Candidate_Committee_Links/", url_prefix[u], "_header.csv")}
  if(url_prefix[u]=="cc"){dest_file <- paste0(dest_base, "/Individual Contributions/", url_prefix[u], "_header.csv")}
  if(url_prefix[u]=="oppexp"){dest_file <- paste0(dest_base, "/Operating_Expenditures/", url_prefix[u], "_header.csv")}
  if(url_prefix[u]=="pas2"){dest_file <- paste0(dest_base, "/From_Committee_Contributions/", url_prefix[u], "_header.csv")}
  
  if(url.exists(head_url)){download.file(url = head_url, destfile = dest_file, mode = "w")}
  
  if(url.exists(head_url)==T){
    download.file(url = head_url, destfile = dest_file, mode = "w")
    write(c("Success", url_prefix[u], "Header", "Header", Sys.time(), 
            file = "Scripts/Log_Files/fec_download_output.txt", 
            sep="\t", append=T, ncolumns=5))
  }
  if(url.exists(head_url)==F){
    write(c("Fail", url_prefix[u], "Header", "Header", Sys.time(), 
          file = "Scripts/Log_Files/fec_download_output.txt", 
          sep="\t", append=T, ncolumns=5))
  }
}

############################### Unzipping Files ################################

if(file.exists("Log_Files/fec_unzip_output.txt")==T){
  write(c("Rerun", "Rerun", "Rerun"), 
        file = "Log_Files/fec_unzip_output.txt", 
        sep="\t", append=T, ncolumns=3)
}
#if(file.exists("Log_Files/fec_unzip_output.txt")==F){
  write(c("Status", "Time", "Error"), 
        file = "Log_Files/fec_unzip_output.txt", 
        sep="\t", append=F, ncolumns=3)
#}
write(c("Script Start", format(Sys.time(), "%X"),
        format(Sys.Date(), "%a, %F")), 
      file = "Log_Files/fec_unzip_output.txt", 
      sep="\t", append=T, ncolumns=3)

for(i in seq(file_types)){
tryCatch(
  expr = {
    system("bash ./Scripts/Unzipping_FEC_Files.sh")
    #file_list <- list.files(path = paste0("Data/data_zipped/",file_types[i],"/"), 
    #                        pattern = "*.zip", full.names = T)
    #unzip_file_dir <- paste0("Data/data_raw/",file_types[i])
    #plyr::ldply(.data = file_list, .fun = unzip, exdir = unzip_file_dir)

  }, 
  error = function(e){
    write(c("Error", format(Sys.time(), "%X"), toString(e)), 
          file = "Log_Files/fec_unzip_output.txt", 
          sep="\t", append=T, ncolumns=3)
  },
  warning = function(w){
    write(c("Warning", format(Sys.time(), "%X"), toString(w)), 
          file = "Log_Files/fec_unzip_output.txt", 
          sep="\t", append=T, ncolumns=3)
  },
  finally = {
    write(c("Unzipped", format(Sys.time(), "%X"), file_types[i]), 
          file = "Log_Files/fec_unzip_output.txt", 
          sep="\t", append=T, ncolumns=3)
  }
)  
}

write(c("Script End", format(Sys.time(), "%X"),
        format(Sys.Date(), "%a, %F")), 
      file = "Log_Files/fec_unzip_output.txt", 
      sep="\t", append=T, ncolumns=3)
file.show("Log_Files/fec_unzip_output.txt")

################################### Raw URLs ###################################

#Individual: 
  #https://www.fec.gov/files/bulk-downloads/2020/indiv20.zip
  #https://www.fec.gov/files/bulk-downloads/1980/indiv80.zip
  #https://www.fec.gov/files/bulk-downloads/data_dictionaries/indiv_header_file.csv

#All Candidates: 
  #https://www.fec.gov/files/bulk-downloads/2020/weball20.zip
  #https://www.fec.gov/files/bulk-downloads/1980/weball80.zip

#Candidate Master: 
  #https://www.fec.gov/files/bulk-downloads/2020/cn20.zip
  #https://www.fec.gov/files/bulk-downloads/1980/cn80.zip

#Candidate-Committee Linkages: 
  #https://www.fec.gov/files/bulk-downloads/2020/ccl20.zip
  #https://www.fec.gov/files/bulk-downloads/2000/ccl00.zip
  
#Commitee Master: 
  #https://www.fec.gov/files/bulk-downloads/1980/cm80.zip
  #https://www.fec.gov/files/bulk-downloads/2020/cm20.zip
  
#Contributions from committees to candidates & independent expenditures 
  #https://www.fec.gov/files/bulk-downloads/2020/pas220.zip
  #https://www.fec.gov/files/bulk-downloads/1980/oth80.zip
  #https://www.fec.gov/files/bulk-downloads/data_dictionaries/pas2_header_file.csv
  
#Transactions from one committee to another: 
  #https://www.fec.gov/files/bulk-downloads/2020/oth20.zip
  #https://www.fec.gov/files/bulk-downloads/data_dictionaries/oth_header_file.csv
  #https://www.fec.gov/files/bulk-downloads/1980/oth80.zip

#Operating Expenditures 
  #https://www.fec.gov/files/bulk-downloads/2020/oppexp20.zip
  #https://www.fec.gov/files/bulk-downloads/2004/oppexp04.zip
  #https://www.fec.gov/files/bulk-downloads/data_dictionaries/oppexp_header_file.csv
