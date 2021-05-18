# This is my custom functions file
# It is far from perfect, but have some things i use daily

code ()
{
dir=$1
/usr/share/vscodium-bin/bin/codium "$dir"
}
alias vscode='code'
alias vscodium='code'

mysum ()
{
local NC='\033[0m'

local Yellow='\033[1;33m'
local Green='\033[1;32m'
local Blue='\033[1;34m'
local Purple='\033[1;35m'
local Cyan='\033[1;36m'
local Red='\033[1;31m'
local Gray='\033[1;90m'


if [[ $color_prev ]] && [[ $color != $color_prev ]]; then
        echo
fi


if [ -z $1 ]
then
    printf "
${Yellow}file${NC} - see file headers
${Yellow}xdd${NC} - see hexadecimal and bynary (-b) of a file
${Yellow}hexdump${NC} - see/edit hexadecimal of a file
${Yellow}less${NC} - (less is more) see file content in parts
${Yellow}head${NC} - show the start of file
${Yellow}tail${NC} - show the end of file. (-10) to limit at 10 lines. (-f) to grab and await changes
${Yellow}glxinfo${NC} - show GPU info, so many info
${Yellow}glxheads${NC} - show GPU info and includes a simple test.

${Cyan}| grep [regex]${NC} - filter lines regex matched. silversearcher-ag is a faster option.
${Cyan}| awk '{}'${NC} - quick language to process text. Filter column 2 for example ('{ print \$2}')

${Red}ln -s item link${NC} - create symbolic link (link -> item)
${Red}rm -Rf dir${NC} - remove dir
${Red}chmod +x a.sh${NC} - gives execution permission to script
${Red}export VAR=\"value\"${NC} - set ambient variable
${Red}systemctl cmd daemon${NC} - send command to daemon
${Red}chmod +x a.sh${NC} - gives execution permission to script

${Purple}psql${NC} - open postgresql shell

${Blue}df -h${NC} - show mounted devices
${Blue}ps aux${NC} - show processes running (static)
${Blue}env${NC} - show all ambient variables
${Blue}unset${NC} - unset ambient variable
${Blue}whoami${NC} - who am i (see user)
${Blue}pwd${NC} - print working directory

${Gray}service daemon cmd${NC} - send command to daemon
${Gray}dpkg -L package${NC} - see what a package contains
\n"
else
    printf "
${Yellow}>${NC}  - write stdout into file
${Yellow}>>${NC} - append stdout into file
${Yellow}|${NC}  - connect stdout into stdin
${Yellow}!!${NC} - get the previous command

${Cyan}Ctrl-R${NC}  - search a command in history
\n"
fi





}


showcolors ()
{
for x in {0..8}; do for i in {30..37}; do for a in {40..47}; do echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "; done; echo; done; done; echo ""
}

lscolors ()
{
IFS=:
for ls_color in $LS_COLORS; do
    color="${ls_color#*=}"
    type="${ls_color%=*}"

    # Add descriptions for named types.
    case "$type" in
    bd) desc="block device" ;;
    ca) desc="file with capability" ;;
    cd) desc="character device" ;;
    di) desc="directory" ;;
    do) desc="door" ;;
    ex) desc="executable file" ;;
    fi) desc="regular file" ;;
    ln) desc="symbolic link" ;;
    mh) desc="multi-hardlink" ;;
    mi) desc="missing file" ;;
    no) desc="normal non-filename text" ;;
    or) desc="orphan symlink" ;;
    ow) desc="other-writable directory" ;;
    pi) desc="named pipe, AKA FIFO" ;;
    rs) desc="reset to no color" ;;
    sg) desc="set-group-ID" ;;
    so) desc="socket" ;;
    st) desc="sticky directory" ;;
    su) desc="set-user-ID" ;;
    tw) desc="sticky and other-writable directory" ;;
    *)  desc="" ;;
    esac

    # Separate each color with a newline.
    if [[ $color_prev ]] && [[ $color != $color_prev ]]; then
        echo
    fi

    printf "\e[%sm%s%s\e[m " "$color" "$type" "${desc:+ ($desc)}"

    # For next loop
    color_prev="$color"
done
echo
}

wacom_pressure ()
{
sudo evtest /dev/input/event16 | grep -i pressure
}
