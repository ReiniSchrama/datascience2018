####### reversed! #######
#!/bin/bash

var1="abc"
var2="def"
echo $var1
echo $var2

var3=""
for ((i=2;i>=0;i++))
do
# echo var3+=2
# echo $var3
# echo ${var1[i]}:${var2[i]}
# echo ${var1:i}:${var2[i]}
# echo ${var1:i:1}${var2:i:1}
 var3+=${var1:i:1}${var2:i:1}
done
echo $var3
