# baixing_application

### web日志分隔
1. split_log_main.sh为主文件，调用split_log_sub.sh  
  `/bin/bash split_log_main.sh <logfile> <processnum> "Googlebot" "Baiduspider" "^404"`
2. 主要思路  
  1. 先获取log文件第一行和最后一行的日志大小，取平均，然后根据文件大小估算出log文件总行数。使用总行数除以<processnum>得到分隔行数，以此分隔行数使用split将log文件先分隔为近似processnum个小文件；  
  2. 然后调用sub脚本，后台运行，启动脚本进程个数与分隔文件个数相等，脚本中先使用grep过滤，然后使用awk，由于log文件是按照时间排序的，所以只在上下行日期发生变化时计算目标文件日期名称。  
  3. 最后统一对生成的日志进行压缩，多进程后台运行。

