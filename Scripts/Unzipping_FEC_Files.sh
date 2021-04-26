#!/bin/bas

cd "/run/media/sean/mwier/FEC/"
cd "/home/michelle/sdb1/FEC/"
#All States
FileArray=("Individual_Contributions" 
            "Candidate_Master"
            "All_Candidates"
            "Congress_Current_Campaigns"
            "Committee_Master"
            "PAC_Summary"
            "Operating_Expenditures" 
            "Candidate_Committee_Links"
            "From_Committee_Contributions"
            "Intercommittee_Transactions")

echo "Creating directories in /Data/data_raw to place unzipped files."
for val in ${FileArray[@]}
do 
  mkdir -p Data/data_raw/$val
done 

for val in ${FileArray[@]}
do 
  cp Data/data_zipped/$val/*csv -t Data/data_raw/$val
done

strings -t d Data/data_zipped/Individual_Contributions/indiv_1982.zip | \
grep '^\s\+[[:digit:]]\+\sAAAAA-\w\+\.txt' | \
sed 's/^\s\+\([[:digit:]]\+\)\s\(AAAAA\)\(-\w\+\.txt\).*$/\1 \2\3 BBBBB\3/g' | \
while read -a line; do
  line_nbr=${line[0]};
  fname= itcont.txt; 
  new_name=indv_1982; 
  len=${#fname};
    printf "line: "$line_nbr"\nfile: "$fname"\nnew_name: "$new_name"\nlen: "$len"\n";
  dd if=<(printf $new_name"\n") of bs=1 seek=$line_nbr count=$len conv=notrunc  
done;

zipnote Data/data_zipped/Individual_Contributions/indiv_1982.zip > comments.txt


#Only run once after download 
#for archive in /home/michelle/sdb1/FEC/Data/data_zipped/Individual_Contributions/*/*.zip
#do
#  echo "Archive = ${archive}, Preview = ${archive%/*}/preview.zip"
#done
for val in ${FileArray[@]}
do 
unzip -n /home/michelle/sdb1/FEC/Data/data_zipped/$val/\*.zip -d /home/michelle/sdb1/FEC/Data/data_raw/$val
done 
#find ./Data/data_zipped/$val/\* -exec unzip -nv {} -d Data/data_raw/$val/ \;

FileArray=("Individual_Contributions" 
            "Candidate_Master"
            "All_Candidates"
            "Congress_Current_Campaigns"
            "Committee_Master"
            "PAC_Summary"
            "Operating_Expenditures" 
            "Candidate_Committee_Links"
            "From_Committee_Contributions"
            "Intercommittee_Transactions")

cd "/home/michelle/sdb1/FEC/Data/data_zipped/Intercommittee_Transactions/"
printf "@ itoth.txt\n@=oth_2020.txt\n" | zipnote -w oth_2020.zip
printf "@ itoth.txt\n@=oth_2018.txt\n" | zipnote -w oth_2018.zip
printf "@ itoth.txt\n@=oth_2016.txt\n" | zipnote -w oth_2016.zip
printf "@ itoth.txt\n@=oth_2014.txt\n" | zipnote -w oth_2014.zip
printf "@ itoth.txt\n@=oth_2012.txt\n" | zipnote -w oth_2012.zip
printf "@ itoth.txt\n@=oth_2010.txt\n" | zipnote -w oth_2010.zip
printf "@ itoth.txt\n@=oth_2008.txt\n" | zipnote -w oth_2008.zip
printf "@ itoth.txt\n@=oth_2006.txt\n" | zipnote -w oth_2006.zip
printf "@ itoth.txt\n@=oth_2004.txt\n" | zipnote -w oth_2004.zip
printf "@ itoth.txt\n@=oth_2002.txt\n" | zipnote -w oth_2002.zip
printf "@ itoth.txt\n@=oth_2000.txt\n" | zipnote -w  oth_2000.zip
printf "@ itoth.txt\n@=oth_1980.txt\n" | zipnote -w  oth_1980.zip
printf "@ itoth.txt\n@=oth_1982.txt\n" | zipnote -w  oth_1982.zip
printf "@ itoth.txt\n@=oth_1984.txt\n" | zipnote -w  oth_1984.zip
printf "@ itoth.txt\n@=oth_1986.txt\n" | zipnote -w  oth_1986.zip
printf "@ itoth.txt\n@=oth_1988.txt\n" | zipnote -w  oth_1988.zip
printf "@ itoth.txt\n@=oth_1990.txt\n" | zipnote -w  oth_1990.zip
printf "@ itoth.txt\n@=oth_1992.txt\n" | zipnote -w  oth_1992.zip
printf "@ itoth.txt\n@=oth_1994.txt\n" | zipnote -w  oth_1994.zip
printf "@ itoth.txt\n@=oth_1996.txt\n" | zipnote -w  oth_1996.zip
printf "@ itoth.txt\n@=oth_1998.txt\n" | zipnote -w  oth_1998.zip

