ln -s $HOME/dotcfg/bashrc $HOME/.bashrc
ln -s $HOME/dotcfg/vimrc $HOME/.vimrc
ln -s $HOME/dotcfg/rtorrent.rc $HOME/.rtorrent.rc
ln -s $HOME/dotcfg/gitconfig $HOME/.gitconfig 

GIT=false
for d in $PATH
  do test -x $d/git && GIT=true
done

if $GIT then
  echo "git found! Setting up git..."
  git config --global user.name "Jamie Harrell"
  git config --global user.email "jharrell@gmail.com"
  git config --global user.ename "jharrell@gmail.com"
  git config --global credential.helper store
else echo "git not found."
fi
