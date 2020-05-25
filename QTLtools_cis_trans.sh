#!/bin/bash
#$ -S /bin/sh

export PATH=${PATH}:/path/to/bin/
export LD_LIBRARY_PATH=/usr/lib/:${LD_LIBRARY_PATH}
ulimit -v 9999999999999

# Discover QTL in cis[nominal pass]
for i in {1..22};
do
	echo "QTLtools cis chr{$i} STAR nominal pass"
	QTLtools cis --vcf /path/to/GEUV/YRI/VCF/GEUVADIS_GRCh38_YRI_chr${i}_reheader_selected.vcf.gz --bed /path/to/GEUV/YRI/QTLtools_results/annotation_expression_selected_phenotype_sorted_chr${i}.bed.gz --cov /path/to/GEUV/YRI/QTLtools_results/YRI_genes_covariates_selected_phenotype_pc86.txt --nominal 0.01 --out /path/to/GEUV/YRI/QTLtools_results/nominals_selected_phenotype_chr${i}_`date "+%Y%m%d"`.txt > /path/to/GEUV/YRI/QTLtools_results/`date "+%Y%m%d"`_QTLtools_cis_nominal_selected_phenotype_chr${i}_log.txt 2>&1
done

cat GEUV/YRI/QTLtools_results/nominals_selected_phenotype_chr* > GEUV/YRI/QTLtools_results/results_selected_phenotype_cis_nominals_`date "+%Y%m%d"`_full.txt
gzip GEUV/YRI/QTLtools_results/results_selected_phenotype_cis_nominals_`date "+%Y%m%d"`_full.txt

# Discover QTL in cis[permutation pass]
for i in {1..22};
do
	echo "QTLtools cis chr{$i} STAR permutation pass"
	QTLtools cis --vcf /path/to/GEUV/YRI/VCF/GEUVADIS_GRCh38_YRI_chr${i}_reheader_selected.vcf.gz --bed /path/to/GEUV/YRI/QTLtools_results/annotation_expression_selected_phenotype_sorted_chr${i}.bed.gz --cov /path/to/GEUV/YRI/QTLtools_results/YRI_genes_covariates_selected_phenotype_pc86.txt --permute 100 --out /path/to/GEUV/YRI/QTLtools_results/permutations_selected_phenotype_chr_${i}_`date "+%Y%m%d"`.txt --seed 123456 > /path/to/GEUV/YRI/QTLtools_results/`date "+%Y%m%d"`_QTLtools_cis_permutations_selected_phenotype_chr${i}_log.txt 2>&1
done

cat GEUV/YRI/QTLtools_results/permutations_selected_phenotype_chr_* > GEUV/YRI/QTLtools_results/results_selected_phenotype_cis_permutation_`date "+%Y%m%d"`_full.txt
gzip GEUV/YRI/QTLtools_results/results_selected_phenotype_cis_permutation_`date "+%Y%m%d"`_full.txt
# gzcat /Users/inamojun/Desktop/TMDU/スパコン/results/results_selected_phenotype_cis_permutation_20200520_full.txt.gz | head -n 5
# Rscript /Users/inamojun/Desktop/TMDU/スパコン/script/runFDR_cis.R /Users/inamojun/Desktop/TMDU/スパコン/results/results_selected_phenotype_cis_permutation_20200520_full.txt.gz 0.05 /Users/inamojun/Desktop/TMDU/スパコン/GEUV_YRI/permutations_all
cat GEUV/YRI/QTLtools_results/permutations_all.significant.txt | awk '{ print $9, $10-1, $11, $8, $1, $5 }' | tr " " "\t" | sort -k1,1 -k2,2n > GEUV/YRI/QTLtools_results/results.genes.significant_selected_phenotype_`date "+%Y%m%d"`.bed
sed -i 's/chr//g' GEUV/YRI/QTLtools_results/results.genes.significant_selected_phenotype_`date "+%Y%m%d"`.bed
QTLtools fdensity --qtl GEUV/YRI/QTLtools_results/results.genes.significant_selected_phenotype_`date "+%Y%m%d"`.bed --bed /path/to/GEUV/YRI/QTLtools_results/TFs.encode.bed.gz --out /path/to/GEUV/YRI/QTLtools_results/density.TF.around.QTL_`date "+%Y%m%d"`.txt

#R
#> D=read.table("Desktop/TMDU/スパコン/results/density.TF.around.QTL_20200521.txt", head=FALSE, stringsAsFactors=FALSE)
#> plot((D$V1+D$V2)/2, D$V3, type="l", xlab="Distance to QTLs", ylab="#annotations/kb")