cd /home/michelle/sdb1/FEC/Data/data_zipped/Operating_Expenditures/
printf "@ oppexp.txt\n@=oppexp_2020.txt\n" | zipnote -w oppexp_2020.zip
printf "@ oppexp.txt\n@=oppexp_2018.txt\n" | zipnote -w oppexp_2018.zip
printf "@ oppexp.txt\n@=oppexp_2016.txt\n" | zipnote -w oppexp_2016.zip
printf "@ oppexp.txt\n@=oppexp_2014.txt\n" | zipnote -w oppexp_2014.zip
printf "@ oppexp.txt\n@=oppexp_2012.txt\n" | zipnote -w oppexp_2012.zip
printf "@ oppexp.txt\n@=oppexp_2010.txt\n" | zipnote -w oppexp_2010.zip
printf "@ oppexp.txt\n@=oppexp_2008.txt\n" | zipnote -w oppexp_2008.zip
printf "@ oppexp.txt\n@=oppexp_2006.txt\n" | zipnote -w oppexp_2006.zip
printf "@ oppexp.txt\n@=oppexp_2004.txt\n" | zipnote -w oppexp_2004.zip
printf "@ oppexp.txt\n@=oppexp_2002.txt\n" | zipnote -w oppexp_2002.zip
printf "@ oppexp.txt\n@=oppexp_2000.txt\n" | zipnote -w oppexp_2000.zip
printf "@ oppexp.txt\n@=oppexp_1980.txt\n" | zipnote -w oppexp_1980.zip
printf "@ oppexp.txt\n@=oppexp_1982.txt\n" | zipnote -w oppexp_1982.zip
printf "@ oppexp.txt\n@=oppexp_1984.txt\n" | zipnote -w oppexp_1984.zip
printf "@ oppexp.txt\n@=oppexp_1986.txt\n" | zipnote -w oppexp_1986.zip
printf "@ oppexp.txt\n@=oppexp_1988.txt\n" | zipnote -w oppexp_1988.zip
printf "@ oppexp.txt\n@=oppexp_1990.txt\n" | zipnote -w oppexp_1990.zip
printf "@ oppexp.txt\n@=oppexp_1992.txt\n" | zipnote -w oppexp_1992.zip
printf "@ oppexp.txt\n@=oppexp_1994.txt\n" | zipnote -w oppexp_1994.zip
printf "@ oppexp.txt\n@=oppexp_1996.txt\n" | zipnote -w oppexp_1996.zip
printf "@ oppexp.txt\n@=oppexp_1998.txt\n" | zipnote -w oppexp_1998.zip

