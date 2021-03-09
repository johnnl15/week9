mycurrentdirectory = dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(mycurrentdirectory)

install.packages("DESeq2")
BiocManager::install("DESeq2",lib=.libPaths()[1])


library("DESeq2")
sampleInfo = read.table("shortRNAseq.txt")
sampleInfo$FullSampleName = as.character(sampleInfo$FullSampleName)

## I am assuming feature counts finished
countdata = read.table("fly_counts_2.txt", header=TRUE, row.names=1)
# Remove first five columns (chr, start, end, strand, length)
countdata = countdata[ ,6:ncol(countdata)]
# Remove crap from colnames in countdata
temp = colnames(countdata)
temp = gsub("AdvancedInformatics2021Directory.johnnl15.johnnl15.mydata.RNAseqout.rawdata._","",temp)
temp = gsub(".bam","",temp)
colnames(countdata) = temp

##  does everything match up...
cbind(temp,sampleInfo$FullSampleName,temp == sampleInfo$FullSampleName)

# create DEseq2 object & run DEseq
dds = DESeqDataSetFromMatrix(countData=countdata, colData=sampleInfo, design=~TissueCode)
dds <- DESeq(dds)
res <- results( dds )
res

#Had to remove seurat and sctransform: 
#remove.packages("sctransform", lib="/Library/Frameworks/R.framework/Versions/4.0/Resources/library")
#remove.packages("Seurat", lib="/Library/Frameworks/R.framework/Versions/4.0/Resources/library")


plotMA( res, ylim = c(-1, 1) )
plotDispEsts( dds )
hist( res$pvalue, breaks=20, col="grey" )

###  throw out lowly expressed genes?? ... I leave this as an exercise
###  add external annotation to "gene ids"
# log transform
rld = rlog( dds )
## this is where you could just extract the log transformed normalized data for each sample ID, and then roll your own analysis
head( assay(rld) )
mydata = assay(rld)

sampleDists = dist( t( assay(rld) ) )

#install R 3.5 to avoid maybe the seurat and deseq2 conflict
# heat map
sampleDistMatrix = as.matrix( sampleDists )
rownames(sampleDistMatrix) = rld$TissueCode
colnames(sampleDistMatrix) = NULL
library( "gplots" )
library( "RColorBrewer" )
colours = colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
heatmap.2( sampleDistMatrix, trace="none", col=colours)

# PCs
# wow you can sure tell tissue apart
print( plotPCA( rld, intgroup = "TissueCode") )
# heat map with gene clustering
library( "genefilter" )
# these are the top genes (that tell tissue apart no doubt)
topVarGenes <- head( order( rowVars( assay(rld) ), decreasing=TRUE ), 35 )
heatmap.2( assay(rld)[ topVarGenes, ], scale="row", trace="none", dendrogram="column", col = colorRampPalette( rev(brewer.pal(9, "RdBu")) )(255))
# volcano plot this is an exercise

R.version()
sessionInfo()
R --version

dev.off()
