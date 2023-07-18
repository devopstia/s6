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

sudo apt update -y
sudo apt install apache2 -y 
cd /var/www/html
rm -rf *

apt install wget -y
apt install unzip -y

wget https://linux-devops-course.s3.amazonaws.com/creative.zip 
unzip creative.zip 
cp -r creative/* .
rm -rf creative.zip
rm -rf creative