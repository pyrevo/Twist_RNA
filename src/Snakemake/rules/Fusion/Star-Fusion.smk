

rule STAR:
    input:
        fq1 = "fastq/RNA/{sample}_R1.fastq.gz",
        fq2 = "fastq/RNA/{sample}_R2.fastq.gz"
    output:
        alignment = "STAR2/{sample}Chimeric.out.junction",
        bam = "STAR2/{sample}Aligned.sortedByCoord.out.bam",
        bai = "STAR2/{sample}Aligned.sortedByCoord.out.bam.bai"
    params:
        index = config["reference"]["STAR"],
        star_fusion_singularity = "singularity exec -B /projects/ -B /scratch/ " + config["singularity"]["STAR_fusion"],
        samtools_singularity = "singularity exec -B /projects/ -B /scratch/ "  + config["singularity"]["samtools"]
    threads: 5
    shell:
        "{params.star_fusion_singularity} STAR "
        "--genomeDir {params.index} "
        "--readFilesIn {input.fq1} {input.fq2} "
        "--outReadsUnmapped None "
        "--twopassMode Basic "
        "--readFilesCommand \"gunzip -c\" "
        "--outSAMstrandField intronMotif "  # include for potential use with StringTie for assembly
        "--outSAMtype BAM SortedByCoordinate "
        "--outSAMattrRGline ID:Twist_RNA SM:{wildcards.sample} PL:ILLUMINA "
        "--outSAMunmapped Within "
        "--chimSegmentMin 12 "  # ** essential to invoke chimeric read detection & reporting **
        "--chimJunctionOverhangMin 12 "
        "--chimOutJunctionFormat 1 "   # **essential** includes required metadata in Chimeric.junction.out file.
        "--alignSJDBoverhangMin 10 "
        "--alignMatesGapMax 100000 "   # avoid readthru fusions within 100k
        "--alignIntronMax 100000 "
        "--alignSJstitchMismatchNmax 5 -1 5 5 "   # settings improved certain chimera detections
        "--chimMultimapScoreRange 3 "
        "--chimScoreJunctionNonGTAG -4 "
        "--chimMultimapNmax 20 "
        "--chimNonchimScoreDropMin 10 "
        "--peOverlapNbasesMin 12 "
        "--peOverlapMMp 0.1 "
        "--runThreadN {threads} "
        "--outFileNamePrefix STAR2/{wildcards.sample} && "
        "{params.samtools_singularity} samtools index {output.bam}"

rule STAR_Fusion:
    input:
        alignment = "STAR2/{sample}Chimeric.out.junction"
    output:
        fusion1 = "STAR_fusion/{sample}/Fusions/star-fusion.fusion_predictions.tsv",
        fusion2 = "STAR_fusion/{sample}/Fusions/star-fusion.fusion_predictions.abridged.tsv"
    params:
        ref = config["reference"]["STAR_fusion"],
    singularity:
        config["singularity"]["STAR_fusion"],
    threads: 5
    shell:
        #"singularity exec -B /projects/ -B /scratch/ /projects/wp4/nobackup/workspace/somatic_dev/singularity/star-fusion.v1.7.0.simg "
        "/usr/local/src/STAR-Fusion/STAR-Fusion "
        "--genome_lib_dir {params.ref} "
        "-J {input.alignment} "
        "--output_dir STAR_fusion/{wildcards.sample}/Fusions/ "
        "--CPU {threads}"

rule Copy_to_results:
    input:
        #STAR_fusion1 = "STAR_fusion/{sample}/Fusions/star-fusion.fusion_predictions.tsv",
        STAR_fusion2 = "STAR_fusion/{sample}/Fusions/star-fusion.fusion_predictions.abridged.tsv"
    output:
        #STAR_fusion1 = "Results/RNA/{sample}/Fusions/star-fusion.fusion_predictions.tsv",
        STAR_fusion2 = "Results/RNA/{sample}/Fusions/star-fusion.fusion_predictions.abridged.tsv"
    shell:
        #"cp {input.STAR_fusion1} {output.STAR_fusion1} && "
        "cp {input.STAR_fusion2} {output.STAR_fusion2}"
