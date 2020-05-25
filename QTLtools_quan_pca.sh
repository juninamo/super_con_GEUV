#!/bin/bash
#$ -t 1-88:1
#$ -S /bin/sh

export PATH=${PATH}:/path/to/bin/
export LD_LIBRARY_PATH=/usr/lib/:${LD_LIBRARY_PATH}
ulimit -v 9999999999999

seq_libs=(List ERR188030 ERR188037 ERR188042 ERR188044 ERR188055 ERR188060 ERR188064 ERR188066 ERR188069 ERR188072 ERR188074 ERR188085 ERR188093 ERR188096 ERR188097 ERR188103 ERR188104 ERR188109 ERR188120 ERR188128 ERR188129 ERR188131 ERR188139 ERR188143 ERR188151 ERR188158 ERR188162 ERR188165 ERR188170 ERR188174 ERR188178 ERR188182 ERR188183 ERR188184 ERR188193 ERR188200 ERR188207 ERR188209 ERR188211 ERR188214 ERR188221 ERR188223 ERR188225 ERR188232 ERR188234 ERR188243 ERR188261 ERR188268 ERR188269 ERR188273 ERR188275 ERR188278 ERR188283 ERR188284 ERR188292 ERR188298 ERR188306 ERR188311 ERR188313 ERR188322 ERR188344 ERR188352 ERR188363 ERR188364 ERR188365 ERR188367 ERR188373 ERR188375 ERR188390 ERR188392 ERR188409 ERR188421 ERR188422 ERR188423 ERR188427 ERR188434 ERR188440 ERR188442 ERR188444 ERR188447 ERR188449 ERR188451 ERR188454 ERR188459 ERR188460 ERR188463 ERR188471 ERR188476)
seq_lib=${seq_libs[$SGE_TASK_ID]}


#vcf to bed
for i in {1..22};
do
	bcftools view -h /path/to/GEUV/YRI/VCF/GEUVADIS_GRCh38_YRI_chr${i}.vcf.gz > hdr_${i}.txt
	sed -e "2i ##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">" hdr_${i}.txt > new_hdr_${i}.txt
	bcftools reheader -h new_hdr_${i}.txt /path/to/GEUV/YRI/VCF/GEUVADIS_GRCh38_YRI_chr${i}.vcf.gz -o /path/to/GEUV/YRI/VCF/GEUVADIS_GRCh38_YRI_chr${i}_reheader.vcf.gz
	bcftools view -s ERR188030,ERR188037,ERR188042,ERR188044,ERR188055,ERR188060,ERR188064,ERR188066,ERR188069,ERR188072,ERR188074,ERR188085,ERR188093,ERR188096,ERR188097,ERR188103,ERR188104,ERR188109,ERR188120,ERR188128,ERR188129,ERR188131,ERR188139,ERR188143,ERR188151,ERR188158,ERR188162,ERR188165,ERR188170,ERR188174,ERR188178,ERR188182,ERR188183,ERR188200,ERR188207,ERR188209,ERR188211,ERR188214,ERR188221,ERR188223,ERR188225,ERR188232,ERR188234,ERR188243,ERR188261,ERR188268,ERR188269,ERR188273,ERR188275,ERR188278,ERR188283,ERR188284,ERR188292,ERR188298,ERR188306,ERR188311,ERR188313,ERR188322,ERR188344,ERR188352,ERR188363,ERR188364,ERR188365,ERR188367,ERR188373,ERR188375,ERR188390,ERR188392,ERR188409,ERR188421,ERR188422,ERR188423,ERR188427,ERR188434,ERR188440,ERR188442,ERR188444,ERR188447,ERR188449,ERR188451,ERR188454,ERR188459,ERR188460,ERR188463,ERR188471,ERR188476 /path/to/GEUV/YRI/VCF/GEUVADIS_GRCh38_YRI_chr${i}_reheader.vcf.gz > /path/to/GEUV/YRI/VCF/GEUVADIS_GRCh38_YRI_chr${i}_reheader_selected.vcf
	bgzip /path/to/GEUV/YRI/VCF/GEUVADIS_GRCh38_YRI_chr${i}_reheader_selected.vcf
	tabix /path/to/GEUV/YRI/VCF/GEUVADIS_GRCh38_YRI_chr${i}_reheader_selected.vcf.gz
