
# useradd tom
# groupadd hr
# passwd tom
# usermod -aG hr tom
# cat /etc/passwd |grep -w tom 
# cat /etc/shadow |grep -w tom
# id tom


AWK_COMMAND=`cat /etc/passwd |grep -w tia |awk -F":" '{print$1}'`
CUT_COMMAND=$(cat /etc/passwd |grep -w tia |cut -d":" -f1)

FIRST_NAME="Ola"
LAST_NAME="Smith"
AGE="40"
PASSWORD="12345"


echo $AWK_COMMAND
echo $CUT_COMMAND

echo "The user in passwd file with AWK is: $AWK_COMMAND"
echo "The user in passwd file with CUT is: $CUT_COMMAND"

echo $FIRST_NAME
echo $LAST_NAME

echo "My first name is $FIRST_NAME and my last name is $LAST_NAME, and I am $AGE year old. My password is $PASSWORD"



## =========================================================
word1="apple"
word2="banana"

if [ "$word1" = "$word2" ]; then
    echo "The words are equal."
else
    echo "The words are not equal."
fi

if [ "$AWK_COMMAND" = "tia" ]; then
    echo "The user exist and his username is $AWK_COMMAND" 
else
    echo "The user does not exist"
fi


## =========================================================
USER=`cat /etc/passwd |grep -w laurent |awk -F":" '{print$1}'`

if [ "$USER" = "laurent" ]; then
    echo "The user exist and his username is $USER" 
else
    echo "The user does not exist"
    useradd laurent
    passwd laurent
    usermod -aG hr laurent
    cat /etc/passwd |grep -w laurent
    cat /etc/shadow |grep -w laurent
    id laurent
fi


## =========================================================
UNAME_WITH_AWK=$(uname -a |awk -F" " '{print$3}' |awk -F"-" '{print$1}' |awk -F '.' '{print $1"."$2}')
UNAME_WITH_CUT=$(uname -a |awk -F" " '{print$3}' |awk -F"-" '{print$1}' |cut -d"." -f1-2)

echo $UNAME_WITH_AWK
echo $UNAME_WITH_CUT

echo "The user in passwd file with AWK is: $UNAME_WITH_AWK"
echo "The user in passwd file with CUT is: $UNAME_WITH_CUT"


## =========================================================
CENTOS_DISTRO=$(cat /etc/os-release |grep -w ID |awk -F'"' '{print$2}')
UBUNTU_DISTRO=$(cat /etc/os-release |grep -w ID |awk -F"=" '{print$2}')

echo $CENTOS_DISTRO
echo $UBUNTU_DISTRO

echo "The OS distro is: $CENTOS_DISTRO"
echo "The OS distro is: $UBUNTU_DISTRO"


## =========================================================

FREE_AWK=$(free -h |grep -i mem |awk -F" " '{print$7}')
echo $FREE_AWK

DF_AWK=$(df -h |grep overlay |awk -F" " '{print$5}')
echo $DF_AWK

if [ "$DF_AWK" = "80%" ]; then
    echo "The filesystem check passed."
elif [ "$DF_AWK" \< "80%" ]; then
    echo "The filesystem check passed, and this is perfect."
else
    echo "The filesystem check failed."
fi


AGE="17"

if [ "$AGE" -eq 18 ]; then
    echo "You you are eligible to drive."
elif [ "$AGE" -gt 18 ]; then
    echo "It look like you have been driving already."
elif [ "$AGE" -eq 17 ]; then
    echo "You still have 1  more year to go"
else
    echo "You cannot drive"
fi