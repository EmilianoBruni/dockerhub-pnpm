# Setup a red prompt for root and a yellow one for users.

_normal=$'\e[0m'
if [ "$USER" = root ]; then
        _color=$'\e[1;31m'
        _color_path=$'\e[1;35m'
        _symbol='#'
else
        _color=$'\e[1;33m'
        _color_path=$'\e[1;32m'
        _symbol='$'
fi
if [ -n "$ZSH_VERSION" ]; then
        PS1="%{$_color%}%m [%{$_normal%}%~%{$_color%}]$_symbol %{$_normal%}"
else
        PS1="\[$_color\]\u@\h:\[$_color_path\]/\W\[$_color\]$_symbol\[$_normal\] "
fi
unset _normal _color _symbol _color_path