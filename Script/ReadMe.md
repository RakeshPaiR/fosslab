CGPA Calculation Brief:

	- Get S1 and S2 result pdf file

	- Convert them to text

	- Get students list of CSB 4th sem

	- Calculate SGPA of S1 and S2

	- Calculate CGPA

	- Display them in a file containing Register Number and Name


Detailed Explanation of commands used:

	1. "rm <file1> <file2> <file3>" :

			If present all the above three files are removed because at the end we need to
			append data into them.If we didn't remove it will cause redundancy
	
	2. "pdftotext -layout <sourceFile.pdf> <destinationFile.txt>" :

			Used to convert "sourceFile.pdf" from PDF to "destinationFile.txt" as TEXT file 
			keeping the layout of pdf as it is in the text file also.

	3. "grep -A NUMBER <pattern>" :

			Used to print "NUMBER" lines of trailing context after matching  lines with
			"pattern".
	4. "awk '{print $NUM}'" :

			Used to access all the values in the column no.:"NUM" with field seperator as
			blank space.

	5. "sed 's/--//'" :

			Used to remove "--" which is there after each student entry in the result file.
			What we do with this command is that we replace "--" with NOTHING. Hence thus it
			gets removed.

	6. "sed 's/\o14//g'" :

			Used to remove new Page Indicator(^L). The command is similar to previous(5).

	7. "sed '/^\s*$/d'" :

			Used to remove blank lines.

	8. "awk 'NR%2{printf "%s ",$0;next;}1'" :

			Used to combine 2 lines having result related to same person.

	9. "join <file1> <file2>" :

			This will join 2 files based on matching values. Here files will join based on
			Register Numbers.

	10. "sed 's/<pattern>/<newPattern/g" :

			To replace "pattern" with "newPattern". Here all occurences will be replaced.

	11. "credit=( 4 4 3 3 3 3 1 1 1 4 4 3 1 1 4 3 3 1 )"

			An array named "credit" is created with corresponding values. The value in array
			corresponds to the credit of each subject of 1st year. 1st 9 credits are the
			maximum	credits of S1 and all else are of S2.

	12. "while read -r line"

			While loop is used to iterate through the file. It reads the file line by line and
			and each line is stored in "line". "r" is to indicate that do not treat a
			backslash character in any special way. Consider each backslash to be part of the
       		input line.

    13. "for word in $line"

    		Here for loop is used to iterate through out a line. It will read the "line" line
    		word by word and stored in "word."

    14. What I did inside the loop :

    		- SGPA is calculated with the formula: 
    				SGPA = Σ(Ci×GPi)/ΣCi

					where Ci is the credit assigned for a course
						  GPi is the grade point for that course.

    		- If the "word" is a Register number do nothing, and continue.

    		- Else "num" is stored with the value of credit for that corresponding subject.
    		  We get each subject by counting the word. Each word "count" corresponds to each
    		  subject.

    		- Then corresponding grade scored is accessed and corresponding grade value is
    		  multiplied with "num". It is stored in "score".

    		- In the case of floating point numbers we use Bash Calculator(bc). Scale along
    		  with it is used to specify the precision. 

			- Then grade in the file is replaced by "score".

			- If the grade is of S1( ie.: "count" is less than 9) it is added with "total1",
			  else it is added with S2. 

			- If the count = 9 then  it is the last "score" of S1. Hence append the value of 
			  "total1 divide by 23(total credits of S1)" is appended to the file.

			- If the count = 18 then it is the last "score" of S2. Hence append the value of
			  "total2 divide by 24(total credits of S2)" is appended to the file.

			- Then the CGPA is calculated by formula:
					CGPA = Σ(Ci×GPi)/ΣCi

						where Ci is the credit assigned for a course
							  GPi is the grade point for that course.

			  	CGPA of higher semester is the average of SGPA till that semester 

			- CGPA is calculated here as "total1 + total2 divided by 47(total credits of
			  1st Year) ". It is then pasted into the file containing SGPA of S1 and S2.

			- Then the Register No, S1 GPA, S2 GPA, CGPA, and Name of Student are combined
			  together.

	15. "xdg-open <file1>" :

			"file1" is opened using corresponding software as required by it's type.