function git-prune --description "Prune git local branches where the remote no longer exists"
    if test (git rev-parse --abbrev-ref HEAD) != "master"
        echo "git-prune MUST be run from the master branch. Use 'git checkout master' first"
        false
    else
        for branch in (git branch -vv | grep ': gone]' | awk '{print $1}')
            echo PRUNING BRANCH: $branch
            git branch -D $branch
        end
    end
end
