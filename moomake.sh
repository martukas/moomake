#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then
	PLAYER=afplay       
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	PLAYER=play
	PARAM="-q"
fi

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

ruby ${DIR}/moomake.rb $@

if [ "$?" = 0 ]; then
	${PLAYER} ${DIR}/sounds/cow1.wav ${PARAM}
else
	${PLAYER} ${DIR}/sounds/cat_growl.wav ${PARAM}
fi
