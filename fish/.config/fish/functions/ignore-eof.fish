function ignore-eof
    # If IGNOREEOF is not set, exit immediately
    if ! set -q IGNOREEOF
        exit 0
    end

    # _EofLast tracks if the last "command" was a Ctrl-D
    if ! set -q _EofLast
        set -g _EofLast "EOF"
    end

    # If _EofCount is not set, create it
    if ! set -q _EofCount
        set -g _EofCount 1
    end

    # Notifier function to track commands between Ctrl-D
    function _UpdateEofLast --on-event fish_postexec
        set -g _EofLast (history -n1 -R)
    end

    # If the last "command" wasn't EOF, reset the count
    if test "$_EofLast" != "EOF"
        set -g _EofCount 1
    end

    # If we received more EOFs than IGNOREEOF, exit
    if test "$_EofCount" -gt $IGNOREEOF
        exit 0
    end

    # Increment _EofCount
    set _EofCount (math "$_EofCount + 1")

    # Set last "command" to be EOF
    set _EofLast "EOF"

    # Bash does this so make it look the same
    echo 'Use "exit" to leave the shell.'

    # Repaint the command line
    commandline -f repaint
end
