#!/bin/bash
#$ -t 1-88:1
#$ -S /bin/sh

export PATH=${PATH}:/path/to/bin/
export LD_LIBRARY_PATH=/usr/lib/:${LD_LIBRARY_PATH}
ulimit -v 9999999999999

seq_libs=(List ERR188030 ERR188037 ERR188042 ERR188044 ERR188055 ERR188060 ERR188064 ERR188066 ERR188069 ERR188072 ERR188074 ERR188085 ERR188093 ERR188096 ERR188097 ERR188103 ERR188104 ERR188109 ERR188120 ERR188128 ERR188129 ERR188131 ERR188139 ERR188143 ERR188151 ERR188158 ERR188162 ERR188165 ERR188170 ERR188174 ERR188178 ERR188182 ERR188183 ERR188184 ERR188193 ERR188200 ERR188207 ERR188209 ERR188211 ERR188214 ERR188221 ERR188223 ERR188225 ERR188232 ERR188234 ERR188243 ERR188261 ERR188268 ERR188269 ERR188273 ERR188275 ERR188278 ERR188283 ERR188284 ERR188292 ERR188298 ERR188306 ERR188311 ERR188313 ERR188322 ERR188344 ERR188352 ERR188363 ERR188364 ERR188365 ERR188367 ERR188373 ERR188375 ERR188390 ERR188392 ERR188409 ERR188421 ERR188422 ERR188423 ERR188427 ERR188434 ERR188440 ERR188442 ERR188444 ERR188447 ERR188449 ERR188451 ERR188454 ERR188459 ERR188460 ERR188463 ERR188471 ERR188476)
seq_lib=${seq_libs[$SGE_TASK_ID]}

for i in {1..22};
do
	echo "QTLtools mbv $seq_lib $i STAR"
	cd /path/to/GEUV/YRI/fastq/"$seq_lib"_combined_STAR_GRCh38
	QTLtools mbv --bam "$seq_lib"_combined_sorted_GRCh38.bam --vcf /path/to/GEUV/YRI/VCF/GEUVADIS_GRCh38_YRI_chr${i}_reheader_selected.vcf.gz --filter-mapping-quality 150 --out "$seq_lib"_chr${i}.bamstat.txt
done > /path/to/GEUV/YRI/QTLtools_results/`date "+%Y%m%d"`_QTLtools_mbv_log.txt 2>&1
