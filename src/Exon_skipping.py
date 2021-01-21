
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
    key1 = chrom + "_" + start_pos
    key2 = chrom + "_" + start_pos
    region = lline[3]
    gene = region.split("_")[0]
    exon = region.split("_exon_")[1]
    if gene not in gene_dict :
        gene_dict[gene] = []
    gene_dict[gene].append([chrom, start_pos, end_pos, exon])
    pos_dict[key1] = gene
    pos_dict[key2] = gene

normal_junction = {}
unnormal_junction = {}
for line in junction_file:
    lline = line.strip().split("\t")
    chrom = lline[0]
    start_pos = lline[1]
    end_pos = lline[2]
    nr_reads = int(lline[6])
    key1 = "chr" + chrom + "_" + start_pos
    key2 = "chr" + chrom + "_" + end_pos
    if key1 not in pos_dict or key2 not in pos_dict :
        continue
    i = 0
    i_start = 100
    i_end = 100
    for exon in gene_dict[pos_dict[key1]] :
        if exon[1] == start_pos :
            i_start = i
        if exon[1] == end_pos :
            i_end = i
        i += 1
    if i_start != 100 and i_end != 100:
        if i_end - i_start > 1 :
            if nr_reads > 5 :
                if key1 in unnormal_junction :
                    if nr_reads > unnormal_junction[key1][0] :
                        unnormal_junction[key1] = [nr_reads, i_start, i_end]
                else :
                    unnormal_junction[key1] = [nr_reads, i_start, i_end]
        elif i_end - i_start == 1 :
            normal_junction[key1] = [nr_reads, i_start, i_end]

result_file.write("Gene\tstart_exon\tend_exon\tsupporting_reads\treads_supporting_normal_splicing\n"
for unnormal_key in unnormal_junction :
    gene = pos_dict[unnormal_key]
    nr_unnormal_reads = unnormal_junction[unnormal_key]
    nr_normal_reads = normal_junction[unnormal_key]
    start_exon = gene_dict[gene][unnormal_junction[unnormal_key][1]][3]
    end_exon = gene_dict[gene][unnormal_junction[unnormal_key][2]][3]
    if nr_unnormal_reads / (nr_unnormal_reads + nr_normal_reads) > 0.1 :
        result_file.write(gene + "\t" + start_exon + "\t" + end_exon + "\t" + nr_unnormal_reads + "\t" + nr_normal_reads + "\n")

result_file.close()
