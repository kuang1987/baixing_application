#/bin/bash

filename=$1
con1=$2
con2=$3
con3="$4"
target_dir=$5
cat $filename | grep -v "$con3" | fgrep $con1 | awk -vdir=$target_dir -vpipe=$con1 'BEGIN{c="";d="";ccc=""}
                             {
                                split($4,array,":");
                                b=substr(array[1],2,12);
                                if(c!=b){
                                c=b;
                                split(b,dd,"/");
                                "date +%Y-%m-%d -d" dd[1]"-"dd[2]"-"dd[3] | getline d;
                                close("date")};
                                print $0 >> dir"/"pipe"."d".log"
                                }
                                END{}' &
cat $filename | grep -v "$con3" | fgrep $con2 | awk -vdir=$target_dir -vpipe=$con2 'BEGIN{c="";d="";ccc=""}
                             {
                                split($4,array,":");
                                b=substr(array[1],2,12);
                                if(c!=b){
                                c=b;
                                split(b,dd,"/");
                                "date +%Y-%m-%d -d" dd[1]"-"dd[2]"-"dd[3] | getline d;
                                close("date")};
                                print $0 >> dir"/"pipe"."d".log"
                                }
                                END{}' &
wait
