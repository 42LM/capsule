# capsule
Simple ZSH prompt with git support.

> [!CAUTION]
> 🚧 Work in progress 🚧

## Quickstart
Install
```sh
curl --create-dirs -o ~/.config/zsh/capsule/cap.zsh \
https://raw.githubusercontent.com/42LM/capsule/main/cap.zsh
```

Import (`.zshrc`)
```zsh
# only load prompt if the `bb.zsh` file exists
[ -f $HOME/.config/zsh/capsule/cap.zsh ] && \
source $HOME/.config/zsh/capsule/cap.zsh
```

Default setup:
```sh
CAPSULE_PROMPT_PROJECTS_PATH="${HOME}/code"
CAPSULE_PROMPT_PROJECTS=true
CAPSULE_PROMPT_TIMER=false

CAPSULE_PROMPT_GIT_AHEAD_BEHIND_FG="0"   # black
CAPSULE_PROMPT_GIT_ACTION_FG="3"         # yellow
CAPSULE_PROMPT_GIT_ACTION_BG="9"         # orange
CAPSULE_PROMPT_GIT_TAG_FG="1"            # red
CAPSULE_PROMPT_GIT_FG="1"                # red
CAPSULE_PROMPT_GIT_BG="3"                # yellow
CAPSULE_PROMPT_GIT_COUNT_ST_STASH_FG="3" # yellow
CAPSULE_PROMPT_GIT_COUNT_ST_STASH_BG="9" # orange
CAPSULE_PROMPT_GIT_DIRTY_FG="3"          # yellow
CAPSULE_PROMPT_GIT_DIRTY_BG="1"          # red
CAPSULE_PROMPT_DIR_FG="0"                # black
CAPSULE_PROMPT_DIR_BG="4"                # blue
CAPSULE_PROMPT_TIMER_FG="0"              # black
CAPSULE_PROMPT_TIMER_BG="6"              # cyan

CAPSULE_PROMPT_STAGED_SIGN="*"
CAPSULE_PROMPT_UNSTAGED_SIGN="+"
CAPSULE_PROMPT_TIMER_SIGN=" "
CAPSULE_PROMPT_DELIMTER=""
CAPSULE_PROMPT_SIGN="󱞩"
```
