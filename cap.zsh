# CAP - Capsule zsh prompt -- Prompt in capsules
# Maintainer:   Lukas Moeller <github.com/42LM/capsule>
# Version:      1.0.0
#
# ℹ️  Get more Information:
#   https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information
#
# 📃 Blueprint:
#   https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples

## Defining variables
! [ -v CAPSULE_PROMPT_PROJECTS_PATH ] && CAPSULE_PROMPT_PROJECTS_PATH="${HOME}/code"
# disable checking only in the subtree of CAPSULE_PROMPT_PROJECTS_PATH
# by setting CAPSULE_PROMPT_PROJECTS to false
! [ -v CAPSULE_PROMPT_PROJECTS ] && CAPSULE_PROMPT_PROJECTS=false
# show elapsed time (first bubble)
! [ -v CAPSULE_PROMPT_TIMER ] && CAPSULE_PROMPT_TIMER=false

! [ -v CAPSULE_PROMPT_GIT_AHEAD_BEHIND_FG ] && CAPSULE_PROMPT_GIT_AHEAD_BEHIND_FG="0" # black
! [ -v CAPSULE_PROMPT_GIT_ACTION_FG ] && CAPSULE_PROMPT_GIT_ACTION_FG="3" # yellow
! [ -v CAPSULE_PROMPT_GIT_ACTION_BG ] && CAPSULE_PROMPT_GIT_ACTION_BG="9" # orange
! [ -v CAPSULE_PROMPT_GIT_TAG_FG ] && CAPSULE_PROMPT_GIT_TAG_FG="1" # red
! [ -v CAPSULE_PROMPT_GIT_FG ] && CAPSULE_PROMPT_GIT_FG="1" # red
! [ -v CAPSULE_PROMPT_GIT_BG ] && CAPSULE_PROMPT_GIT_BG="3" # yellow
! [ -v CAPSULE_PROMPT_GIT_COUNT_ST_STASH_FG ] && CAPSULE_PROMPT_GIT_COUNT_ST_STASH_FG="3" # yellow
! [ -v CAPSULE_PROMPT_GIT_COUNT_ST_STASH_BG ] && CAPSULE_PROMPT_GIT_COUNT_ST_STASH_BG="9" # orange
! [ -v CAPSULE_PROMPT_GIT_DIRTY_FG ] && CAPSULE_PROMPT_GIT_DIRTY_FG="3" # yellow
! [ -v CAPSULE_PROMPT_GIT_DIRTY_BG ] && CAPSULE_PROMPT_GIT_DIRTY_BG="1" # red
! [ -v CAPSULE_PROMPT_DIR_FG ] && CAPSULE_PROMPT_DIR_FG="0" # black
! [ -v CAPSULE_PROMPT_DIR_BG ] && CAPSULE_PROMPT_DIR_BG="4" # blue
! [ -v CAPSULE_PROMPT_TIMER_FG ] && CAPSULE_PROMPT_TIMER_FG="0" # black
! [ -v CAPSULE_PROMPT_TIMER_BG ] && CAPSULE_PROMPT_TIMER_BG="6" # cyan
! [ -v CAPSULE_PROMPT_DELIMTER_FG ] && CAPSULE_PROMPT_DELIMTER_FG="12" # grey

! [ -v CAPSULE_PROMPT_STAGED_SIGN ] && CAPSULE_PROMPT_STAGED_SIGN="*"
! [ -v CAPSULE_PROMPT_GIT_SIGN ] && CAPSULE_PROMPT_GIT_SIGN="󰘬 "
! [ -v CAPSULE_PROMPT_GIT_TAG_SIGN ] && CAPSULE_PROMPT_GIT_TAG_SIGN="󱈤 "
! [ -v CAPSULE_PROMPT_UNSTAGED_SIGN ] && CAPSULE_PROMPT_UNSTAGED_SIGN="+"
! [ -v CAPSULE_PROMPT_TIMER_SIGN ] && CAPSULE_PROMPT_TIMER_SIGN=" "
! [ -v CAPSULE_PROMPT_DELIMTER ] && CAPSULE_PROMPT_DELIMTER=""
! [ -v CAPSULE_PROMPT_SIGN ] && CAPSULE_PROMPT_SIGN="󱞩"

