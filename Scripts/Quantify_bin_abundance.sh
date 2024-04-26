#!/bin/bash
#SBATCH --job-name=CoverM
#SBATCH --mail-type=END,FAIL 
#SBATCH --mail-user=aallenby02@qub.ac.uk
#SBATCH --ntasks=1         
#SBATCH --cpus-per-task=8         
#SBATCH --nodes=1                   
#SBATCH --time=24:00:00             
#SBATCH --partition=bio-compute
#SBATCH --mem-per-cpu=8G
#SBATCH --output=/users/40305431/logs/CoverM_%j

cores=$(nproc)
#CONDA ENV = MAGTools
cd path/to/wDir

#95% minimum identity and minimum aligned read length of 75% of each read
coverm genome \
-1 /mnt/scratch2/users/40305431/FINAL_MOVILE_METAGENOMES/Raw_sequences/*/*R1.fq \
-2 /mnt/scratch2/users/40305431/FINAL_MOVILE_METAGENOMES/Raw_sequences/*/*R2.fq \
--genome-fasta-directory MetaWrapBins_70_15/All_Bins_70_15 \
--genome-fasta-extension .fa \
--min-read-percent-identity 95 \
--min-read-aligned-percent 75 \
--methods relative_abundance mean variance tpm \
--output-file CoverM_rawReads_output.tsv \
--threads $cores

