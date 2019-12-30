tar -xvzf *.tar.gz
python2.7 findseq.py GCTGGTGG ref/Escherichia_coli_K_12_substr__MG1655_uid57779_A.fasta > K_12_chi_fow
python2.7 findseq.py CCACCAGC ref/Escherichia_coli_K_12_substr__MG1655_uid57779_A.fasta > K_12_chi_rev
Rscript plot.R
