#!/bin/bash
#SBATCH --job-name=MarkerMAG 
#SBATCH --mail-type=END,FAIL 
#SBATCH --mail-user=aallenby02@qub.ac.uk
#SBATCH --ntasks=1         
#SBATCH --cpus-per-task=8          
#SBATCH --nodes=1                   
#SBATCH --time=24:00:00             
#SBATCH --partition=k2-medpri
#SBATCH --mem-per-cpu=8G
#SBATCH --output=/users/40305431/logs/MarkerMAG_%j


#CONDA ENV = MAGTools
cores=$( nproc )
cd cd path/to/wDir
MarkerMAG barrnap_16s -g MetaWrapBins_70_15/All_Bins_70_15 -x fa -t $cores

