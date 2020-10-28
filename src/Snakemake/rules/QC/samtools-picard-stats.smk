localrules: touchBatch

rule samtools_stats:
    input:
        #bam = "DNA_bam/{sample}-ready.bam"
        bam = "STAR2/{sample}Aligned.sortedByCoord.out.bam"
    output:
        "qc/{sample}/{sample}.samtools-stats.txt"
    params:
        extra = "-t "+ config["bed"]["bedfile"],                       # Optional: extra arguments.
        # region="1:1000000-2000000"      # Optional: region string.
    log:
        "logs/qc/samtools_stats/{sample}.log"
    singularity:
        config["singularity"]["samtools"]
    shell:
        "(samtools stats {params.extra} {input} > {output} ) &> {log}"
    # wrapper:
    #     "0.38.0/bio/samtools/stats"

rule picardHsMetrics:
    input:
        #bam = "DNA_bam/{sample}-ready.bam",
        bam = "STAR2/{sample}Aligned.sortedByCoord.out.bam",
        intervals = config["bed"]["intervals"]
    output:
        "qc/{sample}/{sample}.HsMetrics.txt"
    log:
        "logs/qc/picardHsMetrics/{sample}.log"
    singularity:
        config["singularity"]["picard"]
    shell:
        "(java -Xmx4g -jar /opt/conda/share/picard-2.20.1-0/picard.jar CollectHsMetrics BAIT_INTERVALS={input.intervals} TARGET_INTERVALS={input.intervals} INPUT={input.bam} OUTPUT={output}) &> {log}"


rule picardInsertSize:
    input:
        bam = "STAR2/{sample}Aligned.sortedByCoord.out.bam"
    output:
        txt = "qc/{sample}/{sample}.insert_size_metrics.txt",
        pdf = "qc/{sample}/{sample}.insert_size_histogram.pdf"
    log:
        "logs/qc/picardInsertSize/{sample}.log"
    singularity:
        config["singularity"]["picard"]
    shell:
        "(java -Xmx4g -jar /opt/conda/share/picard-2.20.1-0/picard.jar CollectInsertSizeMetrics INPUT={input.bam} O={output.txt} H={output.pdf}) &> {log}"

#singularity exec -B /beegfs-scratch /projects/wp2/nobackup/Twist_Myeloid/Containers/bwa0.7.17-samtools-1.9.simg java -Xmx4g -jar /opt/conda/share/picard-2.20.1-0/picard.jar CollectInsertSizeMetrics  VALIDATION_STRINGENCY=LENIENT INPUT=../STAR2/R20-246Aligned.sortedByCoord.out.bam OUTPUT=R20-246.insert_size_metrics.txt H=R20-246.insert_size_histogram.pdf


rule PicardAlignmentSummaryMetrics:
    input:
        bam = "STAR2/{sample}Aligned.sortedByCoord.out.bam",
	    ref = "/projects/wp4/nobackup/workspace/jonas_test/STAR-Fusion/references/GRCh37_gencode_v19_CTAT_lib_Apr032020.plug-n-play/ctat_genome_lib_build_dir/ref_genome.fa"
    output:
        "qc/{sample}/{sample}.alignment_summary_metrics.txt"
    log:
        "logs/qc/picardAlignmentSummaryMetrics/{sample}.log"
    singularity:
        config["singularity"]["picard"]
    shell:
        "(java -Xmx4g -jar /opt/conda/share/picard-2.20.1-0/picard.jar CollectAlignmentSummaryMetrics INPUT={input.bam} R={input.ref} OUTPUT={output}) &> {log}"

#singularity exec -B /beegfs-scratch -B /data -B /projects /projects/wp2/nobackup/Twist_Myeloid/Containers/bwa0.7.17-samtools-1.9.simg java -Xmx4g -jar /opt/conda/share/picard-2.20.1-0/picard.jar CollectAlignmentSummaryMetrics  VALIDATION_STRINGENCY=LENIENT INPUT=../STAR2/R20-246Aligned.sortedByCoord.out.bam R=/projects/wp4/nobackup/workspace/jonas_test/STAR-Fusion/references/GRCh37_gencode_v19_CTAT_lib_Apr032020.plug-n-play/ctat_genome_lib_build_dir/ref_genome.fa OUTPUT=R20-246.alignment_summary_metrics.txt


rule touchBatch:
    input:
        #expand("DNA_bam/{sample}-ready.bam", sample = config["DNA_Samples"])
        expand("STAR2/{sample}Aligned.sortedByCoord.out.bam", sample = config["RNA_Samples"])
    output:
         temp("qc/batchQC_stats_unsorted.csv")
    log:
        "logs/touch.log"
    shell:
        "(touch {output}) &> {log}"

rule getStatsforMqc:
    input:
        #picardDup = "qc/{sample}/{sample}_DuplicationMetrics.txt", #Not running this step in picard
        picardMet = "qc/{sample}/{sample}.HsMetrics.txt",
        samtools = "qc/{sample}/{sample}.samtools-stats.txt",
        #multiQCheader = config["programdir"]["dir"]+"src/qc/multiqc-header.txt",
        multiQCheader = "DATA/multiqc-header.txt",
        cartool = "qc/{sample}/{sample}_Log.csv",
        batch =  "qc/batchQC_stats_unsorted.csv"
    output:
        batchTmp = temp("qc/{sample}/{sample}_batchStats.done"),
        # batch = "qc/{seqID}_stats_mqc.tsv",
        sample = "qc/{sample}/{sample}_stats_mqc.csv"
    #params:
    #    dir = config["programdir"]["dir"]
    log:
        "logs/qc/{sample}_stats.log"
    singularity:
        config["singularity"]["python"]
    shell:
        #"(python3.6 get_stats.py {input.picardDup} {input.picardMet} {input.samtools} {input.multiQCheader} {input.cartool} {wildcards.sample} {output.sample} {input.batch} && touch {output.batchTmp}) &> {log}"
        "(python3.6 src/get_stats.py {input.picardMet} {input.samtools} {input.multiQCheader} {input.cartool} {wildcards.sample} {output.sample} {input.batch} && touch {output.batchTmp}) &> {log}"

rule sortBatchStats:
    input:
        SampleSheetUsed = config["Sample_sheet"],
        batchUnsorted = "qc/batchQC_stats_unsorted.csv",
        batchDone = expand("qc/{sample}/{sample}_batchStats.done", sample = config["RNA_Samples"])
    output:
        batch =  "qc/batchQC_stats_mqc.json"
    #params:
    #    dir = config["programdir"]["dir"]
    log:
        "logs/qc/sortBatch_Stats.log"
    singularity:
        config["singularity"]["python"]
    shell:
        "(python3.6 src/sortBatchStats.py {input.batchUnsorted} {input.SampleSheetUsed} {output.batch}) &> {log}"