done

zcat /path/to/GEUV/YRI/QTLtools_results/STAR_YRI_reheader_sorted.bed.gz | head -n 1 > header.txt
zcat /path/to/GEUV/YRI/QTLtools_results/STAR_YRI_reheader_sorted.bed.gz | grep "chr22" > /path/to/GEUV/YRI/QTLtools_results/STAR_YRI_reheader_sorted_chr22_tmp.bed
cat header.txt /path/to/GEUV/YRI/QTLtools_results/STAR_YRI_reheader_sorted_chr22_tmp.bed > /path/to/GEUV/YRI/QTLtools_results/STAR_YRI_reheader_sorted_chr22.bed
bgzip /path/to/GEUV/YRI/QTLtools_results/STAR_YRI_reheader_sorted_chr22.bed
tabix /path/to/GEUV/YRI/QTLtools_results/STAR_YRI_reheader_sorted_chr22.bed.gz

# Quantify gene expression
echo "QTLtools quan $seq_lib STAR"
cd /path/to/GEUV/YRI/fastq/"$seq_lib"_combined_STAR_GRCh38
QTLtools quan --bam "$seq_lib"_combined_sorted_GRCh38.bam --gtf /path/to/reference/gencode.v29.annotation.gtf --sample "$seq_lib" --out-prefix "$seq_lib" --filter-mapping-quality 150 --filter-mismatch 5 --filter-mismatch-total 5 --rpkm

# Quantify all samples for which you have RNA-seq, proceed as follows:
cut -f 1-6 /path/to/GEUV/YRI/fastq/ERR188030_combined_STAR_GRCh38/ERR188030.B90ZWx6MSAY.gene.rpkm.bed > merge.bed

for file in ERR188030 ERR188037 ERR188042 ERR188044 ERR188055 ERR188060 ERR188064 ERR188066 ERR188069 ERR188072 ERR188074 ERR188085 ERR188093 ERR188096 ERR188097 ERR188103 ERR188104 ERR188109 ERR188120 ERR188128 ERR188129 ERR188131 ERR188139 ERR188143 ERR188151 ERR188158 ERR188162 ERR188165 ERR188170 ERR188174 ERR188178 ERR188182 ERR188183 ERR188184 ERR188193 ERR188200 ERR188207 ERR188209 ERR188211 ERR188214 ERR188221 ERR188223 ERR188225 ERR188232 ERR188234 ERR188243 ERR188261 ERR188268 ERR188269 ERR188273 ERR188275 ERR188278 ERR188283 ERR188284 ERR188292 ERR188298 ERR188306 ERR188311 ERR188313 ERR188322 ERR188344 ERR188352 ERR188363 ERR188364 ERR188365 ERR188367 ERR188373 ERR188375 ERR188390 ERR188392 ERR188409 ERR188421 ERR188422 ERR188423 ERR188427 ERR188434 ERR188440 ERR188442 ERR188444 ERR188447 ERR188449 ERR188451 ERR188454 ERR188459 ERR188460 ERR188463 ERR188471 ERR188476;
do
	cut -f7 /path/to/GEUV/YRI/fastq/"$file"_combined_STAR_GRCh38/"$file".B90ZWx6MSAY.gene.rpkm.bed > "$file"_merge.bed
done

paste merge.bed *_merge.bed > final.bed
rm merge.bed *_merge.bed
awk '{print "chr" $0 }' final.bed > STAR_YRI.bed

