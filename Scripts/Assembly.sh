#!/bin/bash
#SBATCH --job-name=SAM_megahit
#SBATCH --mail-type=END,FAIL 
#SBATCH --mail-user=aallenby02@qub.ac.uk
#SBATCH --ntasks=1         
#SBATCH --cpus-per-task=8          
#SBATCH --nodes=1                   
#SBATCH --time=48:05:00             
#SBATCH --partition=k2-himem
#SBATCH --mem-per-cpu=64G
#SBATCH --output=/users/40305431/logs/SAM_megahit_%j


#CONDA ENV = Assembly
cd path/to/wDir
mkdir -p MEGAHIT/
megahit --preset meta-sensitive -t 32 -1 Trimmed_sequences/SAM/SAM_R1_paired.fq -2 Trimmed_sequences/SAM/SAM_R2_paired.fq -r Trimmed_sequences/SAM/SAM_combined_unpaired.fq -o MEGAHIT/SAM
