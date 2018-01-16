#!/bin/bash

var1="abc"
var2="def"
echo $var1
echo $var2


#for i in {1..${#var1}}
#do
#echo "Welcome $i times"
#done

#for ((i=0; i<=${#var1}; i++)); do
#    echo "http://example.com/$i.jpg"
#done

var3=""
for ((i=0; i<${#var1}; i++))
do
#var3+=2
#echo $var3
# echo ${var1[i]}:${var2[i]}
# echo ${var1:i}:${var2[i]}
# {var1:i:1}${var2:i:1}
var3+=${var1:i:1}${var2:i:1}
done
echo $var3
# supply string as an argument

####### reversed! #######
#!/bin/bash

var1="abc"
var2="def"
echo $var1
echo $var2


#for i in {1..${#var1}}
#do
#echo "Welcome $i times"
#done

#for ((i=0; i<=${#var1}; i++)); do
#    echo "http://example.com/$i.jpg"
#done

var3=""
for ((i=0; i<${#var1}; i++))
do
#var3+=2
#echo $var3
# echo ${var1[i]}:${var2[i]}
# echo ${var1:i}:${var2[i]}
# {var1:i:1}${var2:i:1}
var3+=${var1:i:1}${var2:i:1}
done
echo $var3
