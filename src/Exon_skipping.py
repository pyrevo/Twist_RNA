
import sys

bed_file = open(sys.argv[1])
junction_file = open(sys.argv[2])
result_file = open(sys.argv[3], "w")

gene_dict = {}
pos_dict = {}
for line in bed_file :
    lline = line.strip().split("\t")
    chrom = lline[0]
    start_pos = int(lline[1])
    end_pos = int(lline[2])
    key = chrom + "_" + start_pos
    region = lline[3]
    gene = region.split("_")[0]
    exon = region.split("_exon_")[1]
    if gene not in gene_dict :
        gene_dict[gene] = []
    gene_dict[gene].append([chrom, start_pos, end_pos, exon])
    pos_dict[key] = ""

for line in junction_file:
    lline = line.strip().split("\t")
    chrom = lline[0]
    start_pos = lline[1]
    end_pos = lline[2]
    nr_reads = int(lline[6])
    key = "chr" + chrom + "_" + start_pos
    if key not in pos_dict :
        continue