cd /home/michelle/sdb1/FEC/Data/data_zipped/Candidate_Master/
printf "@ cn.txt\n@=cn_2020.txt\n" | zipnote -w cn_2020.zip
printf "@ cn.txt\n@=cn_2018.txt\n" | zipnote -w cn_2018.zip
printf "@ cn.txt\n@=cn_2016.txt\n" | zipnote -w cn_2016.zip
printf "@ cn.txt\n@=cn_2014.txt\n" | zipnote -w cn_2014.zip
printf "@ cn.txt\n@=cn_2012.txt\n" | zipnote -w cn_2012.zip
printf "@ cn.txt\n@=cn_2010.txt\n" | zipnote -w cn_2010.zip
printf "@ cn.txt\n@=cn_2008.txt\n" | zipnote -w cn_2008.zip
printf "@ cn.txt\n@=cn_2006.txt\n" | zipnote -w cn_2006.zip
printf "@ cn.txt\n@=cn_2004.txt\n" | zipnote -w cn_2004.zip
printf "@ cn.txt\n@=cn_2002.txt\n" | zipnote -w cn_2002.zip
printf "@ cn.txt\n@=cn_2000.txt\n" | zipnote -w cn_2000.zip
printf "@ cn.txt\n@=cn_1980.txt\n" | zipnote -w cn_1980.zip
printf "@ cn.txt\n@=cn_1982.txt\n" | zipnote -w cn_1982.zip
printf "@ cn.txt\n@=cn_1984.txt\n" | zipnote -w cn_1984.zip
printf "@ cn.txt\n@=cn_1986.txt\n" | zipnote -w cn_1986.zip
printf "@ cn.txt\n@=cn_1988.txt\n" | zipnote -w cn_1988.zip
printf "@ cn.txt\n@=cn_1990.txt\n" | zipnote -w cn_1990.zip
printf "@ cn.txt\n@=cn_1992.txt\n" | zipnote -w cn_1992.zip
printf "@ cn.txt\n@=cn_1994.txt\n" | zipnote -w cn_1994.zip
printf "@ cn.txt\n@=cn_1996.txt\n" | zipnote -w cn_1996.zip
printf "@ cn.txt\n@=cn_1998.txt\n" | zipnote -w cn_1998.zip

cd "/home/michelle/sdb1/FEC/Data/data_zipped/From_Committee_Contributions/"
printf "@ itpas2.txt\n@=pas2_2020.txt\n" | zipnote -w pas2_2020.zip
printf "@ itpas2.txt\n@=pas2_2018.txt\n" | zipnote -w pas2_2018.zip
printf "@ itpas2.txt\n@=pas2_2016.txt\n" | zipnote -w pas2_2016.zip
printf "@ itpas2.txt\n@=pas2_2014.txt\n" | zipnote -w pas2_2014.zip
printf "@ itpas2.txt\n@=pas2_2012.txt\n" | zipnote -w pas2_2012.zip
printf "@ itpas2.txt\n@=pas2_2010.txt\n" | zipnote -w pas2_2010.zip
printf "@ itpas2.txt\n@=pas2_2008.txt\n" | zipnote -w pas2_2008.zip
printf "@ itpas2.txt\n@=pas2_2006.txt\n" | zipnote -w pas2_2006.zip
printf "@ itpas2.txt\n@=pas2_2004.txt\n" | zipnote -w pas2_2004.zip
printf "@ itpas2.txt\n@=pas2_2002.txt\n" | zipnote -w pas2_2002.zip
printf "@ itpas2.txt\n@=pas2_2000.txt\n" | zipnote -w pas2_2000.zip
printf "@ itpas2.txt\n@=pas2_1980.txt\n" | zipnote -w pas2_1980.zip
printf "@ itpas2.txt\n@=pas2_1982.txt\n" | zipnote -w pas2_1982.zip
printf "@ itpas2.txt\n@=pas2_1984.txt\n" | zipnote -w pas2_1984.zip
printf "@ itpas2.txt\n@=pas2_1986.txt\n" | zipnote -w pas2_1986.zip
printf "@ itpas2.txt\n@=pas2_1988.txt\n" | zipnote -w pas2_1988.zip
printf "@ itpas2.txt\n@=pas2_1990.txt\n" | zipnote -w pas2_1990.zip
printf "@ itpas2.txt\n@=pas2_1992.txt\n" | zipnote -w pas2_1992.zip
printf "@ itpas2.txt\n@=pas2_1994.txt\n" | zipnote -w pas2_1994.zip
printf "@ itpas2.txt\n@=pas2_1996.txt\n" | zipnote -w pas2_1996.zip
printf "@ itpas2.txt\n@=pas2_1998.txt\n" | zipnote -w pas2_1998.zip

