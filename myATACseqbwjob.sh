#!/bin/bash
#SBATCH --job-name=ATACseqbw      ## Name of the job.
#SBATCH -A ecoevo283         ## account to charge 
#SBATCH -p standard          ## partition/queue name
#SBATCH --array=1-24         ## number of tasks to launch, given hint below wc -l $file is helpful
#SBATCH --cpus-per-task=2    ## number of cores the job needs, can the programs you run make used of multiple 

module load samtools/1.10
module load bedtools2/2.29.2
module load ucsc-tools/v393 

file="prefixesATACbw.txt"
ref="mydata/ref/dmel-all-chromosome-r6.13.fasta"
dir="AdvancedInformatics2021Directory/johnnl15/johnnl15"
prefix=`head -n $SLURM_ARRAY_TASK_ID  $file | tail -n 1` 
Nreads=`samtools view -c -F 4 ${prefix}.maj`
Scale=`echo "1.0/($Nreads/1000000)" | bc -l`

#normalize across samples
samtools view -b -L major.bed ${prefix} > ${prefix}.maj
#conducting genome coverage
samtools view -b ${prefix}.maj | genomeCoverageBed -bg -scale $Scale -ibam - > ${prefix}.coverage
#sort my files
bedSort ${prefix}.coverage ${prefix}.sort.coverage
#convert to big wig files
bedGraphToBigWig ${prefix}.sort.coverage $dir/$ref.fai ${prefix}.bw
# end bw
