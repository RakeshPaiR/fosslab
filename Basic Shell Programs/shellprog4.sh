if [[ $# != 2 ]]; then
	echo "Wrong input!!! Input as:./addnames ulist username "
else
	count=$(ls | grep $1 | wc -l)
	if [[ $count -eq 0 ]]; then
		echo "$1 File doesn't exist"
	else
		count=`grep "$2" $1| wc -l`
		if [[ $count -eq 0 ]];then
		echo "username doesn't exist. Adding username to $1"
		echo "$2" >> $1
		else 
		echo "username already exists"
		fi
	fi
	cat ulist.txt
fi