#!/bin/bash

FILE=$1
PWLIST=$2

TMP_FILE=/tmp/out

RED='\033[0;31m'
GREEN='\e[42m'
CYAN='\e[44m'
BLUE='\e[104m'
MAG='\e[105m'
NO_COLOR='\033[0m'


check_result_file() {
  RESULT_FILE=$1
  PW=$2

  if [ ! -f "$RESULT_FILE" ]; then
    echo "Nope.."
    echo ""
    return
  fi

  SIZE=`stat -c %s "$RESULT_FILE"`
  TYPE=`file $RESULT_FILE`
  if [ ! "`file $RESULT_FILE`" = "$RESULT_FILE: data" ] && [ $SIZE -ge 1 ]; then

    echo ""
    echo -e "${MAG}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${NO_COLOR}"
    echo -e "${MAG}!!!!!!! FOUND SOMETHING !!!!!!!${NO_COLOR}"
    echo -e "${MAG}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${NO_COLOR}"
    echo ""
    echo -e "Password:  ${GREEN} $PW ${NO_COLOR}"
    echo -e "Result size: ${CYAN} $SIZE ${NO_COLOR}"
    echo -e "Type: ${BLUE} $TYPE ${NO_COLOR}"
    echo ""
    echo "-------------------------------------"
    echo ""
    sleep 2
  else
    echo -e "  ### ${MAG} Probably nothing ${NO_COLOR} | ${RED} data was found ${NO_COLOR} ###"
    echo -e "Result size:${CYAN} $SIZE ${NO_COLOR}( type: ${RED}$TYPE${NO_COLOR} )"
    echo ""
  fi
  rm $RESULT_FILE
  sleep 0.1033
}



echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo "       Cracking started..... "
now=$(date +"%T")
pws=$(wc -l < $PWLIST)
echo "       Began at:  $now"
echo "       With $pws passwords"
echo ""
echo ""


while IFS= read -r line
do
	echo "Trying:  $line   (ECC off)"
	echo "-------------------------------------"
	outguess -r -k $line $FILE $TMP_FILE
	check_result_file $TMP_FILE $line
	sleep 0.1033

	echo "Trying:  $line   (ECC on)"
	echo "-------------------------------------"
	outguess -r -e -k $line $FILE $TMP_FILE
	check_result_file $TMP_FILE $line
	echo ""
	sleep 0.1033
	echo ""

done < "$2"

echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo "       Cracking Complete"
now=$(date +"%T")
echo "       Finished at:  $now"
echo ""

