command_exists () {
    type "$1" &> /dev/null ;
}

if command_exists ruby
then
  echo "ruby already installed"
else
  echo "ruby does not exist. Installeding rvm"

  if ! [ command_exists curl ]
  then
    echo "curl does not exist. please grant sudo priveleges to install curl via apt-get"
    if [[ ! $(sudo echo 0) ]]; then exit; fi
    sudo apt-get -y install curl
  fi

  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  \curl -sSL https://get.rvm.io | bash -s stable --ruby --auto-dotfiles

  #exec bash
  #gem install colorize
fi

# get locatin of script (self)
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"


BASHRC="${HOME}/.bashrc"

if grep -q "moomake.sh" $BASHRC
then
  echo "~/.bashrc already has alias for moomake. Will not modify it."
else
  echo "" >> $BASHRC
  echo "mk () {" >> $BASHRC
  echo "  ${DIR}/moomake.sh \$@" >> $BASHRC
  echo "}" >> $BASHRC
fi


echo "Please restart shell to use ruby and moomake"
