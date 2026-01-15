#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Load generic environment variables
if [ -f ~/.profile ]; then
    . ~/.profile
fi
