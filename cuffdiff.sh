#!/bin/bash
#$ -t 1-22:1
#$ -S /bin/sh

seq_libs=(List 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22)
seq_lib=${seq_libs[$SGE_TASK_ID]}

export PATH=${PATH}:/path/to/bin/
export LD_LIBRARY_PATH=/usr/lib/:${LD_LIBRARY_PATH}
ulimit -v 9999999999999

cat /path/to/GEUV/YRI/fastq/cuffmerge_STAR_GRCh38/merged.gtf | grep -w "chr$seq_lib" > /path/to/GEUV/YRI/fastq/cuffmerge_STAR_GRCh38/merged_chr"$seq_lib".gtf

cuffdiff -o /path/to/GEUV/YRI/fastq/cuffdiff_STAR_output_chr"$seq_lib" -p 2 --library-type fr-firststrand \
	/path/to/GEUV/YRI/fastq/cuffmerge_STAR_GRCh38/merged_chr"$seq_lib".gtf \
	-L ERR188030,ERR188037,ERR188042,ERR188044,ERR188060,ERR188064,ERR188066,ERR188069,ERR188074,ERR188085,ERR188093,ERR188096,ERR188097,ERR188103,ERR188104,ERR188109,ERR188120,ERR188128,ERR188129,ERR188131,ERR188139,ERR188143,ERR188151,ERR188162,ERR188165,ERR188170,ERR188174,ERR188178,ERR188182,ERR188183,ERR188184,ERR188193,ERR188200,ERR188207,ERR188209,ERR188211,ERR188214,ERR188221,ERR188223,ERR188225,ERR188232,ERR188234,ERR188243,ERR188261,ERR188268,ERR188269,ERR188273,ERR188275,ERR188278,ERR188284,ERR188292,ERR188298,ERR188306,ERR188311,ERR188313,ERR188322,ERR188344,ERR188352,ERR188363,ERR188364,ERR188365,ERR188367,ERR188373,ERR188375,ERR188390,ERR188392,ERR188409,ERR188421,ERR188422,ERR188423,ERR188427,ERR188434,ERR188440,ERR188442,ERR188444,ERR188447,ERR188449,ERR188451,ERR188454,ERR188459,ERR188463,ERR188471,ERR188476 \
	/path/to/GEUV/YRI/fastq/ERR188030_combined_STAR_GRCh38/ERR188030_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188037_combined_STAR_GRCh38/ERR188037_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188042_combined_STAR_GRCh38/ERR188042_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188044_combined_STAR_GRCh38/ERR188044_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188060_combined_STAR_GRCh38/ERR188060_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188064_combined_STAR_GRCh38/ERR188064_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188066_combined_STAR_GRCh38/ERR188066_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188069_combined_STAR_GRCh38/ERR188069_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188074_combined_STAR_GRCh38/ERR188074_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188085_combined_STAR_GRCh38/ERR188085_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188093_combined_STAR_GRCh38/ERR188093_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188096_combined_STAR_GRCh38/ERR188096_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188097_combined_STAR_GRCh38/ERR188097_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188103_combined_STAR_GRCh38/ERR188103_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188104_combined_STAR_GRCh38/ERR188104_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188109_combined_STAR_GRCh38/ERR188109_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188120_combined_STAR_GRCh38/ERR188120_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188128_combined_STAR_GRCh38/ERR188128_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188129_combined_STAR_GRCh38/ERR188129_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188131_combined_STAR_GRCh38/ERR188131_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188139_combined_STAR_GRCh38/ERR188139_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188143_combined_STAR_GRCh38/ERR188143_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188151_combined_STAR_GRCh38/ERR188151_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188162_combined_STAR_GRCh38/ERR188162_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188165_combined_STAR_GRCh38/ERR188165_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188170_combined_STAR_GRCh38/ERR188170_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188174_combined_STAR_GRCh38/ERR188174_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188178_combined_STAR_GRCh38/ERR188178_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188182_combined_STAR_GRCh38/ERR188182_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188183_combined_STAR_GRCh38/ERR188183_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188184_combined_STAR_GRCh38/ERR188184_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188193_combined_STAR_GRCh38/ERR188193_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188200_combined_STAR_GRCh38/ERR188200_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188207_combined_STAR_GRCh38/ERR188207_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188209_combined_STAR_GRCh38/ERR188209_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188211_combined_STAR_GRCh38/ERR188211_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188214_combined_STAR_GRCh38/ERR188214_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188221_combined_STAR_GRCh38/ERR188221_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188223_combined_STAR_GRCh38/ERR188223_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188225_combined_STAR_GRCh38/ERR188225_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188232_combined_STAR_GRCh38/ERR188232_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188234_combined_STAR_GRCh38/ERR188234_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188243_combined_STAR_GRCh38/ERR188243_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188261_combined_STAR_GRCh38/ERR188261_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188268_combined_STAR_GRCh38/ERR188268_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188269_combined_STAR_GRCh38/ERR188269_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188273_combined_STAR_GRCh38/ERR188273_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188275_combined_STAR_GRCh38/ERR188275_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188278_combined_STAR_GRCh38/ERR188278_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188284_combined_STAR_GRCh38/ERR188284_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188292_combined_STAR_GRCh38/ERR188292_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188298_combined_STAR_GRCh38/ERR188298_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188306_combined_STAR_GRCh38/ERR188306_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188311_combined_STAR_GRCh38/ERR188311_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188313_combined_STAR_GRCh38/ERR188313_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188322_combined_STAR_GRCh38/ERR188322_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188344_combined_STAR_GRCh38/ERR188344_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188352_combined_STAR_GRCh38/ERR188352_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188363_combined_STAR_GRCh38/ERR188363_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188364_combined_STAR_GRCh38/ERR188364_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188365_combined_STAR_GRCh38/ERR188365_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188367_combined_STAR_GRCh38/ERR188367_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188373_combined_STAR_GRCh38/ERR188373_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188375_combined_STAR_GRCh38/ERR188375_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188390_combined_STAR_GRCh38/ERR188390_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188392_combined_STAR_GRCh38/ERR188392_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188409_combined_STAR_GRCh38/ERR188409_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188421_combined_STAR_GRCh38/ERR188421_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188422_combined_STAR_GRCh38/ERR188422_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188423_combined_STAR_GRCh38/ERR188423_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188427_combined_STAR_GRCh38/ERR188427_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188434_combined_STAR_GRCh38/ERR188434_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188440_combined_STAR_GRCh38/ERR188440_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188442_combined_STAR_GRCh38/ERR188442_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188444_combined_STAR_GRCh38/ERR188444_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188447_combined_STAR_GRCh38/ERR188447_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188449_combined_STAR_GRCh38/ERR188449_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188451_combined_STAR_GRCh38/ERR188451_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188454_combined_STAR_GRCh38/ERR188454_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188459_combined_STAR_GRCh38/ERR188459_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188463_combined_STAR_GRCh38/ERR188463_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188471_combined_STAR_GRCh38/ERR188471_combined_sorted_GRCh38.bam \
	/path/to/GEUV/YRI/fastq/ERR188476_combined_STAR_GRCh38/ERR188476_combined_sorted_GRCh38.bam  > /path/to/GEUV/YRI/fastq/cuffdiff_STAR_output_chr"$seq_lib"/`date "+%Y%m%d"`_cuffdiff_STAR_chr"$seq_lib"_log.txt 2>&1