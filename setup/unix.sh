if hash apt-get 2>/dev/null; then
  apt-get update -qq >/dev/null && apt-get install -qq apt-utils imagemagick python3-pip python3-setuptools build-essential
elif hash pacman 2>/dev/null; then
  pacman -Syu imagemagick python-pip glibc lib32-glibc base-devel --noconfirm
elif hash dnf 2>/dev/null; then
  dnf install -y ImageMagick python3-pip @development-tools
# elif hash brew 2>/dev/null; then
#  brew list imagemagick || brew install imagemagick
#  brew list python3 || brew install python3
else 
  echo -e "Please install Imagemagick and python3-pip "
fi
pip3 install wheel --user
pip3 install lektor --user
