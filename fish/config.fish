set PATH $PATH ~/.local/bin
set --erase fish_greeting

if type -q starship
    starship init fish | source
end
