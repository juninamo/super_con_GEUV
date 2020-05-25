#!/bin/bash
#$ -t 1-88:1
#$ -S /bin/sh

seq_libs=(List ERR188030 ERR188037 ERR188042 ERR188044 ERR188055 ERR188060 ERR188064 ERR188066 ERR188069 ERR188072 ERR188074 ERR188085 ERR188093 ERR188096 ERR188097 ERR188103 ERR188104 ERR188109 ERR188120 ERR188128 ERR188129 ERR188131 ERR188139 ERR188143 ERR188151 ERR188158 ERR188162 ERR188165 ERR188170 ERR188174 ERR188178 ERR188182 ERR188183 ERR188184 ERR188193 ERR188200 ERR188207 ERR188209 ERR188211 ERR188214 ERR188221 ERR188223 ERR188225 ERR188232 ERR188234 ERR188243 ERR188261 ERR188268 ERR188269 ERR188273 ERR188275 ERR188278 ERR188283 ERR188284 ERR188292 ERR188298 ERR188306 ERR188311 ERR188313 ERR188322 ERR188344 ERR188352 ERR188363 ERR188364 ERR188365 ERR188367 ERR188373 ERR188375 ERR188390 ERR188392 ERR188409 ERR188421 ERR188422 ERR188423 ERR188427 ERR188434 ERR188440 ERR188442 ERR188444 ERR188447 ERR188449 ERR188451 ERR188454 ERR188459 ERR188460 ERR188463 ERR188471 ERR188476)
seq_lib=${seq_libs[$SGE_TASK_ID]}

export PATH=${PATH}:/path/to/tools/subread-2.0.0-source/bin/
export LD_LIBRARY_PATH=/usr/lib/:${LD_LIBRARY_PATH}
ulimit -v 9999999999999

echo "featureCounts $seq_lib STAR_GRCh38"
cd /path/to/GEUV/YRI/fastq/"$seq_lib"_combined_STAR_GRCh38
featureCounts -p -B -O -T 8 -t exon -g gene_id -a /path/to/tools/subread-2.0.0-source/gencode.v29.chr_patch_hapl_scaff.annotation.gtf -o ALL_counts_STAR_GRCh38.txt "$seq_lib"_combined_sorted_GRCh38.bam

echo "featureCounts $seq_lib HISAT2_GRCh38"
cd /path/to/GEUV/YRI/fastq/"$seq_lib"_combined_HISAT2_GRCh38
featureCounts -p -B -O -T 8 -t exon -g gene_id -a /path/to/tools/subread-2.0.0-source/gencode.v29.chr_patch_hapl_scaff.annotation.gtf -o ALL_counts_HISAT2_GRCh38.txt "$seq_lib"_combined_sorted_GRCh38.bam

echo "featureCounts $seq_lib STAR_GRCh38"
cd /path/to/GEUV/YRI/fastq/"$seq_lib"_combined_STAR_GRCh38
featureCounts -p -B -O -T 8 -t exon -g gene_id -a /path/to/GEUV/YRI/fastq/cuffmerge_STAR_GRCh38/merged.gtf -o ALL_counts_STAR_GRCh38_mergedgtf.txt "$seq_lib"_combined_sorted_GRCh38.bam

echo "featureCounts $seq_lib HISAT2_GRCh38"
cd /path/to/GEUV/YRI/fastq/"$seq_lib"_combined_HISAT2_GRCh38
featureCounts -p -B -O -T 8 -t exon -g gene_id -a /path/to/GEUV/YRI/fastq/cuffmerge_HISAT2_GRCh38/merged.gtf -o ALL_counts_HISAT2_GRCh38_mergedgtf.txt "$seq_lib"_combined_sorted_GRCh38.bam

#-T CPUコア数。
#-t feature type を指定し、これにマッチした GTF file の行だけがカウントされる。デフォルトは exon になっている。
#-a アノテーションファイルを指定する。
#-g meta-feature を指定する。デフォルトは、gene_idになっている。つまり gene-levelの カウントが得られる。例の GENCODE の GTFの場合は、Ensembl Gene ID (= gene_id)になる。exon_idを指定すれば、exon-levelのカウントが得られる。
#-o 出力されるカウントデータのファイル名。 最後にカウントの対象となる bam file を指定する。1つでも複数でも指定できる。 複数指定した場合は、1つのファイルが生成され、列ごとにそれぞれの bam のカウントが表示される。
#-p ペアエンド
# -O 重なりがあるリードがあるときに指定するらしい。
# -B　If specified, only fragments that have both ends successfully aligned will be considered for summarization. This option is only applicable for paired-end reads.

## 内容の説明
# 先頭部分数十行を載せている。出力はタブ区切りのテキストファイルで、1行目はコメント行（#）である。2行目以下は以下のような並びになっている。
# ‘Geneid’, ‘Chr’, ‘Start’, ‘End’, ‘Strand’,‘Length’,‘sample1_count’,‘sample2_count’ ...
# ２列目に1;1;1;1;1;1とあるのは、exsonが6あることを意味している。lengthは１つの遺伝子のオーバーラップをのぞいたexonの合計サイズ (bp) である。右端にあるのがカウントの列である。サンプル数分だけできる。