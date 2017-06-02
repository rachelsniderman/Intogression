#!/bin/bash -l
#SBATCH -J array_job
#SBATCH -o slurm-log/erroutput/array_job_out_%A_%a.txt
#SBATCH -e slurm-log/erroutput/array_job_err_%A_%a.txt
#SBATCH -p med
#SBATCH --array=1-100
#SBATCH --mem=20000
####SBATCH --cpus-per-task=6

# mod 2017-04- 24

#Change this to where the fastq files are in your directory ~/fish/data/
indir=/home/rsbrenna/introgression/fastq

#these are prgrams that you can download
my_samtools=~/bin/samtools-1.3.1/samtools
my_bwa=~/bin/bwa-0.7.12/bwa
my_samblstr=~/bin/samblaster/samblaster

#this is the reference genome
bwagenind=~/reference/heteroclitus-3.0.2_genomic.fna.gz

#where the output will be saved- you'll  need to create this directory
outdir=~/fish/alligned/
#/$run/$lib

#specifying your different reads
#forward read
fq1=$(find $indir -name "*_RA.fastq.gz" | sed -n $(echo $SLURM_ARRAY_TASK_ID)p)
#reverse read
fq2=$(echo $fq1 | sed 's/_RA/_RB/g')
#sample name ie, PP-123-12
root=$(echo $fq1 | sed 's/.*\///' | cut -f 1 -d "_")
#info about the indiv and sequence info
nm=$(echo $root | cut -f 1 -d ".")
rg=$(echo \@RG\\tID:$root\\tPL:Illumina\\tPU:x\\tLB:cb\\tSM:$nm)
tempsort=$root.temp
outfile=$outdir$root.bam
#below will print all the specified variables above. THis is what you check to make sure things are working.
echo $SLURM_ARRAY_TASK_ID
echo $root
echo $fq1
echo $fq2
echo $rg
echo $tempsort
echo $outfile
echo $outdir


$my_bwa mem -t 6 -R $rg $bwagenind $fq1 $fq2 | \
$my_samblstr | \
$my_samtools view -S -h -u - | \
$my_samtools sort - -T /scratch/$tempsort -O bam -o $outfile
