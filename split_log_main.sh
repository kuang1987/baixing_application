#!/bin/bash

log_file=$1
process=$2
con1=$3
con2=$4
con3="$5"
echo $con3
target_dir="./final_log"
source_dir="./split_log"
rm -rf $target_dir $source_dir
mkdir $target_dir $source_dir
first_line_size=`head -1 $log_file | wc -c`
echo $first_line_size
last_line_size=`tail -2 $log_file | head -1 | wc -c`
echo $last_line_size
avg_line_size=$[first_line_size+last_line_size]
avg_line_size=$[avg_line_size/2]
echo $avg_line_size
file_size=`ls -l $log_file | awk '{print $5}'`
app_line_num=$[file_size/avg_line_size]
echo $app_line_num
split_line_num=$[app_line_num/process]
echo $split_line_num

cd $source_dir
split -l $split_line_num "../"$log_file
a=`ls`
cd -
for file in $a
do
{
/bin/bash ./split_log_sub.sh $source_dir"/"$file $con1 $con2 "$con3" $target_dir
}&
done
wait

echo "file process done, begin to compress"
cd $target_dir
files=`ls`
for file in $files
do
{
   tar -cjf $file".bz2" $file --remove-files $file
}&
done
wait



