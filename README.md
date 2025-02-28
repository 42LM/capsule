# capsule
<img src="https://github.com/user-attachments/assets/632b79e3-bac4-47cd-81a8-63267b6e6c0b" width="65" /> <img src="https://github.com/user-attachments/assets/e5375434-186b-4d9a-9a1f-4a67a0e225bc" width="500" />

_**capsule**_ is a simple _single file_ terminal prompt. Display is divided into capsules (`TIMER > DIR > GIT > GIT ACTION`).

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

## Customize
Check the [Customize](https://github.com/42LM/capsule/wiki/Customize-%F0%9F%AA%84) section in the wiki.
