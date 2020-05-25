#!/bin/bash
#$ -S /bin/sh

export PATH=${PATH}:/path/to/bin/
export LD_LIBRARY_PATH=/usr/lib/:${LD_LIBRARY_PATH}
ulimit -v 9999999999999

#以下は自分のmacで
# gzcat /Users/inamojun/Desktop/TMDU/スパコン/results/results_selected_phenotype_cis_permutation_20200520_full.txt.gz | head -n 5
Rscript /Users/inamojun/Desktop/TMDU/スパコン/script/runFDR_cis.R /Users/inamojun/Desktop/TMDU/スパコン/results/results_selected_phenotype_cis_permutation_20200520_full.txt.gz 0.05 /Users/inamojun/Desktop/TMDU/スパコン/GEUV_YRI/permutations_all

for i in {1..22};
do
	echo "QTLtools cis conditional chr{$i}"
	QTLtools cis --vcf /path/to/GEUV/YRI/VCF/GEUVADIS_GRCh38_YRI_chr${i}_reheader_selected.vcf.gz --bed /path/to/GEUV/YRI/QTLtools_results/annotation_expression_selected_phenotype_sorted_chr${i}.bed.gz --cov /path/to/GEUV/YRI/QTLtools_results/YRI_genes_covariates_selected_phenotype_pc86.txt --mapping /path/to/GEUV/YRI/QTLtools_results/permutations_all.thresholds.txt --out /path/to/GEUV/YRI/QTLtools_results/conditional_chr${i}_`date "+%Y%m%d"`.txt > /path/to/GEUV/YRI/QTLtools_results/`date "+%Y%m%d"`_QTLtools_cis_conditional_selected_phenotype_chr${i}_log.txt 2>&1
	cat /path/to/GEUV/YRI/QTLtools_results/conditional_chr${i}_`date "+%Y%m%d"`.txt | awk '{ if ($19 == 1) print $0}' > /path/to/GEUV/YRI/QTLtools_results/conditional_top_variants_chr${i}_`date "+%Y%m%d"`.txt
done

for i in {1..22};
do
	cat /path/to/GEUV/YRI/QTLtools_results/conditional_chr${i}_`date "+%Y%m%d"`.txt | awk '{ if ($19 == 1) print $0}' > /path/to/GEUV/YRI/QTLtools_results/conditional_top_variants_chr${i}_`date "+%Y%m%d"`.txt
done