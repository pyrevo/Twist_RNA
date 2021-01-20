
import sys

junction_file = open(sys.argv[1])
result_file = open(sys.argv[2], "w")

junction_reads = {"116411902" : 0, "116414934" : 0}
for line in junction_file :
    lline = line.strip().split("\t")
    chrom = lline[0]
    if chrom != "chr7" :
        continue
    start_pos = lline[1]
    if start_pos != "116411709" :
        continue
    end_pos = lline[2]
    if end_pos == "116411902" or end_pos == "116414934" :
        reads = int(lline[6])
        junction_reads[end_pos] = reads
junction_file.close()

result_file.write("Reads_exon13-14\tReads_exon13-15\tMET_exon_skipping? (10% read support)\n")
result_file.write(str(junction_reads["116411902"]) + "\t" + str(junction_reads["116414934"]))
if junction_reads["116414934"] > (junction_reads["116411902"] + junction_reads["116414934"]) * 0.1 :
    result_file.write("\tMET exon skipping found!!!")
elif junction_reads["116414934"] > 0 :
    result_file.write("\tSome evidence of exon skipping.")
else :
    result_file.write("\tNo exon skipping.")
result_file.write("\n")
result_file.close()
