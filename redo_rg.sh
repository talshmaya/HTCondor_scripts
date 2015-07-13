file=$1
i=$2
bam_uuid="${file#*.}"
path=${file%/*}
dir=${path##/*/}
#extension="${file#*.}"
if [ -z "$(/mnt/scratch/samtools-0.1.19/samtools view -H $file | grep BCM:0)" ]
    then
        echo no BCM:0 in $file. skipping
    else
        echo dir is $dir
        #sudo chmod 777 /home/ubuntu/gfs/ancestry/european_ucsc_bams/$dir/$bam_uuid
        echo New RG will be BCM:$i , written to /home/ubuntu/gfs/ancestry/european_ucsc_bams/$dir/$bam_uuid
        time /mnt/scratch/samtools-0.1.19/samtools view -h $file | sed 's/BCM:0/BCM:'$i'/g' | /mnt/scratch/samtools-0.1.19/samtools view -bS - > /home/ubuntu/gfs/ancestry/european_ucsc_bams/$dir/$bam_uuid
        cat $file.calibration | sed 's/BCM:0/BCM:'$i'/g'  > /home/ubuntu/gfs/ancestry/european_ucsc_bams/$dir/$bam_uuid.calibration
        echo indexing $file ...
        time ~/rtg-core-3.4.5/rtg index -f bam /home/ubuntu/gfs/ancestry/european_ucsc_bams/$dir/$bam_uuid
       fi
