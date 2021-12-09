#!/usr/bin/env sh


# Set Variables
ao='=' # assignment operator
KC='\x1b[1;32m' # Key Color
VC='\x1b[1;31m' # Previous Value Color
NC='\x1b[0m' # No Color


# Usage Help Function
usage(){
  printf "Usage: $0 [options] Path Key Value

  Info    It will return error code 5 if not found anything to change.

  Options
    -h    show this help message
    -q    assign in quotes (like XML, HTML tag properties). Only one assignment per line.
    -c    use colon as assignment operator instead of '=' character.
    -t    only show what would be exchanged, without changes
"  1>&2
  exit 0
}


# Get the options and execute them
while getopts ":qcth" arg; do
case $arg in
  q ) quotes=1;;
  c ) ao=':';;
  t ) testing=1;;
  h ) usage;;
  \? )
    echo "[change_config] Invalid Option: -$OPTARG. Use -h to show usage." 1>&2
    exit 1
    ;;
  esac
done
shift $((OPTIND -1))


# Check argument quantity
if [[ $# -ne 3 ]]; then
  echo "[change_config] Must have 3 arguments. Use -h to show usage."
  exit 1
fi


# Set 'pattern', 'replacement' and 'highlight'
if [[ "$quotes" == 1 ]];
  then

    # Matching
    # 1: Is the start of a line or a non-word character (A-z1-9_)
    # 2: The 'key' argument plus a '=' character
    # 3: A " or a '
    # #: Every character until the last same " or ' found
    pattern="\(\W\|^\)\($2$ao\)\(\"\|'\)\(.*\)\3"
    replacement="\1\2\3$3\3"
    highlight="\1${KC}\2\3${VC}\4${KC}\3"
  else

    # Matching
    # 1: Is the start of a line with 0 or more spaces
    # 2: The 'key' argument, 0 or more spaces, '=' character
    # #: Every character until the end of line
    pattern="^\( *\)\($2 *$ao\)\(.*\)"
    replacement="\1\2$3"
    highlight="\1${KC}\2${VC}\3"
fi


# Execute test or changes
if [[ "$testing" == 1 ]];
  then sed -s '/'"${pattern}"'/,${s/'"${pattern}"'/'${highlight}${NC}'/;b};$q5' $1
  else sed -i -s '/'"${pattern}"'/,${s//'"${replacement}"'/;b};$q5' $1
fi
