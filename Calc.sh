echo "Enter first number: "
read x
echo "Enter second number: "
read y
a='y'
while [ $a == 'y' ]
do
	echo -e "1.Addition\n2.Subtraction\n3.Multiplication\n4.Division\n5.Modulus"
	echo -e "Enter your choice: "
	read m
	case "$m" in
		"1") echo $(($x+$y));;
		"2") echo $(($x-$y));;
		"3") echo $(($x*$y));;
		"4") if [ $y == 0 ] 
			 then
				echo "Division by zero not allowed";
			 else
			 	echo $(($x/$y));
			 fi;;
		"5") if [ $y == 0 ]
			 then
			 	echo "Division by zero not allowed";
			 else
			 	echo $(($x%$y));
			 fi;;
		*)
		echo "Invalid choice!!!";;
	esac
	echo "Do you want to continue??(y/n)"
	read a
done