cd /home/michelle/sdb1/FEC/Data/data_zipped/Committee_Master/
printf "@ cm.txt\n@=cm_2020.txt\n" | zipnote -w cm_2020.zip
printf "@ cm.txt\n@=cm_2018.txt\n" | zipnote -w cm_2018.zip
printf "@ cm.txt\n@=cm_2016.txt\n" | zipnote -w cm_2016.zip
printf "@ cm.txt\n@=cm_2014.txt\n" | zipnote -w cm_2014.zip
printf "@ cm.txt\n@=cm_2012.txt\n" | zipnote -w cm_2012.zip
printf "@ cm.txt\n@=cm_2010.txt\n" | zipnote -w cm_2010.zip
printf "@ cm.txt\n@=cm_2008.txt\n" | zipnote -w cm_2008.zip
printf "@ cm.txt\n@=cm_2006.txt\n" | zipnote -w cm_2006.zip
printf "@ cm.txt\n@=cm_2004.txt\n" | zipnote -w cm_2004.zip
printf "@ cm.txt\n@=cm_2002.txt\n" | zipnote -w cm_2002.zip
printf "@ cm.txt\n@=cm_2000.txt\n" | zipnote -w cm_2000.zip
printf "@ cm.txt\n@=cm_1980.txt\n" | zipnote -w cm_1980.zip
printf "@ cm.txt\n@=cm_1982.txt\n" | zipnote -w cm_1982.zip
printf "@ cm.txt\n@=cm_1984.txt\n" | zipnote -w cm_1984.zip
printf "@ cm.txt\n@=cm_1986.txt\n" | zipnote -w cm_1986.zip
printf "@ cm.txt\n@=cm_1988.txt\n" | zipnote -w cm_1988.zip
printf "@ cm.txt\n@=cm_1990.txt\n" | zipnote -w cm_1990.zip
printf "@ cm.txt\n@=cm_1992.txt\n" | zipnote -w cm_1992.zip
printf "@ cm.txt\n@=cm_1994.txt\n" | zipnote -w cm_1994.zip
printf "@ cm.txt\n@=cm_1996.txt\n" | zipnote -w cm_1996.zip
printf "@ cm.txt\n@=cm_1998.txt\n" | zipnote -w cm_1998.zip


cd /home/michelle/sdb1/FEC/Data/data_zipped/Candidate_Committee_Links/
printf "@ ccl.txt\n@=ccl_2020.txt\n" | zipnote -w ccl_2020.zip
printf "@ ccl.txt\n@=ccl_2018.txt\n" | zipnote -w ccl_2018.zip
printf "@ ccl.txt\n@=ccl_2016.txt\n" | zipnote -w ccl_2016.zip
printf "@ ccl.txt\n@=ccl_2014.txt\n" | zipnote -w ccl_2014.zip
printf "@ ccl.txt\n@=ccl_2012.txt\n" | zipnote -w ccl_2012.zip
printf "@ ccl.txt\n@=ccl_2010.txt\n" | zipnote -w ccl_2010.zip
printf "@ ccl.txt\n@=ccl_2008.txt\n" | zipnote -w ccl_2008.zip
printf "@ ccl.txt\n@=ccl_2006.txt\n" | zipnote -w ccl_2006.zip
printf "@ ccl.txt\n@=ccl_2004.txt\n" | zipnote -w ccl_2004.zip
printf "@ ccl.txt\n@=ccl_2002.txt\n" | zipnote -w ccl_2002.zip
printf "@ ccl.txt\n@=ccl_2000.txt\n" | zipnote -w ccl_2000.zip
printf "@ ccl.txt\n@=ccl_1980.txt\n" | zipnote -w ccl_1980.zip
printf "@ ccl.txt\n@=ccl_1982.txt\n" | zipnote -w ccl_1982.zip
printf "@ ccl.txt\n@=ccl_1984.txt\n" | zipnote -w ccl_1984.zip
printf "@ ccl.txt\n@=ccl_1986.txt\n" | zipnote -w ccl_1986.zip
printf "@ ccl.txt\n@=ccl_1988.txt\n" | zipnote -w ccl_1988.zip
printf "@ ccl.txt\n@=ccl_1990.txt\n" | zipnote -w ccl_1990.zip
printf "@ ccl.txt\n@=ccl_1992.txt\n" | zipnote -w ccl_1992.zip
printf "@ ccl.txt\n@=ccl_1994.txt\n" | zipnote -w ccl_1994.zip
printf "@ ccl.txt\n@=ccl_1996.txt\n" | zipnote -w ccl_1996.zip
printf "@ ccl.txt\n@=ccl_1998.txt\n" | zipnote -w ccl_1998.zip

