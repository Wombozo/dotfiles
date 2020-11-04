function b
    /usr/bin/batcat $argv
end

function fd
    /usr/bin/fdfind $argv
end

function gr
    grep -rIin -e $argv
end

function g
    git $argv
end

function l
    exa -l $argv
end

function top
    ytop
end

function ps
    procs
end

function xo
    xdg-open .
end

function funcdel
    if test -e ~/.config/fish/functions/$argv[1].fish
        rm ~/.config/fish/functions/$argv[1].fish
        echo 'Deleted function:' $argv[1]
    else
        echo 'Not found function:' $argv[1]
    end
end

funcsave funcdel cdb cdbb cdbm fd b gr g l top ps xo
