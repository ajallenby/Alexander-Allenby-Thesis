#!/bin/bash
#SBATCH --job-name=Plass_Concatenate
#SBATCH --mail-type=END,FAIL 
#SBATCH --mail-user=aallenby02@qub.ac.uk
#SBATCH --ntasks=1         
#SBATCH --cpus-per-task=4          
#SBATCH --nodes=1                   
#SBATCH --time=04:00:00             
#SBATCH --partition=k2-medpri
#SBATCH --mem-per-cpu=8G
#SBATCH --output=/users/40305431/logs/Plass_Concatenate_%j


#CONDA ENV = base(any)
cd path/to/wDir

mkdir Plass_Concatenates/
cat Plass_assemblies/*/*plass_assembly_rnm.fas > Plass_Concatenates/Plass_assembly.fas

