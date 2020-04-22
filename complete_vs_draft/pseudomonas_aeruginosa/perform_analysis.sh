parse_og.py -i complete/Results/Orthogroups.txt -o complete/Results/ncomplete
parse_og.py -i ncomplete/Results/Orthogroups.txt -o ncomplete/Results/ncomplete
estimate_complexity.py -i complete/Results/complete.sif -o complete/Results/complexity --reference GCF_000006765.1_ASM676v1_genomic --fill_db complete/Results/complete.db
estimate_complexity.py -i ncomplete/Results/ncomplete.sif -o ncomplete/Results/complexity --reference GCF_000006765.1_ASM676v1_genomic --fill_db ncomplete/Results/ncomplete.db

