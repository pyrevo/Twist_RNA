
configfile: "Twist_RNA.yaml"

def get_input():
    input_list = []
    if config["RNA_Samples"] != "No RNA" :
        '''Demultiplexning'''
        input_list.append(["fastq/RNA/" + s + "_R1.fastq.gz" for s in config["RNA_Samples"]])
        input_list.append(["fastq/RNA/" + s + "_R2.fastq.gz" for s in config["RNA_Samples"]])

        '''Fusions'''
        input_list.append(["STAR/" + s + "Aligned.sortedByCoord.out.bam" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/Fusions/" + s + ".Arriba.HighConfidence.fusions.tsv" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/Fusions/" + s + ".Arriba.fusions.pdf" for s in config["RNA_Samples"]])
        input_list.append(["STAR2/" + s + "Chimeric.out.junction" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/Fusions/star-fusion.fusion_predictions.tsv" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/Fusions/star-fusion.fusion_predictions.abridged.tsv" for s in config["RNA_Samples"]])
        input_list.append(["fusioncatcher_" + s + "/final-list_candidate-fusion-genes.hg19.txt" for s in config["RNA_Samples"]])

        '''Imbalance'''
        input_list.append("Results/RNA/Imbalance/imbalance_all_gene.txt")
        input_list.append("Results/RNA/Imbalance/imbalance_called_gene.txt")

        '''Exon skipping'''
        input_list.append("Results/RNA/Exon_skipping/exon_skipping.txt")

        '''QC'''
        #input_list.append(["Results/RNA/" + s + "/Housekeeping_gene_coverage.txt" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/QC/RSeQC_bam_stat.txt" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/QC/RSeQC.clipping_profile.r" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/QC/RSeQC.deletion_profile.r" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/QC/RSeQC.insertion_profile.r" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/QC/RSeQC.DupRate_plot.r" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/QC/RSeQC.GC_plot.r" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/QC/RSeQC.inner_distance_plot.r" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/QC/RSeQC_read_distribution.txt" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/QC/RSeQC.junction_plot.r" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/QC/RSeQC.geneBodyCoverage.r" for s in config["RNA_Samples"]])
        input_list.append(["Results/RNA/" + s + "/QC/RSeQC.FPKM.xls" for s in config["RNA_Samples"]])
        input_list.append("Results/RNA/Bam_stats.txt")

        '''QC2'''
        #input_list.append(["qc/" + s + "/" + s + "_Stat_table.csv" for s in config["DNA_Samples"]])
        #input_list.append(["qc/" + s + "/" + s + "-sort_fastqc.html" for s in config["DNA_Samples"]])
        #input_list.append(["qc/" + s + "/" + s + "-sort_fastqc.zip" for s in config["DNA_Samples"]])
        #input_list.append(["qc/" + s + "/" + s + ".samtools-stats.txt" for s in config["DNA_Samples"]])
        #input_list.append(["qc/" + s + "/" + s + ".HsMetrics.txt" for s in config["DNA_Samples"]])
        #input_list.append(["qc/" + s + "/" + s + "_stats_mqc.csv" for s in config["DNA_Samples"]])
        #input_list.append("qc/batchQC_stats_mqc.json")
        #input_list.append("qc/batchQC_stats_unsorted.csv")
        #input_list.append("Results/DNA/MultiQC.html")

    return input_list

rule all:
    input:
        get_input()


include: "src/Snakemake/workflow/Twist_RNA_workflow.smk"
