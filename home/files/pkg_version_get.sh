# get package version

BRANCH=$1
PATH_TO_FILE=$2

curl -s https://raw.githubusercontent.com/NixOS/nixpkgs/refs/heads/$BRANCH/pkgs/$PATH_TO_FILE | rg -o --color=never 'version.*=.*"(.*)";' --replace '$1'
