function __fish_default_command_not_found_handler
    true
end

function fish-history-expansion --on-event fish_command_not_found \
    --description="Mimic Bash's HISTORY EXPANSION"
    if string match --quiet --invert '!*' $argv[1]
        printf "fish: Unknown command: %s\n" (string escape -- $argv[1]) >&2
        return # command not started with '!'
    end

    if [ 1 -eq (string length "$argv") ]
        return
    end

    set input (string sub --start 2 "$argv")

    set i 1
    while string match --quiet --invert '' "$history[$i]"
        if string match --quiet "$input*" "$history[$i]"
            echo "$history[$i]"
            eval "$history[$i]"
            return
        end
        set i (math "$i+1")
    end
    echo "fish-history-expansion: $argv: event not found"
end

