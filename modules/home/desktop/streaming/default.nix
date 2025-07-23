inputs@{ configs, pkgs, ... }:

let 
	cfg = config.desktop.streaming;
in {
  # imports = [
  # ];

	options.desktop.streaming.enable = lib.mkEnableOption "Enable Streaming";

	config = lib.mkIf cfg.enable {
		programs.obs-studio.enable = true;
		programs.obs-studio.enableVirtualCamera = true;

  	# home.packages = with pkgs; [
  	# ];

		# TODO: custom module code to store my stream settings? or store it into a persist dir
	};
}
