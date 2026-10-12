{ ... }: {
	programs.opencode = {
		enable = true;
		settings = {
			permission = {
				"*" = "ask";
				grep = "ask";
				todowrite = "allow"; # manage todo lists (in opencode itself)
				bash = {
					"*" = "ask";
					"cargo test 2>&1" = "allow";
					"cargo build 2>&1" = "allow";
				};
				read = {
					"*" = "ask";
					"src/*.rs" = "allow";
				};
				edit = {
					"*" = "ask";
					"src/*.rs" = "allow";
				};
			};
		};
	};
}
