# Install necessary dependencies
sudo apt-get upgrade
sudo apt install python3-pip
pip3 install awscli

# Download files
cd ~
mkdir monthly && cd monthly
aws s3 sync s3://newsclustering ./

# Extract files
sudo apt-get install unzip
find -name '*.zip' -exec sh -c 'unzip -q -d "${1%.*}" "$1"' _ {} \;

# cat + gzip
rm ~/monthly/*/*gz
find . -maxdepth 1 -mindepth 1 -type d -printf '%f\n' -exec sh -c 'cd $1 && find -type f -name "*.json" | xargs sed $"s/$/\\\n/g" | pigz --stdout > ${1}.json.gz' _ {} \;
cd ~
mkdir -p webhose-monthly-gz && cd webhose-monthly-gz
mv ../monthly/*/*gz .
aws s3 sync ./ s3://newsclustering/webhose-monthly-gz

# install spark
cd ~
mkdir -p software && cd software
wget https://d3kbcqa49mib13.cloudfront.net/spark-2.1.1-bin-hadoop2.7.tgz
tar -zxvf spark-2.1.1-bin-hadoop2.7.tgz
cd spark-2.1.1-bin-hadoop2.7

# install java
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer

./bin/spark-shell --driver-memory 6G --master local[2]

