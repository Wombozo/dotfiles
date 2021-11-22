#function top
#    ytop
#end
#
#function ps
#    procs
#end
#
#function funcdel
#    if test -e ~/.config/fish/functions/$argv[1].fish
#        rm ~/.config/fish/functions/$argv[1].fish
#        echo 'Deleted function:' $argv[1]
#    else
#        echo 'Not found function:' $argv[1]
#    end
#end
#
function l
  exa -lT --icons -L 1 $argv[1]
end

function cat
  bat -p --wrap=never --paging=never $argv[1]
end

funcsave l cat
#funcsave funcdel top ps