cd /home/michelle/sdb1/FEC/Data/data_zipped/Individual_Contributions/
printf "@ itcont.txt\n@=indiv_2020.txt\n" | zipnote -w indiv_2020.zip
printf "@ itcont.txt\n@=indiv_2018.txt\n" | zipnote -w indiv_2018.zip
printf "@ itcont.txt\n@=indiv_2016.txt\n" | zipnote -w indiv_2016.zip
printf "@ itcont.txt\n@=indiv_2014.txt\n" | zipnote -w indiv_2014.zip
printf "@ itcont.txt\n@=indiv_2012.txt\n" | zipnote -w indiv_2012.zip
printf "@ itcont.txt\n@=indiv_2010.txt\n" | zipnote -w indiv_2010.zip
printf "@ itcont.txt\n@=indiv_2008.txt\n" | zipnote -w indiv_2008.zip
printf "@ itcont.txt\n@=indiv_2006.txt\n" | zipnote -w indiv_2006.zip
printf "@ itcont.txt\n@=indiv_2004.txt\n" | zipnote -w indiv_2004.zip
printf "@ itcont.txt\n@=indiv_2002.txt\n" | zipnote -w indiv_2002.zip
printf "@ itcont.txt\n@=indiv_2000.txt\n" | zipnote -w indiv_2000.zip
printf "@ itcont.txt\n@=indiv_1980.txt\n" | zipnote -w indiv_1980.zip
printf "@ itcont.txt\n@=indiv_1982.txt\n" | zipnote -w indiv_1982.zip
printf "@ itcont.txt\n@=indiv_1984.txt\n" | zipnote -w indiv_1984.zip
printf "@ itcont.txt\n@=indiv_1986.txt\n" | zipnote -w indiv_1986.zip
printf "@ itcont.txt\n@=indiv_1988.txt\n" | zipnote -w indiv_1988.zip
printf "@ itcont.txt\n@=indiv_1990.txt\n" | zipnote -w indiv_1990.zip
printf "@ itcont.txt\n@=indiv_1992.txt\n" | zipnote -w indiv_1992.zip
printf "@ itcont.txt\n@=indiv_1994.txt\n" | zipnote -w indiv_1994.zip
printf "@ itcont.txt\n@=indiv_1996.txt\n" | zipnote -w indiv_1996.zip
printf "@ itcont.txt\n@=indiv_1998.txt\n" | zipnote -w indiv_1998.zip

FileArray=("Individual_Contributions" 
            "Candidate_Master"
            "All_Candidates"
            "Congress_Current_Campaigns"
            "Committee_Master"
            "PAC_Summary"
            "Operating_Expenditures" 
            "Candidate_Committee_Links"
            "From_Committee_Contributions"
            "Intercommittee_Transactions")
            

cd /home/michelle/sdb1/FEC/Data/
for val in ${FileArray[@]}
do 
unzip ./data_zipped/$val/\*.zip -d ./data_raw/$val/
done 


for val in ${FileArray[@]}
do 
for j in ${namearray[@]}
do 
unzip -nv /home/michelle/sdb1/FEC/Data/data_zipped/$val/$j -d /home/michelle/sdb1/FEC/Data/data_raw/$val/temp_"${j//.zip/}" && mv /home/michelle/sdb1/FEC/Data/data_raw/$val/tmp_"${j//.zip/}" /home/michelle/sdb1/FEC/Data/data_raw/$val/"${j//.zip/}".txt
done 
done 


for j in ${namearray[@]}
do 

for val in ${FileArray[@]}
do 
for f in *.zip; do unzip -p "$f" > "${f%.zip}.txt"; done


name=$(find *zip -type f)

echo $name
name=${name//.zip}
name=${name}
while read -d '' -r; do
    arr+=( "$name" )
done < <(find *zip -type f -print0)
echo $name 
NameArray=$name
echo $NameArray[0]
done 
done 


cd ./$val/
mkdir tmp/$val
for f in *.zip
do 


cd ./$val

