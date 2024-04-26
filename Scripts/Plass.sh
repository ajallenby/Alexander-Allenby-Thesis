#!/bin/bash
#SBATCH --job-name=SAM_plass
#SBATCH --mail-type=END,FAIL 
#SBATCH --mail-user=aallenby02@qub.ac.uk
#SBATCH --ntasks=1         
#SBATCH --cpus-per-task=4          
#SBATCH --nodes=1                   
#SBATCH --time=24:05:00             
#SBATCH --partition=k2-himem
#SBATCH --mem-per-cpu=64G
#SBATCH --output=/users/40305431/logs/SAM_plass_%j

#CONDA ENV = Gene-centric
cd path/to/wDir
mkdir -p Plass_assemblies/SAM

plass assemble Trimmed_sequences/SAM/SAM_R1_paired.fq Trimmed_sequences/SAM/SAM_R2_paired.fq Plass_assemblies/SAM/SAM_plass_assembly.fas Plass_assemblies/tmp_SAM --min-length 40 --threads 24 --split-memory-limit 64G

cat Plass_assemblies/SAM/SAM_plass_assembly.fas | tr " " "_" |  tr ":" "_" | sed "s/^>/>SAM_/" > Plass_assemblies/SAM/SAM_plass_assembly_rnm.fas
