#!/bin/bash
#SBATCH --job-name=SAM_MetaWrapBinning
#SBATCH --mail-type=END,FAIL 
#SBATCH --mail-user=aallenby02@qub.ac.uk
#SBATCH --ntasks=1         
#SBATCH --cpus-per-task=8          
#SBATCH --nodes=1                   
#SBATCH --time=48:05:00             
#SBATCH --partition=k2-himem
#SBATCH --mem-per-cpu=64G
#SBATCH --output=/users/40305431/logs/SAM_MetaWrapBinning_%j

#CONDA ENV = metawrapenv
cd path/to/wDir

mkdir -p MetaWrapBinning/SAM/
metawrap binning -o MetaWrapBinning/SAM/ -t 32 -m 512 -a MEGAHIT/SAM/final.contigs.fa --metabat2 --maxbin2 --concoct  MetaWrap_ready_sequences/SAM/SAM_paired_1.fastq MetaWrap_ready_sequences/SAM/SAM_paired_2.fastq

