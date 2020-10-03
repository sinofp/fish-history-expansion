function fish-history-expansion --on-event fish_command_not_found \
    --description="Mimic Bash's HISTORY EXPANSION"
    if string match --quiet --invert '!*' $argv
        return # command not started with '!'
    end
    set input (string sub --start 2 $argv)

    set i 1
    while string match --quiet --invert '' "$history[$i]"
        if string match --quiet "$input*" "$history[$i]"
            echo "$history[$i]"
            eval "$history[$i]"
            return
        end
        set i (math "$i+1")
    end
end

