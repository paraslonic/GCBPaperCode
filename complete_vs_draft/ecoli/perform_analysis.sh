python3 gcb/parse_og.py -i draft/Orthogroups.txt -o draft/draft
python3 gcb/parse_og.py -i complete/Orthogroups.txt -o complete/complete
python3 gcb/estimate_complexity.py -i draft/draft.sif -o draft --reference GCF_000005845.2_ASM584v2_genomic
