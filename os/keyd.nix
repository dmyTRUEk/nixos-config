{
	lib,
	pkgs,
	...
}:
let
	# KDE layout index:
	#   0 = English
	#   1 = Ukrainian
	# check by `nix-shell -p kdePackages.qttools` -> `qdbus org.kde.keyboard /Layouts org.kde.KeyboardLayouts.getLayout`
	englishLayout = "0";

	qdbus = "${pkgs.kdePackages.qttools}/bin/qdbus";
	dbusMonitor = "${pkgs.dbus}/bin/dbus-monitor";
	keyd = "${pkgs.keyd}/bin/keyd";

	keydKdeLayoutSync = pkgs.writeShellScript "keyd-kde-layout-sync" ''
		set -eu

		get_layout() {
			"${qdbus}" org.kde.keyboard /Layouts org.kde.KeyboardLayouts.getLayout
		}

		enable_english_brackets() {
			"${keyd}" bind reset
			"${keyd}" bind 'main.rightbrace = S-leftbrace'
			"${keyd}" bind 'shift.leftbrace = rightbrace'
			"${keyd}" bind 'shift.rightbrace = S-rightbrace'
		}

		disable_english_brackets() {
			"${keyd}" bind reset
		}

		sync() {
			layout="$(get_layout)"
			echo "KDE layout: $layout"
			if [ "$layout" = "${englishLayout}" ]; then
				echo "Enabling English bracket-braces swaps"
				enable_english_brackets
			else
				echo "Disabling English bracket-braces swaps"
				disable_english_brackets
			fi
		}

		sync

		# KDE emits org.kde.KeyboardLayouts.layoutChanged whenever
		# the actual current layout changes. This also catches the
		# per-window layout changing when focus moves to another window.
		"${dbusMonitor}" \
			--session \
			"type='signal',interface='org.kde.KeyboardLayouts',path='/Layouts',member='layoutChanged'" |
		while IFS= read -r line; do
			case "$line" in
			*"member=layoutChanged"*)
				sync
				;;
			esac
		done
	'';
in
{
	services.keyd = {
		enable = true;
		keyboards.default = {
			ids = [ "*" ];
			settings = {
				global = {
					chord_timeout = 100;
				};
				main = {
					"leftshift+rightshift" = "f13"; # or make it `="tools"` ?   # for keyboard switching
				};
			};
		};
	};

	systemd.user.services.keyd-kde-layout-sync = {
		description = "Synchronize keyd bracket mappings with KDE keyboard layout";
		wantedBy = [ "graphical-session.target" ];
		after = [ "graphical-session.target" ];
		serviceConfig = {
			Type = "simple";
			ExecStart = keydKdeLayoutSync;
			Restart = "on-failure";
			RestartSec = 1;
		};
	};

	systemd.services.keyd-socket-permissions = {
		description = "Set permissions on keyd IPC socket";
		requires = [ "keyd.service" ];
		after = [ "keyd.service" ];
		wantedBy = [ "multi-user.target" ];
		serviceConfig = {
			Type = "oneshot";
			ExecStart = pkgs.writeShellScript "keyd-socket-permissions" ''
				while [ ! -S /run/keyd.socket ]; do
					sleep 0.05
				done
				${pkgs.coreutils}/bin/chgrp keyd /run/keyd.socket
				${pkgs.coreutils}/bin/chmod 660 /run/keyd.socket
			'';
		};
	};

	users.groups.keyd = {};
	users.users.myshko.extraGroups = [ "keyd" ];

	systemd.services.keyd.serviceConfig = {
		RestrictSUIDSGID = lib.mkForce false;
		CapabilityBoundingSet = [
			"CAP_SYS_NICE"
			"CAP_IPC_LOCK"
			"CAP_SETGID"
		];
	};
}
