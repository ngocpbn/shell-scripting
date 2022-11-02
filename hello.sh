#!/bin/bash
# #! - shebang - specify which interpreter to use, and 
# the first line of any shell scripts should always be this line

# Instead of typing individual commands directly into the terminal, you can put them
# into a script file (with sh extension) and run it using an interpreter.

##########################################################

# HOW TO RUN A SHELL FILE

# To run an sh file, run the following command
# interpreter_name shell_file
# ei: sh script.sh      #run with sh interpreter
# ei: bash script.sh    #run with bash interpreter

# or you can run an sh file using the command ./shell_script_file, but first,
# make sure the file has executable permission (use the command ls -l to check). 
# If not, run the following command to add x permission to it.
# chmod +x shell_file       # +x: add executable permission

###########################################################

# General rules that applies almost everywhere in bash script
# 1. No spaces around the assignment symbol (=)
# 2. Everything is treated as a string in bash script

######################################################################################################################################################################

#17. Read a file content in bash

# To accept input from a file, use input redirection
echo "Read file content using loops"
while read p
do  
    echo $p
done < text.txt
# the content of text.txt will be the input of the while loop. The content of text.txt
# will be put into the p variable. then the echo command will display

echo "The p variable at the end of the loop: "
echo $p    
# prints nothing because the p variable only exists in the above loop. 

# what if you don't use the while loop to read the content in text.txt
echo "Read file content without the loop."
read p < text.txt
echo $p
# It WON'T read the entire content of the file.
# That's why you need the loop.

echo

# The second way is to use pipe
echo "The second method"
cat text.txt | while read p
do  
    echo $p
done

echo "use pipes without the loop to read the input from a file"
cat text.txt | read p       # it seems like the problem with read is: it'll stop reading once it encounters whitespace character
echo $p

# so it doesn't matter whether it's pipe or input redirection, you'll still need the loop

# Internal Field Separator (IFS)
# More about IFS: https://www.baeldung.com/linux/ifs-shell-variable 
# If the file contains special characters like indentation, alignment, etc, you'll need IFS
# IFS is a special variable which determines how bash does word splitting (how to recognize word boundaries) 

test="let's have a test!"
for i in $test
do  echo "$i"
done
# in the for loop above, we can print individual substrings because in IFS, the default values are a space
# tab, and newline

# We can also set custom values for IFS
expression="3;+;5"
# you should always store the old value of IFS like this
old_IFS=$IFS
IFS=';'
read -a tokens <<< $expression

echo ${tokens[0]}
echo ${tokens[1]}
echo ${tokens[2]}

echo -e "\n/etc/host.con"
while read -r line
do  
    echo $line
done < /etc/host.conf

# Once you're done with IFS, restore the default value back
IFS=$old_IFS

echo -e "\nPrinting /etc/host.con with the default IFS"
while read -r line
do  
    echo $line
done < /etc/host.conf

echo 

# Read files using File descriptor
# Follow this link to read more about this method: https://bash.cyberciti.biz/guide/Reads_from_the_file_descriptor_(fd)#Shell_Script_To_Read_File_Line_by_Line 
# To see how the code in the link works, run the script read_file_line_by_line_with_fd.sh

#########################################################################################################################################################################################################3

#15. The WHILE loop

# Syntax
# while [ condition ]
# do 
#     command1
#     command2
#     ...
# done

# How to open terminal using bash script
# terminal_name &
# Ei: gnome-terminal &


number=(1 2 3 'hihi')
counter=0

