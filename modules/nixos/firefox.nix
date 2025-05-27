{ config, lib, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-esr;
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
      SearchEngines = {
        Default = "duckduckgo";
        Add = [
	  {
	    "Name" = "duckduckgo";
	    "URLTemplate" = "https://duckduckgo.com/?q={searchTerms}&kp=-1&kl=us-en";
	    "Method" = "GET";
	    "iconURL" = "https://duckduckgo.com/favicon.ico";
	  }
	];
      };

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

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
	  install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
	  installation_mode = "force_installed";
	};
	"@testpilot-containers" = {
	  install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
	  installation_mode = "force_installed";
	};
	# Currently not signed, also don't know if I really care about it
        # "jid1-MnnxcxisBPnSXQ@jetpack" = {
	#   install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
	#   installation_mode = "force_installed";
	# };
      };
    };
  };
}