awk '{print $0 }' STAR_YRI.bed | sed -e 's/chr#chr/#chr/g' > STAR_YRI_reheader.bed
sed -n 1P STAR_YRI_reheader.bed > header.bed
sed -e '1d' STAR_YRI_reheader.bed > STAR_YRI_reheader2.bed
sortBed -i STAR_YRI_reheader2.bed > STAR_YRI_reheader2_sorted.bed
for i in {1..22};
do
	cat STAR_YRI_reheader2_sorted.bed | grep -w "chr${i}" > STAR_YRI_"chr${i}".bed
done
cat STAR_YRI_chr1.bed  STAR_YRI_chr2.bed STAR_YRI_chr3.bed STAR_YRI_chr4.bed STAR_YRI_chr5.bed STAR_YRI_chr6.bed STAR_YRI_chr7.bed STAR_YRI_chr8.bed STAR_YRI_chr9.bed STAR_YRI_chr10.bed STAR_YRI_chr11.bed STAR_YRI_chr12.bed STAR_YRI_chr13.bed STAR_YRI_chr14.bed STAR_YRI_chr15.bed STAR_YRI_chr16.bed STAR_YRI_chr17.bed STAR_YRI_chr18.bed STAR_YRI_chr19.bed STAR_YRI_chr20.bed STAR_YRI_chr21.bed STAR_YRI_chr22.bed > STAR_YRI_merge.bed
cat header.bed STAR_YRI_merge.bed > STAR_YRI_merge2.bed
bgzip STAR_YRI_merge2.bed
tabix -p bed STAR_YRI_merge2.bed.gz
 # → 発現量が0のtranscriptは除く

# Perform PCA on data
QTLtools pca --bed /path/to/STAR_YRI_reheader_sorted.bed.gz --scale --center --out GEUV/YRI/QTLtools_results/STAR_YRI

# bedファイルをchrごとに分ける
zcat /path/to/GEUV/YRI/QTLtools_results/STAR_YRI_reheader_sorted2.bed.gz | sed -n 1P > header.bed
for i in {1..22};
do
	zcat /path/to/GEUV/YRI/QTLtools_results/STAR_YRI_reheader_sorted2.bed.gz | grep -w "chr${i}" > STAR_YRI_"chr${i}".bed
	cat header.bed STAR_YRI_"chr${i}".bed > STAR_YRI_"chr${i}"_2.bed
	opt/local/bin/bgzip STAR_YRI_"chr${i}"_2.bed
	opt/local/bin/tabix STAR_YRI_"chr${i}"_2.bed.gz
	mv STAR_YRI_"chr${i}"_2.bed.gz /path/to/GEUV/YRI/QTLtools_results/STAR_YRI_"chr${i}".bed.gz
	mv STAR_YRI_"chr${i}"_2.bed.gz.tbi /path/to/GEUV/YRI/QTLtools_results/STAR_YRI_"chr${i}".bed.gz.tbi
done


# 発現量が50%以下の遺伝子は削除し、さらにvarianceがtop 10000の遺伝子のみにfilterしたもの
R
>TPMdata2 <- read.table("/Users/inamojun/Desktop/TMDU/スパコン/GEUV_YRI/STAR_TPM.txt", header=TRUE, sep="\t", quote="")  #TPMで正規化済み
>TPMdata2 <- TPMdata2[,-1]
#head(TPMdata2)
>dim(TPMdata2)
## filtering 
#全ての遺伝子と比較して、50%tile以下の発現量の遺伝子は削除
>df  <- TPMdata2 [quantile(rowSums(TPMdata2), 0.50)<rowSums(TPMdata2), ]
>dim(df)
#さらにvarianceの大きいtop 10000の遺伝子のみ抽出
>topVarGenes <- head(order(-rowVars(df)),10000)

>df <- df[ topVarGenes, ]
>dim(df)

>annotation <- read.table("/Users/inamojun/Desktop/TMDU/スパコン/results/merge.bed", header=F, sep="\t", quote="") 
>head(annotation)
>df2 <- merge(annotation,df,by.x="V4",by.y="row.names")
>df3 <- cbind(df2[,2:4],df2[,1],df2[,-c(1:4)])
>dim(df3)
>df3[sort(df3$V1, decreasing = T),]
>head(df3)
>write.table(df3,"/Users/inamojun/Desktop/TMDU/スパコン/GEUV_YRI/annotation_expression_full.txt", sep = "\t", quote = FALSE,row.names=FALSE)