echo "Loop through the number array"
while [ $counter -lt ${#number[@]} ]
do  
    echo ${number[$counter]}
    ((counter++))       # another syntax: counter=$((counter+1)) or ((counter=counter+1))  
done

##########################################################################################################################################################################################################

#14. Array variables

# Bash supports simple 1-D arrays. Arrays in shell script can contain values of the same
# OR DIFFERENT data types since by default everything in shell script is treated as a string.

# Syntax
# arr_name=(value1 value2 ... valuen)
# NOTE: 
# - No spaces around the = sign
# - No commas between values

number=(1 2 3 'hihi')
echo ${number[@]}
echo ${number[0]}
echo ${number[1]}

# prints the indexes of the array:
echo "The indexes: "${!number[@]}

# prints the length of the array
echo "Array length is" ${#number[@]}

# How to append elements to the end of an array
number[4]='meo'
echo "The array after being appended an element to the end:" ${number[@]}

# Update an existing element
number[2]="replaced_element"
echo "The array after element at index 2 is replaced with a new one" ${number[@]}

# Remove an element from the array
unset number[1]
echo "The indexes after unsetting element at index 1: "${!number[@]}        #prints 0 2 3 4
echo "The array after using unset to remove element at index 1:" ${number[@]}
# It means we can leave a position in the array uninitialized, and it can be at any position.

# How to insert elements into an array
# Note: you can insert new elements at ANY index of the array
number[9]="at index 9"
echo "The indexes after inserting an element at index 9: "${!number[@]}     #prints 0 2 3 4 9
echo "The elements after inserting an element at index 9:" ${number[@]}

number[1]='a new element at index 2'
echo "The indexes after inserting an element at index 1: "${!number[@]}     #prints 0 1 2 3 4 9
echo "The elements after inserting an element at index 1:" ${number[@]}

# Variables can be treated as array, and the value of that variable will be stored at index 0
random_var=aaaaaaaaa
echo "random_var =" ${random_var[@]}
echo "random_var =" ${random_var[1]}        #bc aaaaaaaaa is stored at index 0, so there's nothing at index 1

#################################################################################################################################################################################################################

#12. The case statement

# syntax

# case word in
#    pattern1)
#       Statement(s) to be executed if pattern1 matches
#       ;;
#    pattern2)
#       Statement(s) to be executed if pattern2 matches
#       ;;
#    pattern3)
#       Statement(s) to be executed if pattern3 matches
#       ;;
#    *)
#      Default condition to be executed
#      ;;
# esac

read -p "Enter a character: " character

case $character in
    [a-z] )
        echo "$character is a lowercase character." ;;
   
    [A-Z])
        echo "$character is an uppercase character.";;
        # NOTE: if you enter an uppercase letter but it prints "is a lowercase" instead, you can fix it
        # by running the command "LANG=C"
    
    [0-9])
        echo "$character is a number." ;;

    *)
    echo "Please enter a valid character!" ;;
esac

##########################################################################################################################################################################################################################

#11. Floating points math operations 

# To perform math operations including floating points, use bc - basic calculator

num1=20.5
num2=5

echo 'Using bc - basic calculator'
echo "20.5+5" | bc
echo "20.5-5" | bc
echo "20.5*5" | bc
echo "20.5/5" | bc  # prints 4 instead of 4.1. WHY?
# How to solve the error in division?
echo "scale=2;20.5/5" | bc  # use scale. 2 here specifies how many decimal places to display after the point 
echo "20.5%5" | bc

echo

echo 'Using bc - basic calculator - but with dollar signs and variables as the input of the bc command'
echo "$num1-$num2" | bc
echo "$num1+$num2" | bc

echo

num=4
echo "Square roots"
echo "scale=2;sqrt($num)" | bc -l   # the -l option calls the math library necessary for calculating sqrt
echo

echo "power"
echo "scale=2;3^3" | bc -l
echo
###############################################################################################################################################################################################################3

#10. Perform arithmetic operation

echo 1 + 1  # it'll not perform any calculation. it'll print 1 + 1 to the terminal only
echo $(( 1 + 1 ))

num1=20
num2=4

# syntax #1
echo "Syntax #1"
echo "addition: $(( num1 + num2 ))"
echo "subtraction: $(( num1 - num2 ))"
echo "multiplication $(( num1 * num2 ))"
echo "division: $(( num1 / num2 ))"
echo "floor division: $(( num1 % num2 ))"

echo 

# syntax #2
echo "Syntax #2"
echo "addition: $(expr $num1 + $num2 )"
echo "subtraction: $(expr $num1 - $num2 )"
echo "multiplication $(expr $num1 \* $num2 )"        
# Note that for multiplication, you have to use escape character when using expr command
echo "division: $(expr $num1 / $num2 )"
echo "floor division: $(expr $num1 % $num2 )"

