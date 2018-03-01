# result_MDL.pdf adn S2_result_MDL.pdf has S1 and S2 result respectively as University published
pdftotext -layout result_MDL.pdf result_MDL.txt
grep -A 1 "MDL16CS" result_MDL.txt > result_MDL_CS.txt
pdftotext -layout S2_result_MDL.pdf S2_result_MDL.txt
grep -A 1 "MDL16CS" S2_result_MDL.txt > S2_result_MDL_CS.txt

# c4b.txt file has student names, roll no., admission no., as well as KTU ID
grep "MDL16" c4b.txt > c4b_reg.txt
awk '{print $6}' c4b_reg.txt > c4b_regno.txt

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
credit=( 4 4 3 3 3 3 1 1 1 4 4 3 1 1 4 3 3 1 )
cp c4b_regno.txt Y1_result.txt

while read line
do
	echo $line
	score=0
	for word in $line
	do
		if [[ $word == MDL16CS* ]];then
			count=0
		else
			case $word in
				"(O)") num=${credit[count]}; echo $num; score=$(( 10*$num )); sed "/^$line/ s/$word/$score/" year_1.txt > year_1_2; cp year_1_2 year_1.txt;;
				"(A+)") num=${credit[count]}; echo $num; score=$(( 9*$num )); sed "/^$line/ s/$word/$score/" year_1.txt > year_1_2; cp year_1_2 year_1.txt;;
				"(A)") num=${credit[count]}; echo $num; score=$(( 8*$num )); sed "/^$line/ s/$word/$score/" year_1.txt > year_1_2; cp year_1_2 year_1.txt;;
				"(B+)") num=${credit[count]}; echo $num; score=$(( 7*$num )); sed "/^$line/ s/$word/$score/" year_1.txt > year_1_2; cp year_1_2 year_1.txt;;
				"(B)") num=${credit[count]}; echo $num; score=$(( 6*$num )); sed "/^$line/ s/$word/$score/" year_1.txt > year_1_2; cp year_1_2 year_1.txt;;
				"(C)") num=${credit[count]}; echo $num; score=$(( 5*$num )); sed "/^$line/ s/$word/$score/" year_1.txt > year_1_2; cp year_1_2 year_1.txt;;
				"(P)") num=${credit[count]}; echo $num; score=$(( 4*$num )); sed "/^$line/ s/$word/$score/" year_1.txt > year_1_2; cp year_1_2 year_1.txt;;
				"(F)") num=${credit[count]}; echo $num; score=$(( 0*$num )); sed "/^$line/ s/$word/$score/" year_1.txt > year_1_2; cp year_1_2 year_1.txt;;
				*);;
			esac
			#echo $score
			#sed -e "/swap/{;s/$word/$score/;:a' '-en;ba' '-e}" <year_1.txt >year_1_points.txt
			#sed "0,/$word/s//$score/" year_1.txt > year_1_points.txt
			#if [[ "$count"%2==0 ]];then sed "0,/$word/s//$score/" year_1.txt | echo ;
			#else
			#	sed "0,/$word/s//$score/" year_1_1.txt > year_1.txt;
			#fi
			let count=count+1;
: <<'COMMENT'
			if [[ $count -le 5 ]];then
				total1=$(($total1+$score))
				if [[ $count == 5 ]];then
					sed -r -e "s/^.{12}/$total1/" Y1_result.txt
				fi
				echo "Hi"					
			else
				total2=$(($total2+$score))
				if [[ $count == 11 ]];then
					sed -r -e 's/^.{15}/$total2/' Y1_result.txt
					sed -r -e 's/^.{18}/$(($total1+$total2))/' Y1_result.txt
				fi
			fi
COMMENT
		fi
	done
done < year_1.txt

shopt -s extglob
#rm -v !("c4b.txt"|"result_MDL.pdf"|"S2_result_MDL.pdf"|"script.sh"|"year_1.txt"|"year_1_2")
#xdg-open year_1.txt
#xdg-open year1_1.txt
