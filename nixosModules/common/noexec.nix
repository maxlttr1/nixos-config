{ lib, config, settings, ... }:

{
  options = {
    noexec.enable = lib.mkEnableOption "Enable noexec mount options for security";
  };

  /*config.fileSystems = lib.mkMerge [
     	(lib.mkIf config.noexec.enable {
    		"/".options = lib.mkAfter [ 
     			"nosuid"
     			"nodev"
     			"noatime" 
    		];
    		"/etc" = {
     			device = "/etc";
     			options = lib.mkAfter [
    				"bind"
    				"noexec"
     			];
    		};
    		"/tmp" = {
     			device = "/tmp";
     			options = [
    				"bind"
    				"noexec"
     			];
    		};
    		"/run/media" = {
     			device = "/run/media";
     			options = lib.mkAfter [
    				"bind"
    				"noexec"
     			];
    		};
    		"/mnt" = {
     			device = "/mnt";
     			options = lib.mkAfter [
    				"bind"
    				"noexec"
     			];
    		};
    		"/nix/store" = {
     			device = "/mnt";
     			options = lib.mkAfter [
    				"bind"
    				"noatime"
     			];
    		};
    })
     	(lib.mkIf config.users.enable {
     	  "/home/${settings.username}/Public" = {
    		device = "/home/${settings.username}/Public";
    		options = lib.mkAfter [
     			"bind" 
     			"noexec" 
    		];
     	  };
     	  "/home/${settings.username}/Downloads" = {
    		device = "/home/${settings.username}/Downloads";
    		options = lib.mkAfter [
     			"bind" 
     			"noexec"
    		];
     	  };
     	})
  ];*/
}
