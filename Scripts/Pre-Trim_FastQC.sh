#!/bin/bash
#SBATCH --job-name=Pre-Trim_FastQC
#SBATCH --mail-type=END,FAIL 
#SBATCH --mail-user=aallenby02@qub.ac.uk
#SBATCH --ntasks=1         
#SBATCH --cpus-per-task=4          
#SBATCH --nodes=1                   
#SBATCH --time=03:00:00             
#SBATCH --partition=k2-hipri
#SBATCH --mem-per-cpu=8G
#SBATCH --output=/users/40305431/logs/Pre-Trim_FastQC_%j

#CONDA ENV = QualityControl
cd path/to/wDir

#Make results folders
mkdir -p Pre-Trim_FastQC

#run with wildcards
fastqc Raw_sequences/*/*.fq -o Pre-Trim_FastQC