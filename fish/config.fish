set EDITOR hx

function dotter
    cd ~/.dotfiles
    command dotter $argv
end

function cat
    bat $argv
end

function ls
    exa --color always $argv
end

function find
    fd $argv
end

function grep
    rga $argv
end

#ssh kitten is broken - october
#function ssh
#    kitten ssh $argv
#end

zoxide init fish --cmd cd | source
starship init fish | source