awk '{print "chr" $0 }' annotation_expression_full.txt > annotation_expression_full.bed
sed -e '1d' annotation_expression_full.bed > annotation_expression_selected_genes.bed
tools/bedtools2/bin/sortBed -i annotation_expression_selected_genes.bed > annotation_expression_selected_genes_sorted.bed
cat annotation_expression_selected_genes_sorted.bed | awk '{print $1 "\t" $2}' 
for i in {1..22};
do
	cat annotation_expression_selected_genes_sorted.bed | grep -w "chr${i}" > annotation_expression_selected_genes_sorted_"chr${i}".bed
done
cat annotation_expression_selected_genes_sorted_chr1.bed  annotation_expression_selected_genes_sorted_chr2.bed annotation_expression_selected_genes_sorted_chr3.bed annotation_expression_selected_genes_sorted_chr4.bed annotation_expression_selected_genes_sorted_chr5.bed annotation_expression_selected_genes_sorted_chr6.bed annotation_expression_selected_genes_sorted_chr7.bed annotation_expression_selected_genes_sorted_chr8.bed annotation_expression_selected_genes_sorted_chr9.bed annotation_expression_selected_genes_sorted_chr10.bed annotation_expression_selected_genes_sorted_chr11.bed annotation_expression_selected_genes_sorted_chr12.bed annotation_expression_selected_genes_sorted_chr13.bed annotation_expression_selected_genes_sorted_chr14.bed annotation_expression_selected_genes_sorted_chr15.bed annotation_expression_selected_genes_sorted_chr16.bed annotation_expression_selected_genes_sorted_chr17.bed annotation_expression_selected_genes_sorted_chr18.bed annotation_expression_selected_genes_sorted_chr19.bed annotation_expression_selected_genes_sorted_chr20.bed annotation_expression_selected_genes_sorted_chr21.bed annotation_expression_selected_genes_sorted_chr22.bed > annotation_expression_selected_genes_sorted_merge.bed
zcat /path/to/GEUV/YRI/QTLtools_results/STAR_YRI_reheader_sorted2.bed.gz | sed -n 1P > header.bed
cat header.bed annotation_expression_selected_genes_sorted_merge.bed > GEUV/YRI/QTLtools_results/STAR_YRI_merge_selected_phenotype.bed
bgzip GEUV/YRI/QTLtools_results/STAR_YRI_merge_selected_phenotype.bed
tabix -p bed GEUV/YRI/QTLtools_results/STAR_YRI_merge_selected_phenotype.bed.gz
mv annotation_expression_selected_genes_sorted_chr* GEUV/YRI/QTLtools_results/
for i in {1..22};
do
	cat header.bed GEUV/YRI/QTLtools_results/annotation_expression_selected_genes_sorted_chr${i}.bed > GEUV/YRI/QTLtools_results/annotation_expression_selected_phenotype_sorted_chr${i}.bed
	bgzip GEUV/YRI/QTLtools_results/annotation_expression_selected_phenotype_sorted_chr${i}.bed
	tabix -p bed GEUV/YRI/QTLtools_results/annotation_expression_selected_phenotype_sorted_chr${i}.bed.gz
done
zcat GEUV/YRI/QTLtools_results/annotation_expression_selected_phenotype_sorted_chr3.bed.gz | head -n 3 

# Perform PCA on data
QTLtools pca --bed GEUV/YRI/QTLtools_results/STAR_YRI_merge_selected_phenotype.bed.gz --scale --center --out GEUV/YRI/QTLtools_results/STAR_YRI_selected_phenotype
cat GEUV/YRI/QTLtools_results/STAR_YRI_selected_phenotype.pca > GEUV/YRI/QTLtools_results/YRI_genes_covariates_selected_phenotype_pc86.txt