cat GEUV/YRI/QTLtools_results/permutations_all.significant.txt | awk '{ print $9, $10-1, $11, $8, $1, $5 }' | tr " " "\t" | sort -k1,1 -k2,2n > results.genes.significant.bed
zcat GEUV/YRI/QTLtools_results/results_selected_phenotype_cis_permutation_`date "+%Y%m%d"`_full.txt.gz | awk '{ print $2, $3-1, $4, $1, $8, $5 }' | tr " " "\t" | sort -k1,1 -k2,2n > GEUV/YRI/QTLtools_results/results.genes.quantified_selected_phenotype_`date "+%Y%m%d"`.bed
sed -i 's/chr//g' GEUV/YRI/QTLtools_results/results.genes.quantified_selected_phenotype_`date "+%Y%m%d"`.bed
QTLtools fenrich --qtl GEUV/YRI/QTLtools_results/results.genes.significant_selected_phenotype_`date "+%Y%m%d"`.bed --tss GEUV/YRI/QTLtools_results/results.genes.quantified_selected_phenotype_`date "+%Y%m%d"`.bed --bed /path/to/GEUV/YRI/QTLtools_results/TFs.encode.bed.gz --out /path/to/GEUV/YRI/QTLtools_results/enrichement.QTL.in.TF_`date "+%Y%m%d"`.txt
#R
#> D=read.table("Desktop/TMDU/スパコン/results/enrichement.QTL.in.TF_20200521.txt", head=FALSE, stringsAsFactors=FALSE)
#> fisher.test(matrix(c(D$V1, D$V2, round(D$V3), D$V2), ncol=2))


# Discover QTL in trans
for i in {1..22};
do
	echo "QTLtools trans chr{$i} STAR nominal pass"
	QTLtools trans --vcf /path/to/GEUV/YRI/VCF/GEUVADIS_GRCh38_YRI_chr${i}_reheader_selected.vcf.gz --bed /path/to/GEUV/YRI/QTLtools_results/annotation_expression_selected_phenotype_sorted_chr${i}.bed.gz --nominal --threshold 1e-5 --out /path/to/GEUV/YRI/QTLtools_results/trans.nominal_selected_phenotype_chr${i}_`date "+%Y%m%d"` > /path/to/GEUV/YRI/QTLtools_results/`date "+%Y%m%d"`_QTLtools_trans_nominal_selected_phenotype_chr${i}_log.txt 2>&1
done

for i in {1..22};
do
	echo "QTLtools trans chr{$i} STAR permutation pass"
	QTLtools trans --vcf /path/to/GEUV/YRI/VCF/GEUVADIS_GRCh38_YRI_chr${i}_reheader_selected.vcf.gz --bed /path/to/GEUV/YRI/QTLtools_results/annotation_expression_selected_phenotype_sorted_chr${i}.bed.gz --threshold 1e-5 --permute --out /path/to/GEUV/YRI/QTLtools_results/trans.perm123_selected_phenotype_chr${i}_`date "+%Y%m%d"` --seed 123 > /path/to/GEUV/YRI/QTLtools_results/`date "+%Y%m%d"`_QTLtools_trans_permutations_selected_phenotype_chr${i}_log.txt 2>&1
done


# QQ plot, nominal hitのFDR推定を 自分のmacで
#for i in {1..22};
#do
	# Rscript /Users/inamojun/Desktop/TMDU/スパコン/script/plotTrans.R /Users/inamojun/Desktop/TMDU/スパコン/results/QQplot_chr${i}_20200520.pdf /Users/inamojun/Desktop/TMDU/スパコン/results/trans.nominal_selected_phenotype_chr${i}_20200520.hits.txt.gz /Users/inamojun/Desktop/TMDU/スパコン/results/trans.nominal_selected_phenotype_chr${i}_20200520.bins.txt.gz /Users/inamojun/Desktop/TMDU/スパコン/results/trans.perm123_selected_phenotype_chr${i}_20200520.hits.txt.gz /Users/inamojun/Desktop/TMDU/スパコン/results/trans.perm123_selected_phenotype_chr${i}_20200520.bins.txt.gz
	# Rscript /Users/inamojun/Desktop/TMDU/スパコン/script/runFDR_ftrans.R /Users/inamojun/Desktop/TMDU/スパコン/results/trans.nominal_selected_phenotype_chr${i}_20200520.hits.txt.gz /Users/inamojun/Desktop/TMDU/スパコン/results/trans.perm123_selected_phenotype_chr${i}_20200520.hits.txt.gz /Users/inamojun/Desktop/TMDU/スパコン/results/trans.nominal.hits.withFDR_chr${i}_20200520.txt
#done