
rule copy_fastq_RNA:
    input:
        sample_file = "sample.tsv",
    output:
        fastq1 = ["fastq/RNA/" + s + "_R1.fastq.gz" for s in config["RNA_samples"]],
        fastq2 = ["fastq/RNA/" + s + "_R2.fastq.gz" for s in config["RNA_samples"]],
    shell:
        "python src/copy_fastq.py {input.sample_file}"
