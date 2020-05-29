N=20

org="Escherichia coli"
#grep "$org" assembly_summary_refseq.txt | grep -v "Complete" | awk -F "\t" '{print $20}' | awk 'BEGIN{FS=OFS="/";filesuffix="genomic.fna.gz"}{ftpdir=$0;asm=$10;file=asm"_"filesuffix;print ftpdir,file}' > ncomplete_genomes.url
#shuf -n $N ncomplete_genomes.url > selected_noncomplete_genomes.url
grep "$org" assembly_summary_refseq.txt | grep "Complete" | awk -F "\t" '{print $20}' | awk 'BEGIN{FS=OFS="/";filesuffix="genomic.fna.gz"}{ftpdir=$0;asm=$10;file=asm"_"filesuffix;print ftpdir,file}' > complete_genomes.url
shuf -n $N complete_genomes.url > selected_complete_genomes.url

wget $(cat selected_complete_genomes.url )
gunzip *.gz
mkdir -p complete
rm complete/fna/*
mkdir -p complete/fna
mv *.fna complete/fna

#wget $(cat selected_noncomplete_genomes.url )
gunzip *.gz
mkdir -p ncomplete
rm ncomplete/fna/*
mkdir -p ncomplete/fna
mv *.fna ncomplete/fna


