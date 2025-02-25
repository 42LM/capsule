# capsule
<img src="https://github.com/user-attachments/assets/632b79e3-bac4-47cd-81a8-63267b6e6c0b" width="65" /> <img src="https://github.com/user-attachments/assets/e5375434-186b-4d9a-9a1f-4a67a0e225bc" width="500" />

_**capsule**_ is a simple _single file_ zsh prompt. Display is divided into capsules (`DIR > GIT > GIT ACTION`).

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
# only load prompt if the `cap.zsh` file exists
[ -f "$HOME/.config/zsh/capsule/cap.zsh" ] && \
source "$HOME/.config/zsh/capsule/cap.zsh"
```

Default setup:
```sh
export CAPSULE_PROMPT_PROJECTS_PATH="${HOME}/code"
export CAPSULE_PROMPT_PROJECTS=false
export CAPSULE_PROMPT_TIMER=false

export CAPSULE_PROMPT_GIT_AHEAD_BEHIND_FG="0"   # black
export CAPSULE_PROMPT_GIT_ACTION_FG="3"         # yellow
export CAPSULE_PROMPT_GIT_ACTION_BG="9"         # orange
export CAPSULE_PROMPT_GIT_TAG_FG="1"            # red
export CAPSULE_PROMPT_GIT_FG="1"                # red
export CAPSULE_PROMPT_GIT_BG="3"                # yellow
export CAPSULE_PROMPT_GIT_COUNT_ST_STASH_FG="3" # yellow
export CAPSULE_PROMPT_GIT_COUNT_ST_STASH_BG="9" # orange
export CAPSULE_PROMPT_GIT_DIRTY_FG="3"          # yellow
export CAPSULE_PROMPT_GIT_DIRTY_BG="1"          # red
export CAPSULE_PROMPT_DIR_FG="0"                # black
export CAPSULE_PROMPT_DIR_BG="4"                # blue
export CAPSULE_PROMPT_TIMER_FG="0"              # black
export CAPSULE_PROMPT_TIMER_BG="6"              # cyan
export CAPSULE_PROMPT_DELIMTER_FG="12"          # grey

export CAPSULE_PROMPT_GIT_SIGN="󰘬 "
export CAPSULE_PROMPT_GIT_TAG_SIGN="󱈤 "
export CAPSULE_PROMPT_STAGED_SIGN="*"
export CAPSULE_PROMPT_UNSTAGED_SIGN="+"
export CAPSULE_PROMPT_TIMER_SIGN=" "
export CAPSULE_PROMPT_DELIMTER=""
export CAPSULE_PROMPT_SIGN="󱞩"
```
