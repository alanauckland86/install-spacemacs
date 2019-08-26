#!/bin/bash

# Run this script with the command
# sudo ./install-spacemacs-master/install-spacemacs.sh

# Install Git
echo "Checking for Git installation."

if ! [ -x "$(command -v git)" ]; then
    echo "Git is not installed. \\n Installing Git now..."
    apt-get install git -y
    echo "Git has been installed" "$(command -v git)"
else
    echo "Skipping git instalation. Already installed.\\n"
fi

echo "Checking for Emacs installation"

if ! [ -x "$(command -v emacs)" ]; then
    echo 'Emacs is not installed.\\n Installing Emacs now...'
    $(apt-get install emacs -y)
    echo "Emacs has been installed" "$(command -v emacs)"
else
    echo "Skipping Emacs instalation. Arealdy installed.\\n"
fi

echo "Checking for font Source Code Pro"

if ! [ fc-list | grep -i "SourceCodePro" > /dev/null ]; then
    echo "Font Source Code Pro not found in ~/.fonts.\\n\\n Installing Source Code Pro font. "
    $(git clone https://github.com/adobe-fonts/source-code-pro.git ~/.fonts)

   SOURCE_CODE_PRO=$(fc-list | grep -i "SourceCodePro" > /dev/null);
   echo 'Font Source Code Pro installed to ~/.fonts ' 
else
    echo 'Font Source Code Pro already installed.\\n'
fi

echo "Checking for Spacemacs instalation"

if ! [-f ".spacemacs" ]; then
    $(git clone -b develop https://github.com/syl20bnr/spacemacs ~/.emacs.d)
else
    echo "~/.spacemacs already exists"
fi

#Take ownership
chown -R $SUDO_USER:$SUDO_USER ~/.fonts
chown -R $SUDO_USER:$SUDO_USER ~/.emacs.d
