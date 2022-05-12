PS3='請選擇：'
select i in 1 2 3 4 5 6
do
 echo "$i $REPLY"
 break
done