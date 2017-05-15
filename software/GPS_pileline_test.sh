#!/bin/bash
# creatation: 2017-5-15

input1=$1   

if test -z $1 
then
"  echo ""please input the R1 file (.fastq)"" "
  exit
fi

input2=$2

if test -z $2
then
"  echo ""please input the R2 file (.fastq)"" "
  exit
fi

input3=$3

if test -z $3
then
"  echo ""please input the p number (N)"" "
  exit
fi
#################

paste $input1 $input2 |awk '{if(NR%4==2) print $0}'|uniq > ${input1}_step1
/software/filter_R2_by_CH_and_A_to_fasta.py ${input1}_step1 


(nohup bowtie2 -x /home/shareData/Genomes/bowtie2Indices/hg19 -f ${input1}_step12 -k 20 -p 25  --omit-sec-seq -S ${input1}_step123.sam >>nohup.out & wait) &&(sam2bed ${input1}_step123.sam ${input1}_step123.bed )



"awk '{printf(""%s\t%s\t%s\t%s\t%d\n"",$4,""*"",$6,$1,$2)}' ${input1}_step123.bed  >${input1}_step1234"

./software/sw_7.0 ${input1}_step1234 /reference/GPS_human/ ${input1}_step12345 /software/score_matrix_n.txt /software/score_matrix_p.txt 475 6 $input3 ${input1}_step1234_unmap >>nohup.out
