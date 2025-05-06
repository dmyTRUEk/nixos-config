# subscribe to package version upgrade

BRANCH=$1
PATH_TO_FILE=$2
OLD_VERSION=$3

while true; do
	CURRENT_VERSION=$(sh $HOME/.config/home-manager/home/files/pkg_version_get.sh $BRANCH $PATH_TO_FILE)
	echo $CURRENT_VERSION

	if [[ "$CURRENT_VERSION" != "$OLD_VERSION" ]]; then
		echo "New version available: $CURRENT_VERSION"
		break
	fi

	echo "Currently available version: $CURRENT_VERSION; waiting..."

	sleep 10m
done

notify-send 'Upgrade available!' "$PATH_TO_FILE @ $BRANCH : $OLD_VERSION -> $CURRENT_VERSION"
