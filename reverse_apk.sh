#!/bin/bash 

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DARE="/dare/dare"
JAD="/jad/jad"

function useage {
  echo " "
  echo " "
  echo "Author:Hong Wang"
  echo "E-mail:wanghong230@gmail.com"
  echo "Description:The program was designed to do batch processsing which turn all the apk files in directroy to be java projects."
  echo " "
  echo " "
  echo "Useage: ./reverse_apk.sh <output dir> <dex or apk file directory>"
  echo " <output dir>: set the output dir to hold .class and .java files"
  echo " <dex or apk file directory>: set the dir that holds apks files"
  echo " "
  exit
}

function dareapk {
  $DIR$DARE -d $1 $2 -c
}

function jadjava {
  $DIR$JAD -o -r -sjava -d $1"/src/" $2"/retargeted/**/*.class"
}

function process_one_apk {
  dareapk $1 $2
  jadjava $1 $1 
}

#check number of arugmenets
if [ -z "$1" ]; then 
  useage
  exit
fi

echo $1
echo $2


# process_one_apk $1 $2
for i in $(find $2 -type f |grep "apk"); do
    echo item: $i
    fname=$(basename $i)
    process_one_apk $1$fname $i
done


