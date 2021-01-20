
import sys

bed_file = open(sys.argv[1])
junction_file = open(sys.argv[2])
result_file = open(sys.argv[3], "w")

gene_dict = {}
for line in bed_file :
    lline = line.strip().split("\t")
    chrom = lline[0]
    start_pos = int(lline[1])
    end_pos = int(lline[2])
    region = lline[3]
    gene = region.split("_")[0]
    exon = region.split("_exon_")[1]
    if gene not in gene_dict :
        gene_dict[gene] = []
    gene_dict[gene].append([chrom, start_pos, end_pos, exon])

for line in junction_file:
    lline = line.strip().split("\t")
    
