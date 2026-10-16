{ pkgs, inputs, ... }: {
	home.packages = with pkgs; [
		# inputs.futhark.packages.${system}.futhark  # conflicts with lean4
		(inputs.futhark.packages.${stdenv.hostPlatform.system}.default.overrideAttrs (old: {
			installPhase = (old.installPhase or "") + ''
				mkdir -p "$out/share/licenses/futhark"
				mv "$out/LICENSE" "$out/share/licenses/futhark/LICENSE"
			'';
		}))

		opencl-headers ocl-icd  # for opencl
		#rocmPackages.clr  # for opencl & hip  # must be specified in project's flake?
		ispc  # for ispc
	];
}
