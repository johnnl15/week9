I ran Deseq2 with this script [deseq2](Deseq2.R) utilizing the following input files [fly counts](fly_counts_2.txt) and [shortRNAseq](shortRNAseq.txt). The following are the published quality control and heatmaps: 

[histogram](plotHist.pdf)  n\    
[Dispersion](plotDispEsts.pdf) n\
[MA](plotMA.pdf) n\
[heatmap](Heatmap2.pdf) n\
[PCA](PCA.pdf) n\

I will make a prefix list:

```

ls AdvancedInformatics2021Directory/johnnl15/johnnl15/mydata/ATACseqout/rawdata/*RG.bam >prefixesATACbw.txt
cat $dir/$ref.fai | head -n 7 | awk '{printf("%s\t0\t%s\n",$1,$2)}' > major.bed

```
Run my script to load in ucsc genome browser [bigwig](myATACseqbwjob.sh). 

I then upload to [cyverse](Cyverse.png). 

Here is the data on ucsc browser [atac](D. melanogaster dm6 chr2L/1988549-2232756 UCSC Genome Browser v410.pdf). 
