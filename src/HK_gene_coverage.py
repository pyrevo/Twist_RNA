
import subprocess
import sys
import time

genes = ["GAPDH", "GUSB", "OAZ1", "POLR2A"]

bam_file = sys.argv[1]
bedfilename = sys.argv[2]
outfile = open(sys.argv[3], "w")
outfile.write("Sample\tGene\tAvg_coverage\n")


for gene in genes :
    regions = []
    bedfile = open(bedfilename)
    for line in bedfile :
        if line.find(gene) != -1:
            lline = line.strip().split("\t")
            regions.append([lline[0], lline[1], lline[2]])
    bedfile.close()
    coverage_sum = 0
    coverage_nr_pos = 0
    coverage_list = []
    for region in regions :
        region = region[0] + ":" + region[1] + "-" + region[2]
        sample = bam_file.split("/")[-1].split(".bam")[0]
        cov_outfile_name = "DATA/RNA_gene_depth_" + sample + ".txt"
        print("samtools depth -d 50000 -a -r " + region + " " + bam_file + " > " + cov_outfile_name)
        subprocess.call("samtools depth -d 50000 -a -r " + region + " " + bam_file + " > " + cov_outfile_name, shell=True)
        time.sleep(2)
        depthfile = open(cov_outfile_name)
        for line in depthfile :
            coverage = int(line.strip().split("\t")[2])
            coverage_sum += coverage
            coverage_nr_pos += 1
            coverage_list.append(coverage)
        depthfile.close()
    outfile.write(sample + "\t" + gene + "\t" + str(round(coverage_sum/float(coverage_nr_pos),1)) + "\n")
outfile.close()
