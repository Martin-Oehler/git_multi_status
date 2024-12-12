git-multi-status() {
    find . -type d -not -path '*/\.git/*' -exec test -e "{}/.git" \; -print | while read repo_dir; do
        (
            cd "$repo_dir"
            out=$(git status -s 2>/dev/null)
            if [ -n "$out" ]; then
                branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "detached")
                echo -e "\n\033[34m${repo_dir} \033[35m(${branch})\033[0m"
                echo "$out"
            fi
        )
    done
}
