#! /bin/bash
# #! - shebang - specify which interpreter to use, and 
# the first line of any shell scripts should always be this line

#6. The file test operators

####################################################################################################################################################################################

#5. If statement

#the syntax

# if [ condition ]  #note the whitespace surrounding the condition
# then
#     statement
# fi # end of the if statement

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


