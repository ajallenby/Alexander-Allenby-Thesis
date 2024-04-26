#!/bin/bash
#SBATCH --job-name=GTDB-TK
#SBATCH --mail-type=END,FAIL 
#SBATCH --mail-user=aallenby02@qub.ac.uk
#SBATCH --ntasks=1         
#SBATCH --cpus-per-task=4          
#SBATCH --nodes=1                   
#SBATCH --time=18:00:00             
#SBATCH --partition=k2-himem
#SBATCH --mem-per-cpu=64G
#SBATCH --output=/users/40305431/logs/GTDB-TK_%j


#CONDA ENV = GTDB-Tk
cd path/to/wDir
#download db
#download-db.sh
#make results dir
mkdir -p GTDB-Tk
#run GTDB-Tk results
gtdbtk classify_wf --cpus 4 -x fa --genome_dir MetaWrapBins_70_15/All_Bins_70_15 --out_dir GTDB-Tk