############################################################################################################################################################################

#9. The OR operator

age=5

if [ $age -lt 18 ] || [ $age -gt 22 ]       # method 1: ||
then 
    echo "You're not a college student."
else 
    echo "You're a college student!" 
fi

if [ $age -lt 18 -o $age -gt 22 ]       # method 2: -o
then 
    echo "You're not a college student."
else 
    echo "You're a college student!" 
fi

if [[ $age -lt 18 || $age -gt 22 ]]       # method 3: && and [[]]
then 
    echo "You're not a college student."
else 
    echo "You're a college student!" 
fi

##############################################################################################################################

#8. The AND operator

age=20

if [ $age -gt 18 ] && [ $age -lt 22 ]       # method 1: &&
then 
    echo "You're a college student!"
else 
    echo "You're not a college student."
fi

if [ $age -gt 18 -a $age -lt 22 ]       # method 2: -a
then 
    echo "You're a college student!"
else 
    echo "You're not a college student."
fi

if [[ $age -gt 18 && $age -lt 22 ]]       # method 3: && and [[]]
then 
    echo "You're a college student!"
else 
    echo "You're not a college student."
fi

###################################################################################################################################################################################################3

#7. How to append output to the end of a text file

echo -e "Enter the name of the file: \c"
read file_name

if [ -f $file_name ]
then 
    if [ -w $file_name ]
    then
        echo "Enter something. Press Ctrl + D to stop."
        cat >> $file_name
    else 
        echo "File is not writable. Please choose another file!"
    fi
else 
    echo "File doesn't exist!"
fi

########################################################################################################################################################################################

#6. The file test operators 
# the detailed file test operator reference: https://tldp.org/LDP/abs/html/fto.html)

echo -e "enter the file name: \c"   
# the -e flag combined with the \c symbol allows you to enter the input at the same line of the echo command

read file_name

if [ -e $file_name ]    # the -e flag checks if the file exists
then
    echo "$file_name does exist"
else 
    echo "$file_name doesn't exist!"
fi

if [ -f $file_name ]    # the -f flag checks if the file is a regular file
then
    echo "$file_name is a regular file"
else 
    echo "$file_name is not a regular file!"
fi

if [ -d $file_name ]    # the -d flag checks if the input is a directory or not
then
    echo "$file_name is a directory"
else 
    echo "$file_name isn't a directory!"
fi

# 2 types of files: 
# + block special file - a binary file, a video file, or a image file, music file, etc. 
# + character special file - or a normal file that contains usual text and character

# ei: file_name="/dev/sda2" is a block device
if [ -b $file_name ]    # the -b flag checks if the input is a block device
then
    echo "$file_name is a block device"
else 
    echo "$file_name isn't a block device!"
fi

# ei: file_name="/dev/ttyS1" is a character device
if [ -c $file_name ]    # the -b flag checks if the input is a character device
then
    echo "$file_name is a character device"
else 
    echo "$file_name isn't a character device!"
fi

if [ -s $file_name ]    # the -s flag checks if the file has size greater than 0 
then
    echo "The size of $file_name is greater than 0 - means file is not empty"
else 
    echo "The size of $file_name isn't greater than 0! It means file is empty. It's a blank file!"
fi

if [ -x $file_name ]
then
    echo "$file_name is executable"
else
    echo "$file_name isn't executable"
fi

####################################################################################################################################################################################

#5. If statement

#the syntax

# if [ condition ]  #note the whitespace surrounding the condition
# then
#     statement
# fi # end of the if statement

# IMPORTANT: There must be spaces between operators and operands

# More about comparison operators here: https://tldp.org/LDP/abs/html/comparison-ops.html 

count=10
if [ 1 -eq $count ] #note: if you don't have whitespace (for ei: if [1 -eq $count]), then it'll be a syntax error
then 
    echo "it's true!"
fi

