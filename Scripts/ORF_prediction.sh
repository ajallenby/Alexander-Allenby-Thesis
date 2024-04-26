#!/bin/bash
#SBATCH --job-name=Prodigal
#SBATCH --mail-type=END,FAIL 
#SBATCH --mail-user=aallenby02@qub.ac.uk
#SBATCH --ntasks=1         
#SBATCH --cpus-per-task=4          
#SBATCH --nodes=1                   
#SBATCH --time=12:00:00             
#SBATCH --partition=k2-medpri
#SBATCH --mem-per-cpu=8G
#SBATCH --output=/users/40305431/logs/Prodigal_%j


#CONDA ENV = MAGTools
cd path/to/wDir

#Run prodigal on all bins and then concatenate the output
#Concatenate all Bins with their sample of origin added their to fasta headers
cd All_Bins_70_15
mkdir ../All_Bins_70_15_proteins
mkdir ../All_Bins_70_15_genes

for file in * ; do
binName=${file%.fa}
prodigal -i $file -o "../All_Bins_70_15_genes/${binName}_genes.gff" -a "../All_Bins_70_15_proteins/${binName}_proteins.faa"
cat "../All_Bins_70_15_proteins/${binName}_proteins.faa" | sed "s/^>/>${binName}_/" >> ../MetaWrapBins_70_15_concatenated.faa
cat $file | sed "s/^>/>${binName}_/" >> ../MetaWrapBins_70_15_concatenated.nt
done