## vim:ft=zsh

### Running vcs_info ######################################################### {{{

# Mark vcs_info for autoloading first
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

# Allow substitutions and expansions in the prompt, necessary for
# using a single-quoted $vcs_info_msg_0_ in PS1, RPOMPT (as used here) and
# similar. Other ways of using the information are described above.
setopt promptsubst

# Default to running vcs_info. If possible we prevent running it later for
# speed reasons. If set to a non empty value vcs_info is run.
FORCE_RUN_VCS_INFO=1

# Only run VCS when vcs is git.
zstyle ':vcs_info:*+pre-get-data:*' hooks pre-get-data
+vi-pre-get-data() {
    # Only Git and Mercurial support need caching.
    # For simplicity only Git support for caching is enabled.
    # Abort if any other VCS except Git is used.
    [[ "$vcs" != git ]] && return

    # If the shell just started up or we changed directories (or for other
    # custom reasons) we must run vcs_info.
    if [[ -n $FORCE_RUN_VCS_INFO ]]; then
        FORCE_RUN_VCS_INFO=
        return
    fi
}

function preexec() {
    timer=$(print -P %D{%s})
}

# Call vcs_info as precmd before every prompt.
prompt_precmd() {
    if [ $timer ]; then
        now=$(print -P %D{%s})
        elapsed=$(($now-$timer))

        unset timer
    else
        elapsed="0"
    fi

    # first run the system so everything is setup correctly.
    vcs_info

    # only show the elapsed timer capsule when set
    # defaults to `false`
    elapsedtime=""
    if ${CAPSULE_PROMPT_TIMER}; then
      elapsedtime="%(?.%F{${CAPSULE_PROMPT_TIMER_BG}}%K{${CAPSULE_PROMPT_TIMER_BG}}%F{${CAPSULE_PROMPT_TIMER_FG}}${CAPSULE_PROMPT_TIMER_SIGN}${elapsed}s%f%F{${CAPSULE_PROMPT_TIMER_BG}}%k%f.%F{red}%K{red}%F{yellow} ${elapsed}s%f%F{red}%k%f)%F{${CAPSULE_PROMPT_DELIMTER_FG}}${CAPSULE_PROMPT_DELIMTER}%f"
    fi
    dir="%F{${CAPSULE_PROMPT_DIR_BG}}%K{${CAPSULE_PROMPT_DIR_BG}}%F{${CAPSULE_PROMPT_DIR_FG}}%(3~|../%2~|%~)%f%F{${CAPSULE_PROMPT_DIR_BG}}%k%f"
    successfulcommand="%(?.%F{2}${CAPSULE_PROMPT_SIGN}.%F{1}${CAPSULE_PROMPT_SIGN})%f" # green OK / red FAILURE

    # Only populate PS1 with vcs_info when the vcs_info_msg'es length is not zero
    if [[ -z ${vcs_info_msg_0_} ]]; then
        PS1=$'\n''${elapsedtime}${dir}'$'\n''${successfulcommand} '
    else
        PS1=$'\n''${elapsedtime}${dir}%F{${CAPSULE_PROMPT_DELIMTER_FG}}${CAPSULE_PROMPT_DELIMTER}%f${vcs_info_msg_0_}%k'$'\n''${successfulcommand} '
    fi
}
add-zsh-hook precmd prompt_precmd

# Must run vcs_info when changing directories.
prompt_chpwd() {
    FORCE_RUN_VCS_INFO=1
}
add-zsh-hook chpwd prompt_chpwd

############################################################################## }}}

### check-for-changes just in some places #################################### {{{

