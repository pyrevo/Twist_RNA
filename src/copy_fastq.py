
import sys
import subprocess

sample_file = open(sys.argv[1])

for line in sample_file :
    lline = line.strip().split("\t")
    sample = lline[0]
    R1 = lline[1]
    R2 = lline[2]
    subprocess.call("cp " + R1 + " fastq_temp/RNA/", shell=True)
    subprocess.call("cp " + R2 + " fastq_temp/RNA/", shell=True)
