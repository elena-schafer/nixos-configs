{ inputs, config, lib, pkgs, ... }:

{
  home.file.".mozilla/firefox/elena/containers.json".force = lib.mkForce true;
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
        # options for icons can be found here
	# https://github.com/mozilla/multi-account-containers/blob/aec2aa5fb0319192aacb2dd94f9d84ce0a835f9a/src/js/popup.js#L1893
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
        github = {
	  name = "github";
	  color = "blue";
	  icon = "briefcase";
	  id = 4;
	};
        BSU = {
	  name = "BSU";
	  color = "orange";
	  icon = "circle";
	  id = 5;
	};
      };

      extensions = {
        force = true; # clobber prexisting extensions
        packages = with inputs.firefox-addons.packages.${pkgs.system}; [
	  ublock-origin
	  multi-account-containers
	];
        settings = {
	  "{c607c8df-14a7-4f28-894f-29e8722976af}".settings = {
	    # other options can be found in source code at https://github.com/stoically/temporary-containers/blob/main/src/background/preferences.ts
	    preferences = {
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
	  "@testpilot-containers".settings = {
	    onboarding-stage = 8;
	    achievements = [
	      {
	        name = "manyContainersOpened";
		done = true;
              }
	    ];
	  };
	};
      };
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