# instead of using -eq (equal), you can use ==
if (( 1 < $count )) #note: if you don't have whitespace (for ei: if [1 -eq $count]), then it'll be a syntax error
then 
    echo "it's true!"
fi

# compare strings 
if [ "abc" == "abc" ]       #you can also use one = too
then
    echo "the strings are indeed equal"
fi

if [[ "a" < "b" ]]
then 
    echo "a is less than b"
fi

# the else clause

if [[ "a" > "b" ]]
then 
    echo "a is greater than b"
else   
    echo "a is less than b!"
fi

num=6

if (( $num > 6 ))
then 
    echo "num is greater than 6"
elif (( $num == 6 ))
then 
    echo "num is equal to 6"
else
    echo "num is less than 6"
fi

##########################################################################################################################################################################################3

#4. How to pass command-line arguments to a script

##### The 1st way to pass command line arguments ####

# the syntax for passing command-line arguments:
# ./shell_file_name arg1 agr2 agr3 .....

# arguments are processed in the order they're sent. The indexing of arguments starts
# at 1, and to access the first argument, use $1, and the same goes to the 2nd and more arguments
echo "Student's name: $1"
echo "ID: $2"
echo "Class: $3"

# so for example, if I pass command line arguments for this file as below:
# ./hello.sh Natalie 21070100 ICE2021A
# the output will be: 

# Student's name: Natalie
# ID: 21070100
# Class: ICE2021A

# the $0 argument is used to access the command that executes the current shell file
# so if you echo $0, the output will be ./hello.sh
echo '$0 =' $0

#### The 2nd way to pass command line arguments - pass arguments into an array ####

# declare an array
args=("$@")     
# $@ is the array of all input, and note that if you leave spaces between = and (, there's gonna be an error

echo ${args[0]} ${args[1]} ${args[2]} ${args[3]}
# so if you pass the command line arguments as "./hello.sh Natalie 21070100 ICE2021A name1 name2 name3 name4 name5"
# There are already some indexing above (echo "Student's name: $1" ....), so you may think
# the line echo ${args[0]} ${args[1]} ${args[2]} ${args[3]} will only print name1 name2 name3 name4 name5
# but no, it actually prints Natalie 21070100 ICE2021A 

# if you want to print all args in the array at one, do this
echo $@

echo $#     #prints the number of command line args that are passed
# if you use the command above, it's gonna be 8

####################################################################################################################

#3. How to read inputs from the terminal

#use the read command

echo "Enter your name: "
read yourName
echo "Your name is $yourName"

read -p "enter your names: " name1 name2 name3  #the -p flag allows you to enter the input in the same line
echo "Name 1: $name1, name2: $name2, name3: $name3"

#if you don't want to show the input of the user, like when we're typing our
# password in the terminal, user the -s flag
read -p "username: " username
read -sp "password: " pass
echo #this echo command is to separate the read pass line and the echo line that prints username
echo "Your username: $username"
echo "Your password: $pass"

#the -a flag will read inputs like an array, and each element is separated with whitespace (blank space for ei)
read -p "Enter names: " -a multiple_names
echo "Name 1: ${multiple_names[0]}"
echo "Name 2: ${multiple_names[1]}"

#if you don't specify any variables after the read command, what will happen?

read -p "What's your favorite restaurant? "

echo $REPLY     
#if you don't specify any variables after the read command, all input will
#be stored in a built-in variable called REPLY

#####################################################################################################

#2. Variables

# Syntax for creating variables
# variable_name=value
# NOTE: no spaces around the = sign

# Shell scripts run from top to bottom, so only use variables after they're created

# To use a variable, place the dollar sign $ in front of the variable name like this:
# $variable_name

# Some types of variables
#type 1: system variable
# created and maintained by your OS
# defined in uppercase
# ei of sys var
echo $BASH
echo $BASH_VERSION
echo $PWD
echo $HOME 

# type 2: user-defined variables
# created and maintained by the users
# note that variable name must not start with numbers
# ei of user-defined vars
name=Natalie
age=19
echo "Hi, it's" $name
echo "I'm" $age

###################################################################################################################

#1. 

echo "Hello World"
# sudo apt-get update


