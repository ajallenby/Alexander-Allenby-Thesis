#!/usr/bin/bash
#Dependencies
#hmmer3
#cd-hit
#seqkit
#clustalo
#trimal
#fasttree
#R
##stringr
##RColorBrewer

#set defaults
#Rscript
#makeMOBAnnotations=/users/40305431/Scripts/MOB/makeMOBAnnotations.r
#MOBgenomes
#metaMOB=/mnt/scratch2/users/40305431/MOB/genomes_v2_taxonomy_expanded.csv
#results directory (dbd)
output=.
#clustering theshold 
clustering=0.8
#SequenceLengthCutOff
lengthCutOff=0
#e value theshold 
eValue=1e-05

#set user defined parameters
while getopts t:s:q:c:l:o:e: flag
do
    case "${flag}" in
        t) target=${OPTARG};;
        s) samples=${OPTARG};;
        q) queries=${OPTARG};;
	c) clustering=${OPTARG};;
	l) lengthCutOff=${OPTARG};;
	o) output=${OPTARG};;
	e) eValue=${OPTARG};;
    esac
done

#TODO:: Add -h option
#TODO:: Add soft failures

#Declare database file
echo "Target Database: $target";

#Declare Sample List file
echo "Samples Manifest File: $samples";

echo "Queries Manifest File: $queries";

echo "Clustering Threshold: $clustering";

echo "Sequence Length Cut-Off: $lengthCutOff";

echo "E-value Threshold: $eValue";

#results directory (dbd)
echo "Output Directoryt: $output";
mkdir $output

#make results table
resultsTable="${output}/Results_Table.csv"
echo "sample" >> $resultsTable
cat $samples >> $resultsTable

IFS=","
while read f1 f2 f3
do
        echo "HMM is: $f1"
        echo "Reference set is: $f2"
        
        #Set e-value
        if [ -z "${f3}" ]; then
        f3=$eValue
        fi        
        echo "E-value is: $f3"
        
	extensionRemoved=${f1%.*}
	geneName=${extensionRemoved##*/}
	echo "Gene name is: $geneName"
	
	#Make results sub directory
	geneResults="${output}/${geneName}"
	mkdir $geneResults
	
	#Make CSV for results (rc)
	geneTable="${geneResults}/${geneName}_Hit_Count_Table.csv"
	echo $geneName >> $geneTable
	
	#Name files
	# hmm out
	geneHMMSearch="${geneResults}/${geneName}_HMMSearch_Results.txt"
	# table out
	geneHMMTable="${geneResults}/${geneName}_HMMSearch_Table.tsv"
	# domain table out
	geneHMMDomainTable="${geneResults}/${geneName}_HMMSearch_Domain_Table.tsv"

	#Hit headers
	geneHitHeaders="${geneResults}/${geneName}_Hit_Headers.txt"
	#Hit sequences
	geneHitSequencesRaw="${geneResults}/${geneName}_Hit_Sequences_Raw.fa"
	#Hit sequences Processed
	geneHitSequences="${geneResults}/${geneName}_Hit_Sequences.fa"
	#Hit sequences Clustered
	geneHitSequencesClustered="${geneResults}/${geneName}_Hit_Sequences_Clustered.fa"
	#Clusters
	geneHitSequencesClusters="${geneResults}/${geneName}_Hit_Sequences_Clustered.fa.clstr"
	#Clusters Reformatted
	geneHitSequencesClustersReformatted="${geneResults}/${geneName}_Hit_Sequences_Clustered.fa.clstr.csv"

	#Hits plus references seqs
	geneHitsAndRefs="${geneResults}/${geneName}_Hits_and_References.fa"
	#Hits plus references aligned
	geneHitsAndRefsAligned="${geneResults}/${geneName}_Hits_and_References.aln"
	#Hits plus references aligned trimmed
	geneHitsAndRefsAlignedTrimmed="${geneResults}/${geneName}_Hits_and_References_trimmed.aln"
	#Hits plus references aligned Tree
	geneHitsAndRefsAlignedTree="${geneResults}/${geneName}_Hits_and_References.nwk"
	#Hits plus references aligned trimmed Tree
	geneHitsAndRefsAlignedTrimmedTree="${geneResults}/${geneName}_Hits_and_References_trimmed.nwk"

	#IToL annotation name
	geneIToLAnnotations="${geneResults}/${geneName}_Hit_IToL_Annotations"

	#HMM search for Gene
	hmmsearch -E $f3 -o $geneHMMSearch --tblout $geneHMMTable --domtblout $geneHMMDomainTable $f1 $target
	
	#Get Hits from results
	grep "^[^#]" $geneHMMTable | sed "s/ .*$//" | sort -u > $geneHitHeaders
	seqkit grep -f $geneHitHeaders $target >  $geneHitSequencesRaw
	cat $geneHitSequencesRaw | tr -d "*" | seqkit seq --min-len $lengthCutOff - > $geneHitSequences
	
	if [[ -s $f2 ]] ; then
	#add references
	cat $geneHitSequences >> $geneHitsAndRefs
	cat $f2 >> $geneHitsAndRefs
	#align
	clustalo -i $geneHitsAndRefs -o $geneHitsAndRefsAligned
	#trim
	trimal -in $geneHitsAndRefsAligned -out $geneHitsAndRefsAlignedTrimmed -automated1
	#make tree
	fasttree -boot 1000 $geneHitsAndRefsAligned > $geneHitsAndRefsAlignedTree
	fasttree -boot 1000 $geneHitsAndRefsAlignedTrimmed > $geneHitsAndRefsAlignedTrimmedTree
	fi
	
	#Generate sample annotations
	#MOB hit Annotations
	#Rscript $makeMOBAnnotations $geneHitHeaders $metaMOB $geneIToLAnnotations
	
	#count results
	while read sam; do 
	count=$(grep -c "^>${sam}_" $geneHitSequences)
	echo $count >> $geneTable
	done < $samples
	paste -d , $resultsTable $geneTable > Intermediary.csv
	cat Intermediary.csv > $resultsTable
	rm Intermediary.csv
	
done < $queries
