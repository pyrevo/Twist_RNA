
S_rna = []
for s in config["RNA_Samples"].values() :
    S_rna.append(s)
fastq1_files = ["fastq_temp/RNA/" + s + "_" + i + "_R1_001.fastq.gz" for s,i in zip(config["RNA_Samples"], S_rna)]
fastq2_files = ["fastq_temp/RNA/" + s + "_" + i + "_R2_001.fastq.gz" for s,i in zip(config["RNA_Samples"], S_rna)]



rule copy_fastq_RNA:
    input:
        sample_file = "samples.tsv",
    output:
        fastq1 = fastq1_files,
        fastq2 = fastq2_files,
    shell:
        "python src/copy_fastq.py {input.sample_file}"
