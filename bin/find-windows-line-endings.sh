
grep -qIUlr $(printf '\r') .
RESULT=$?
#echo "RESULT: '$RESULT'"

if [ $RESULT -eq 0 ]; then	
  echo "These files contain Windows line endigs:";
  grep -IUlr $(printf '\r') .
else
	echo "No Windows line endings";
fi
