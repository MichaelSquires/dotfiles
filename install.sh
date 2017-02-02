DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -e ~/.vimrc ]; 
    then 
        echo "[-] Installing symlink: ~/.vimrc -> ${DIR}/vimrc"
        ln -s ${DIR}/vimrc ~/.vimrc
    else echo "[!] ~/.vimrc exists, not overwriting"
fi

if [ ! -e ~/.vim ]; 
    then 
        echo "[-] Installing symlink: ~/.vim -> ${DIR}/vim"
        ln -s ${DIR}/vim ~/.vim
    else echo "[!] ~/.vim exists, not overwriting"
fi

if [ ! -e ~/.tmux.conf ]; 
    then 
        echo "[-] Installing symlink: ~/.tmux.conf -> ${DIR}/tmux.conf"
        ln -s ${DIR}/tmux.conf ~/.tmux.conf
    else echo "[!] ~/.tmux.conf exists, not overwriting"
fi

if [ ! -e ~/.screenrc ]; 
    then 
        echo "[-] Installing symlink: ~/.screenrc -> ${DIR}/screenrc"
        ln -s ${DIR}/screenrc ~/.screenrc
    else echo "[!] ~/.screenrc exists, not overwriting"
fi

BASHRCMOD="source ${DIR}/bashrc.local"
#if `grep -Fxc ${BASHRCMOD} ~/.bashrc 2>&1 /dev/null`;
if grep -Fxq "${BASHRCMOD}" ~/.bashrc;
    then echo "[!] bashrc.local already installed"
    else 
        echo "[-] Installing bashrc.local"
        echo ${BASHRCMOD} >> ~/.bashrc
fi
