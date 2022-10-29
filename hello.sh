#! /bin/bash
# #! - shebang - specify which interpreter to use, and 
# the first line of any shell scripts should always be this line



#4. How to pass arguments to a script
echo

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


