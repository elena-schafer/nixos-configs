{ inputs, config, lib, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.elena = {
      name = "elena";
      isDefault = true;
      search = {
        default = "duckduckgo";
        force = true;
        engines = {
          duckduckgo = {
            name = "duckduckgo";
            urls = [{
              template = "https://duckduckgo.com/?q={searchTerms}&kp=-1&kl=us-en";
            }];
            icon = "https://duckduckgo.com/favicon.ico";
          };
        };
      };
      # bookmarks.force = true;
      # bookmarks.settings = [
      #   {
      #     name = "youtube";
      #     url = "https://www.youtube.com";
      #   }
      #   {
      #     name = "nixos resourcesS";
      #     toolbar = true;
      #     bookmarks = [
      #       {
      #         name = "home-manager options";
      #         url = "https://nix-community.github.io/home-manager/options.xhtml";
      #       }
      #       {
      #         name = "nix packages";
      #         url = "https://search.nixos.org/packages";
      #       }
      #       {
      #         name = "nixos options";
      #         url = "https://search.nixos.org/options";
      #       }
      #     ];
      #   }
      # ];
      containers = {
        google = {
	  name = "google";
	  color = "purple";
	  icon = "circle";
	  id = 1;
	};
        deadname_google = {
	  name = "deadname google";
	  color = "blue";
	  icon = "circle";
	  id = 2;
	};
        finance = {
	  name = "finance";
	  color = "green";
	  icon = "dollar";
	  id = 3;
	};
      };

      extensions = {
        force = true; # clobber prexisting extensions
        packages = with inputs.firefox-addons.packages.${pkgs.system}; [
	  ublock-origin
	  temporary-containers
	  multi-account-containers
	];
        settings."{c607c8df-14a7-4f28-894f-29e8722976af}".settings = {
	  # other options can be found in source code at https://github.com/stoically/temporary-containers/blob/main/src/background/preferences.ts
	  automaticMode = {
	    active = true;
	    newTab = "created";
	  };
	  isolation = {
	    global = {
	      mouseClick = {
	        middle = {
		  action = "notsamedomain";
                  container = "default";
		};
	      };
	    };
	  };
	};
      };

      # ExtensionSettings = {
      #   "uBlock0@raymondhill.net" = {
      #     install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
      #     installation_mode = "force_installed";
      #   };
      #   "{c607c8df-14a7-4f28-894f-29e8722976af}" = {
      #     install_url = "https://addons.mozilla.org/firefox/downloads/latest/temporary-containers/latest.xpi";
      #     installation_mode = "force_installed";
      #   };
      #   "@testpilot-containers" = {
      #     install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
      #     installation_mode = "force_installed";
      #   };
      #   # Currently not signed, also don't know if I really care about it
      #   # "jid1-MnnxcxisBPnSXQ@jetpack" = {
      #   #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
      #   #   installation_mode = "force_installed";
      #   # };
      # };
    };
    policies = {
      # Personal Preferences
      DisplayBookmarksToolbar = "always";
      DisplayMenuBar = "default-off";

      # Annoying stuff I don't need
      DontCheckDefaultBrowser = true;
      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
      	SkipOnboarding = true;
      };

      # Don't send data to Mozilla
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      # Not doing a firefox account I don't think
      DisableAccounts = true;
      DisableFirefoxAccounts = true;

      # Hides data about websites you're looking up from people on your network
      # "DNSOverHTTPS" = {
      #   "Enabled" = true;
      # };

      # Remove annoying stuff from home screen
      "FirefoxHome" = {
        "SponsoredTopSites" = false;
	"Highlights" = false;
	"Pocket" = false;
        "SponsoredPocket" = false;
	"Snippets" = false;
      };

      # Set duckduckgo as default search engine

      # Disable suggestions in address bar
      "FirefoxSuggest" = {
        WebSuggestions = false;
        "SponsoredSuggestions" = false;
	"ImproveSuggest" = false;
      };

      # Prevents search engine getting queries when typing in url
      # "SearchSuggestEnabled" = false;

      # Block popups
      "PopupBlocking"."default" = true;

      # Clear site data when we close browser #TODO manage exceptions
      SanitizeOnShutdown = {
        cookies = true;
	SiteSettings = true;
	FormData = true;
	Cache = true;
	Sessions = true;
      };

      # Use firefox's builtin protection
      EnableTrackingProtection = {
        Value = true;
	Locked = true;
	Cryptomining = true;
	Fingerprinting = true;
      };

    };
  };
}

