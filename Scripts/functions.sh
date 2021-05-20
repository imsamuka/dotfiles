# This is my custom functions file
# It is far from perfect, but have some things i use daily

mysum () {

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


showcolors () {
for x in {0..8}; do for i in {30..37}; do for a in {40..47}; do echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "; done; echo; done; done; echo ""
}

lscolors () {

declare -A descriptions=(
    [bd]="block device"
    [ca]="file with capability"
    [cd]="character device"
    [di]="directory"
    [do]="door"
    [ex]="executable file"
    [fi]="regular file"
    [ln]="symbolic link"
    [mh]="multi-hardlink"
    [mi]="missing file"
    [no]="normal non-filename text"
    [or]="orphan symlink"
    [ow]="other-writable directory"
    [pi]="named pipe, AKA FIFO"
    [rs]="reset to no color"
    [sg]="set-group-ID"
    [so]="socket"
    [st]="sticky directory"
    [su]="set-user-ID"
    [tw]="sticky and other-writable directory"
)

IFS=:
for ls_color in $LS_COLORS; do
    color="${ls_color#*=}"
    type="${ls_color%=*}"

    # Add description for named types.
    desc="${descriptions[$type]}"

    # Separate each color with a newline.
    if [[ $color_prev ]] && [[ $color != "$color_prev" ]]; then
        echo
    fi

    printf "\e[%sm%s%s\e[m " "$color" "$type" "${desc:+ ($desc)}"

    # For next loop
    color_prev="$color"
done
echo
}

wacom_pressure () {
sudo evtest /dev/input/event16 | grep -i pressure
}
