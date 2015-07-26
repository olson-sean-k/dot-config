function __git_prompt
    set_color green
    echo -n (__git_branch)" "
end

function __git_branch
    set name (git rev-parse --abbrev-ref HEAD ^ /dev/null)
    if [ $status != 0 ]
        return
    end
    if [ $name = HEAD ]
        set name (git rev-parse --short HEAD)
    end

    echo -n $name
end

function __git_mode
    set mode ""
    echo -n "|$mode"
end

function fish_prompt
    set_color cyan
    echo -n (whoami)

    set_color normal
    echo -n "@"

    set_color yellow
    echo -n (hostname)" "

    __git_prompt

    set_color normal
    echo -n "% "
end
