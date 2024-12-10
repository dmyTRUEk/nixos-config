# subscribe to package version upgrade

BRANCH=$1
PATH_TO_FILE=$2
OLD_VERSION=$3

while true; do
	CURRENT_VERSION=$(curl -s https://raw.githubusercontent.com/NixOS/nixpkgs/refs/heads/$BRANCH/pkgs/$PATH_TO_FILE | rg -o --color=never 'version\s*=\s*"(.*)";' --replace '$1')

	if [[ "$CURRENT_VERSION" != "$OLD_VERSION" ]]; then
		echo "New version available: $CURRENT_VERSION"
		break
	fi

	echo "Currently available version: $CURRENT_VERSION; waiting..."

	sleep 10m
done

notify-send 'Upgrade available!' "$PATH_TO_FILE @ $BRANCH : $OLD_VERSION -> $CURRENT_VERSION"
