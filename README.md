# GPS

Guide Positioning Sequencing Toolkit (GPS) is a utility suite for analyzing data generated by Guide Positioning Sequencing experiments. Read2 sequence is as same as genome DNA while Read1 is bisulfite-treated in GPS experiment. GPS was written to perform sequencing alignment and DNA methylation calling.

#Download and Install

Please download the file named GPS_Toolkit_version_0.zip

$ unzip GPS_Toolkit_version_0.zip
$ cd GPS_Toolkit_version_0


#Usage

#Index reference for alignment
GPS index files are collections of each chromosome file in fasta format with no line break in the sequence.

#Remove duplicates
$ paste R1 R2 |awk '{if(NR%4==2) print $0}'|uniq > test_step1
./software/filter_R2_by_CH_and_A_to_fasta.py test_step1


#Read alignment
$ bowtie2 -x /reference/bowtie2Indices/hg19 -f test_step12 -k 20 -p 10  --omit-sec-seq -S test_step123.sam
$ ./software/sam2bed < test_step123.sam > test_step123.bed -d 
$ awk '{printf(""%s\t%s\t%s\t%s\t%d\n"",$4,""*"",$6,$1,$2)}' test_step123.bed  > test_step1234
$ ./software/sw_7.0 test_step1234 /reference/GPS_index_files/ test_step12345 /software/score_matrix_n.txt /software/score_matrix_p.txt 475 6 20 test_step1234_unmap

The file test_step12345 contained the information of cytosine location, methylation level and coverage.
