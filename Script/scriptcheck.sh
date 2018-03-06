rm s1_result.txt s2_result.txt s1s2.txt
# result_MDL.pdf adn S2_result_MDL.pdf has S1 and S2 result respectively as University published
pdftotext -layout result_MDL.pdf result_MDL.txt
grep -A 1 "MDL16CS" result_MDL.txt > result_MDL_CS.txt
pdftotext -layout S2_result_MDL.pdf S2_result_MDL.txt
grep -A 1 "MDL16CS" S2_result_MDL.txt > S2_result_MDL_CS.txt
# c4b.txt file has student names, roll no., admission no., as well as KTU ID
grep "MDL16" c4b.txt > c4b_reg.txt
awk '{print $6}' c4b_reg.txt > c4b_regno.txt
awk '{print $7 " " $8 " " $9}' c4b_reg.txt > names.txt
sed 's/--//' result_MDL_CS.txt > prores.txt
sed 's/\o14//g' prores.txt > prores1.txt
sed '/^\s*$/d' prores1.txt > prores2.txt
awk 'NR%2{printf "%s ",$0;next;}1' prores2.txt > proresmain.txt
join proresmain.txt c4b_regno.txt > S1_result.txt
sed 's/\(MA101\|PH100\|BE110\|BE10105\|BE103\|EE100\|PH110\|EE110\|CS110\|,\)//g' S1_result.txt > S1_grades.txt

sed 's/--//' S2_result_MDL_CS.txt > S2_prores.txt
sed 's/\o14//g' S2_prores.txt > S2_prores1.txt
sed '/^\s*$/d' S2_prores1.txt > S2_prores2.txt
awk 'NR%2{printf "%s ",$0;next;}1' S2_prores2.txt > S2_proresmain.txt
join S2_proresmain.txt c4b_regno.txt > S2_result.txt
sed 's/\(CY100\|BE100\|EC100\|CY110\|EC110\|MA102\|BE102\|CS100\|\bCS120\b\|,\)//g' S2_result.txt > S2_grades.txt

join S1_grades.txt S2_grades.txt > year_1.txt
sed 's/ /\t/g' year_1.txt >year_1_1.txt
credit=( 4 4 3 3 3 3 1 1 1 4 4 3 1 1 4 3 3 1 )
while read -r line
do
	score=0;count=0;total1=0;total2=0;
	for word in $line
	do
		if [[ $word == MDL16CS* ]]; then
			continue;
		else
			num=${credit[count++]};
			case $word in
				"(O)")  score=$(( 10*$num ));;
				"(A+)") score=$(( 9*$num ));;
				"(A)") score=$(bc <<< "scale=4; $num*8.5");;
				"(B+)") score=$(( 8*$num ));;
				"(B)") score=$(( 7*$num ));;
				"(C)") score=$(( 6*$num ));;
				"(P)")  score=$(( 5*$num ));;
				*) score=0;;
			esac
			 sed "0,/$word/s//$score/" year_1.txt> year_1_2; cp year_1_2 year_1.txt

			if [[ $count -le 9 ]];then
				total1=$(bc <<< "scale=4; $total1+$score" )
				if [[ $count == 9 ]];then
					bc <<< "scale=4; $total1/23" >> s1_result.txt
				fi
			else
				total2=$(bc <<< "scale=4;$total2+$score" )
				if [[ $count == 18 ]];then
					bc <<< "scale=4; $total2/24" >> s2_result.txt
					paste s1_result.txt s2_result.txt | awk '{print ((($1 * 23) + ($2 * 24))/47), $3}' > s1s2.txt
					paste c4b_regno.txt s1_result.txt s2_result.txt s1s2.txt names.txt | column -s $'\t' -t > Y1_result.txt
				fi
			fi

		fi
	done
done < year_1_1.txt
awk 'BEGIN{print "Reg. ID     S1 GPA  S2 GPA   CGPA         Name"}; {print}' Y1_result.txt > RESULT.txt
xdg-open RESULT.txt