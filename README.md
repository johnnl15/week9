I ran Deseq2 with this script [deseq2](Deseq2.R) utilizing the following input files [fly counts](fly_counts_2.txt) and [shortRNAseq](shortRNAseq.txt). The following are the published quality control and heatmaps: 

[histogram](plotHist.pdf)      
[Dispersion](plotDispEsts.pdf)  
[MA](plotMA.pdf)  
[heatmap](Heatmap2.pdf)  
[PCA](PCA.pdf)  

I will make a prefix list:

```

ls AdvancedInformatics2021Directory/johnnl15/johnnl15/mydata/ATACseqout/rawdata/*RG.bam >prefixesATACbw.txt
cat $dir/$ref.fai | head -n 7 | awk '{printf("%s\t0\t%s\n",$1,$2)}' > major.bed

```
Run my script to load in ucsc genome browser [bigwig](myATACseqbwjob.sh). 

I then upload to [cyverse](Cyverse.png). 

Here is the data on ucsc browser [atac](D.melanogaster.pdf). 
