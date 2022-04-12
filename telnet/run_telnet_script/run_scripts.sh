#/bin/bash

BASEDIR=$(dirname "$0")

PROPERTY_FILE=$BASEDIR/config.properties

function getProperty {
  PROP_KEY=$1
  PROP_VALUE=`cat $PROPERTY_FILE | grep "$PROP_KEY" | cut -d'=' -f2`
  echo $PROP_VALUE
}

echo "# Reading property from $PROPERTY_FILE"
if [ -f "$PROPERTY_FILE" ]; then
  PROP_PASSWORD=$(getProperty "PASSWORD")
else
  echo "Senha não encontrada."

  exit 1
fi

TIMESTAMP_INICIO=`date "+%Y%m%d_%H%M%S"`
mkdir "$TIMESTAMP_INICIO"

cat switches_cisco.txt | while read line || [[ -n $line ]]
do
  if [[ -n "${line// /}" ]]; then
    echo $line
    TIMESTAMP=`date "+%Y%m%d_%H%M%S"`
    #echo $TIMESTAMP
    LOGFILE="$TIMESTAMP_INICIO"/"$line"_"$TIMESTAMP.txt"
    # echo $LOGFILE
    ./run_telnet_script.sh $line $PROP_PASSWORD >> $LOGFILE 2>&1 
   
    cat $LOGFILE
  fi
done
