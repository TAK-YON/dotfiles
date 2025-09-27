set EDITOR hx

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

zoxide init fish --cmd cd | source
starship init fish | source
