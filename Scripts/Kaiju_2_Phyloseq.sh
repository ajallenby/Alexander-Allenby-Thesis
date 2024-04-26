#!/bin/bash
#SBATCH --job-name=Kaiju2Phyloseq
#SBATCH --mail-type=END,FAIL 
#SBATCH --mail-user=aallenby02@qub.ac.uk
#SBATCH --ntasks=1        
#SBATCH --cpus-per-task=1          
#SBATCH --nodes=1                   
#SBATCH --time=24:00:00             
#SBATCH --partition=k2-medpri
#SBATCH --mem-per-cpu=16G
#SBATCH --output=/users/40305431/logs/Kaiju2Phyloseq_%j

#CONDA ENV = Taxonomy
cd path/to/wDir

mkdir -p Kaiju_abundance
for file in Kaiju_nr_euk/*/*_kaiju.out ; do
sample=$(basename -s _kaiju.out $file)
#Extract sample ID column | count number of occurences for each ID | add a sample column | reformat uniq output into a csv | correct weird error that removes the , before unclassified
grep -o "[0-9]*$" $file | sort | uniq -c | sed "s/^/${sample},/" | sed "s/[[:space:]]\+//" | tr " " "," | sed ' 1 s/0$/,0/' > "${file}.csv"
cat $file.csv >> Kaiju_abundance/Kaiju_nr_euk_TaxaAbundance.csv
done


Rscript /users/40305431/Scripts/Final_Movile_Metagenomes/Kaiju2Phyloseq.R Kaiju_abundance/TaxaAbundance.csv Kaiju_abundance/MovileCave_Kaiju_