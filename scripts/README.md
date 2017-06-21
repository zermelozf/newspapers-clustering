# Prepare the data 

## Extract 

```shell 
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
```

## Transform into format usable with Spark

```shell
# cat + gzip
rm ~/monthly/*/*gz
find . -maxdepth 1 -mindepth 1 -type d -printf '%f\n' -exec sh -c 'cd $1 && find -type f -name "*.json" | xargs sed $"s/$/\\\n/g" | pigz --stdout > ${1}.json.gz' _ {} \;
cd ~
mkdir -p webhose-monthly-gz && cd webhose-monthly-gz
mv ../monthly/*/*gz .
aws s3 sync ./ s3://newsclustering/webhose-monthly-gz
```

## Verify that everything is working

```shell
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
```
Using bin/spark-shell

```scala
// Check all files can be loaded
val testJsonData = spark.read.json("/home/ubuntu/monthly/2725_webhose-2016-05_20170610012555/2725_webhose-2016-05_20170610012555.json.gz")
testJsonData.show(10)

import java.io.File
def getFullPathOfFiles(dir: File):Seq[String] = dir.listFiles.filter(f => f.isFile && f.getName().endsWith(".json.gz")).map(_.getAbsolutePath()).toSeq

getFullPathOfFiles(new File("/home/ubuntu/webhose-monthly-gz")).foreach(
    spark.read.json(_).show(1)
)
```