# For more information about the method of enabling `check-for-changes` only in a certain subtree:
#
# https://github.com/zsh-users/zsh/blob/c006d7609703afcfb2162c36d4f745125df45879/Misc/vcs_info-examples#L72-L105
#
# only enable the `check-for-changes` in `CAPSULE_PROMPT_PROJECTS_PATH`
# when `CAPSULE_PROMPT_PROJECTS` is set to true
if ${CAPSULE_PROMPT_PROJECTS}; then
    zstyle -e ':vcs_info:git:*' \
        check-for-changes 'estyle-cfc && reply=( true ) || reply=( false )'
else
    # activate checking for changes in general
    # using `check-for-staged-changes` is faster here
    # https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information:~:text=disabled%20by%20default.-,check%2Dfor%2Dstaged%2Dchanges,-This%20style%20is
    zstyle ':vcs_info:git:*' check-for-changes true
fi

estyle-cfc() {
    local d
    local -a cfc_dirs
    cfc_dirs=(
        ${CAPSULE_PROMPT_PROJECTS_PATH}/*(/)
    )

    for d in ${cfc_dirs}; do
        d=${d%/##}
        [[ $PWD == $d(|/*) ]] && return 0
    done
    return 1
}

############################################################################## }}}

### Hooks #################################################################### {{{

# Debugging is off by default - of course.
# zstyle ':vcs_info:*+*:*' debug true

# Check the repository for changes so they can be used in %u/%c (see
# below). This comes with a speed penalty for bigger repositories.
# ⚠️ function estyle-cfc() already sets check-for-changes for my directory ⚠️
# check if projects option is enabled
# zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:*' get-revision true

# Alternatively, the following would set only %c, but is faster:
# zstyle ':vcs_info:*' check-for-changes false
# zstyle ':vcs_info:*' check-for-staged-changes true

# This string will be used in the %c escape if there are staged changes in the repository.
zstyle ':vcs_info:git*' stagedstr "${CAPSULE_PROMPT_STAGED_SIGN}"
zstyle ':vcs_info:git*' unstagedstr "${CAPSULE_PROMPT_UNSTAGED_SIGN}"

zstyle ':vcs_info:git*' formats "%F{${CAPSULE_PROMPT_GIT_BG}}%F{${CAPSULE_PROMPT_GIT_FG}}%K{${CAPSULE_PROMPT_GIT_BG}}%B${${CAPSULE_PROMPT_GIT_SIGN}}%b%f%k"

zstyle ':vcs_info:git*' patch-format "%K{${CAPSULE_PROMPT_GIT_ACTION_BG}}%B%n/%c %p%%b%k%F{${CAPSULE_PROMPT_GIT_ACTION_BG}}%f%k"
# zstyle ':vcs_info:git*' nopatch-format ""

zstyle ':vcs_info:git*' actionformats "%F{${CAPSULE_PROMPT_GIT_BG}}%F{${CAPSULE_PROMPT_GIT_FG}}%K{${CAPSULE_PROMPT_GIT_BG}}${${CAPSULE_PROMPT_GIT_SIGN}}%B%b%%b%F{${CAPSULE_PROMPT_DELIMTER_FG}}${CAPSULE_PROMPT_DELIMTER}%F{${CAPSULE_PROMPT_GIT_ACTION_BG}}%F{${CAPSULE_PROMPT_GIT_ACTION_FG}}%K{${CAPSULE_PROMPT_GIT_ACTION_BG}}%B󱞭 %a%%b %m%f%k"

### ORDER HERE MATTERS

# if ${whatever}; then
    zstyle ':vcs_info:git*+set-message:*' hooks git-st git-count git-tag git-stash git-branch
# TODO: possibility to disable tag?
# else
#     zstyle ':vcs_info:git*+set-message:*' hooks git-st git-count git-branch git-stash
# fi

# for debug purposes activate this instead: check out the keys of the hook_com var
# zstyle ':vcs_info:git*+set-message:*' hooks git-st git-count git-tag git-branch git-stash show-hook-keys


# Further down, every function that uses a `+vi-*' prefix uses a hook.

# git:

### SHOW hook_com keys <- debug purposes
#
# Output the key value pairs of hook_com
# zstyle ':vcs_info:git*+set-message:*' hooks show-hooks-keys
+vi-show-hook-keys() {
    # Check for key names
    for key val in "${(@kv)hook_com}"; do
        echo "$key -> $val"
    done
}

### Put a space between the branchname and the staged/unstaged sign
### when one of staged or unstaged is set
### %b%c%u -> %b %c%u
### git: Show marker (*) if git branch is dirty
### git: Show marker (+) if git branch has unstaged changes

# Make sure you have added staged to your 'formats':  %c and %u
# zstyle ':vcs_info:git*+set-message:*' hooks git-branch
+vi-git-branch(){
    if [[ ${hook_com[staged]} != '' ]] ||
        [[ ${hook_com[unstaged]} != '' ]]; then
        if [[ ${hook_com[misc]} != '' ]] && [[ ${hook_com[action]} == '' ]]; then
            hook_com[branch]+="%b%F{${CAPSULE_PROMPT_GIT_COUNT_ST_STASH_BG}}%K{${CAPSULE_PROMPT_GIT_COUNT_ST_STASH_BG}}%F{${CAPSULE_PROMPT_GIT_COUNT_ST_STASH_FG}}${hook_com[misc]}%F{${CAPSULE_PROMPT_GIT_DIRTY_FG}}%B%F{${CAPSULE_PROMPT_GIT_DIRTY_BG}}%K{${CAPSULE_PROMPT_GIT_DIRTY_FG}}%K{${CAPSULE_PROMPT_GIT_DIRTY_FG}}%F{${CAPSULE_PROMPT_GIT_DIRTY_BG}}%K{${CAPSULE_PROMPT_GIT_DIRTY_FG}}%K{${CAPSULE_PROMPT_GIT_DIRTY_BG}}%F{${CAPSULE_PROMPT_GIT_DIRTY_FG}}%B${hook_com[staged]}${hook_com[unstaged]}%k%f%F{${CAPSULE_PROMPT_GIT_DIRTY_BG}}%f%b"
        else
            hook_com[branch]+="%B%F{${CAPSULE_PROMPT_GIT_DIRTY_BG}}%K{${CAPSULE_PROMPT_GIT_DIRTY_FG}}%K{${CAPSULE_PROMPT_GIT_DIRTY_FG}}%F{${CAPSULE_PROMPT_GIT_DIRTY_BG}}%K{${CAPSULE_PROMPT_GIT_DIRTY_FG}}%K{${CAPSULE_PROMPT_GIT_DIRTY_BG}}%F{${CAPSULE_PROMPT_GIT_DIRTY_FG}}%B${hook_com[staged]}${hook_com[unstaged]}%k%f%F{${CAPSULE_PROMPT_GIT_DIRTY_BG}}%f%b"
        fi
    else
        if [[ ${hook_com[misc]} != '' ]] && [[ ${hook_com[action]} == '' ]]; then
            hook_com[branch]+="%b%F{${CAPSULE_PROMPT_GIT_COUNT_ST_STASH_BG}}%K{${CAPSULE_PROMPT_GIT_COUNT_ST_STASH_BG}}${hook_com[misc]}%k%F{${CAPSULE_PROMPT_GIT_COUNT_ST_STASH_BG}}%f"
        else
            hook_com[branch]+="%k%F{${CAPSULE_PROMPT_GIT_BG}}%f"
        fi
    fi
}

### Fetch the git tag for branch
### git: show (v.0.11.0) behind branchname if branch has tag
#
# Make sure you have added branch to your formats:  %b
# zstyle ':vcs_info:git*+set-message:*' hooks git-tag
+vi-git-tag(){
    local tag=$(git name-rev --name-only --no-undefined --always HEAD)
    if [[ -n ${tag} ]] && [[ ${tag} =~ [0-9] ]] && [[ ${tag[@]:0:4} == "tags" ]]; then
        hook_com[branch]+=" %F{${CAPSULE_PROMPT_GIT_TAG_FG}}${${CAPSULE_PROMPT_GIT_TAG_SIGN}}${tag[6, -1]}%f"
    else
        # due to unexpected behaviour when not finding a tag
        # the hook_com branch will be set to empty string value
        hook_com[branch]+=""
    fi
}

### Display changed file count on branch
### git: Show marker (±N) if count exists
#
# Make sure you have added misc to your 'formats':  %m
# zstyle ':vcs_info:git*+set-message:*' hooks git-count
+vi-git-count() {
    local -a changed_file_count

    # only display changed file count on branch when action is empty
    if [[ ${hook_com[action]} == '' ]]; then
        changed_file_count=$(git status -sb | wc -l)
        changed_file_count="$(($changed_file_count - 1))"
        if [[ ${changed_file_count} != 0 ]]; then
            hook_com[misc]+="%F{${CAPSULE_PROMPT_GIT_COUNT_ST_STASH_FG}}±${changed_file_count}%f"
        fi
    fi
}

### Display count of stash
### git: Show marker (≡N) if stash exists
#
# Make sure you have added misc to your 'formats':  %m
# zstyle ':vcs_info:git*+set-message:*' hooks git-stash
+vi-git-stash() {
    local -a stash

    # only display changed file count on branch when action is empty
    if [[ ${hook_com[action]} == '' ]]; then
        if [[ -s ${hook_com[base]}/.git/refs/stash ]] ; then
            stash=$(git stash list 2>/dev/null | wc -l | xargs)
            n=${stash}
            if [[ -n ${stash} ]]; then
                stash='≡'
            fi
            hook_com[misc]+="%F{${CAPSULE_PROMPT_GIT_COUNT_ST_STASH_FG}}${stash}${n}%f"
        fi
    fi
}

### Compare local changes to remote changes
### git: Show ⇡N/⇣N when your local branch is ahead-of or behind remote HEAD.
#
# Make sure you have added misc to your 'formats':  %m
# zstyle ':vcs_info:git*+set-message:*' hooks git-st
+vi-git-st() {
    local ahead behind
    local -a gitstatus

    # only display changed file count on branch when action is empty
    if [[ ${hook_com[action]} == '' ]]; then
        # Exit early in case the worktree is on a detached HEAD
        git rev-parse ${hook_com[branch]}@{upstream} >/dev/null 2>&1 || return 0

        local -a ahead_and_behind=(
            $(git rev-list --left-right --count HEAD...${hook_com[branch]}@{upstream} 2>/dev/null)
        )

        ahead=${ahead_and_behind[1]}
        behind=${ahead_and_behind[2]}


        if (( $ahead )) && (( $behind )); then
            gitstatus+=( "%F{${CAPSULE_PROMPT_GIT_AHEAD_BEHIND_FG}}⇡${ahead}/%f" )
            gitstatus+=( "%F{${CAPSULE_PROMPT_GIT_AHEAD_BEHIND_FG}}⇣${behind}%f" )
        else
            (( $ahead )) && gitstatus+=( "%F{${CAPSULE_PROMPT_GIT_AHEAD_BEHIND_FG}}⇡${ahead}%f" )
            (( $behind )) && gitstatus+=( "%F{${CAPSULE_PROMPT_GIT_AHEAD_BEHIND_FG}}⇣${behind}%f" )
        fi

        hook_com[misc]+=${(j::)gitstatus}
    fi
}

### Show information about patch series
### git: show 2/4 (number of applied patches/number of unapplied patches)
#
# This is used with with git rebases and conflicts.
#
# All these cases have a notion of a "series of patches/commits" that is being
# applied.  The following shows the information about the most recent patch to
# have been applied:
# Make sure you have added the name of the top-most applied patch to your 'formats':  %p
zstyle ':vcs_info:*+gen-applied-string:*' hooks gen-applied-string
+vi-gen-applied-string() {
    local conflicted_file_count=$(git ls-files --unmerged | cut -f2 | sort -u | wc -l | Xargs)
    hook_com[applied-string]+="±${conflicted_file_count}"
    ret=1
}

############################################################################## }}}

# vim: set foldmethod=marker foldlevel=0:
