# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  nixos-24-11 = import <nixos-24.11> { config = { allowUnfree = true; }; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraMono" ]; })
  ];

  #programs.hyprland.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
    desktopManager.gnome.enable = true;
    desktopManager.gnome.extraGSettingsOverridePackages = with pkgs; [
      gnome.mutter
    ];
    desktopManager.gnome.extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features=['scale-monitor-framebuffer']
    '';

    #displayManager.sddm.enable = true;
    #desktopManager.plasma5.enable = true;

    # Configure keymap in X11
    layout = "us";
    xkbVariant = "";
  };

  #services.gnome.gnome-browser-connector.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.fprintd = {
    enable = true;
    package = pkgs.fprintd-tod;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-vfs0090;
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tyag = {
    isNormalUser = true;
    description = "tyag";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      nixos-24-11.bitwarden-desktop
      unstable.firefox
      azure-cli
      unstable.azure-storage-azcopy
      awscli2
      (unstable.google-cloud-sdk.withExtraComponents ([unstable.google-cloud-sdk.components.config-connector]))
      unstable.kubectl
      unstable.kubernetes-helm
      unstable.kubelogin
      nixos-24-11.k9s
      nodejs_20
      nixos-24-11.jdk21_headless
      unstable.neovim
      krew
      qbittorrent
      azure-functions-core-tools
      unstable.firebase-tools
      antora
      python3
      leiningen
      unstable.go-jsonnet
      nixos-24-11.jprofiler
      nixos-24-11.btop
      nixos-24-11.pritunl-client
      act
      # python311Packages.pip
      # python311Packages.packaging
      # ansible
      # (python311.withPackages(ps: with ps; [
      #   pip
      #   requests
      #   packaging
      #   ansible
      # ]))
    ];
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "tyag";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  systemd.packages = [ pkgs.pritunl-client ];
  systemd.targets = { multi-user = { wants = [ "pritunl-client.service" ]; }; };

  users.users.adi = {
    isNormalUser = true;
    description = "adi";
    packages = with pkgs; [
      #clamav
      appimage-run
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gcc
    gnumake42
    stow
    wl-clipboard
    gnome.gnome-tweaks
    catppuccin-cursors.macchiatoDark
    catppuccin-gtk
    wget
    git
    dig
    vim
    mpv
    wezterm
    jq
    tmux
    eza
    bat
    unstable.fzf
    ripgrep
    fd
    postgresql_16
    lua-language-server
    unstable.terraform
    unstable.terraform-ls
    chromium
    yq-go
  ];

  services.caddy.enable = true;
  services.caddy.logFormat = ''
    level DEBUG
  '';
  services.caddy.globalConfig = ''
    debug
  '';
  services.caddy.extraConfig = ''
    :80 {
      root * /index
      templates {
        mime text/html text/plain application/javascript
      }
      file_server
    }
  '';

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nixpkgs.overlays = [

    (final: prev: {
      catppuccin-gtk = prev.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "standard";
        tweaks = [ "rimless" "normal" ];
        variant = "mocha";
      };
    })

    (final: prev: {
      gnome = prev.gnome.overrideScope' (gnomeFinal: gnomePrev: {
        mutter = gnomePrev.mutter.overrideAttrs ( old: {
          src = pkgs.fetchgit {
            url = "https://gitlab.gnome.org/vanvugt/mutter.git";
            # GNOME 45: triple-buffering-v4-45
            rev = "0b896518b2028d9c4d6ea44806d093fd33793689";
            sha256 = "sha256-mzNy5GPlB2qkI2KEAErJQzO//uo8yO0kPQUwvGDwR4w=";
          };
        });
      });
    })

  ];

  nixpkgs.config.allowAliases = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  home-manager.users.tyag = {pkgs, lib, ...}: {
    dconf = {
      enable = true;
      settings = with lib.hm.gvariant; {
        "org/gnome/desktop/wm/keybindings" = {
          switch-applications = "disabled";
          switch-applications-backward = "disabled";
          switch-windows = ["<Alt>Tab"];
          switch-windows-backward = ["<Shift><Alt>Tab"];
        };
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          enable-hot-corners = false;
          show-battery-percentage = true;
        };
        "org/gnome/desktop/session" = {
          idle-delay = mkUint32 0;
        };
        "org/gnome/desktop/wm/preferences" = {
          focus-mode = "sloppy";
        };
        "org/gnome/desktop/peripherals/mouse" = {
          accel-profile = "flat";
        };
        "org/gnome/desktop/peripherals/touchpad" = {
          tap-to-click = true;
        };
        "org/gnome/desktop/peripherals/keyboard" = {
          repeat-interval = mkUint32 28;
          delay = mkUint32 220;
        };
        "org/gnome/mutter" = {
          edge-tiling = true;
          dynamic-workspaces = true;
          workspaces-only-on-primary = true;
        };
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = [
            "user-theme@gnome-shell-extensions.gcampax.github.com"
            "wiggle"
          ];
        };
        "org/gnome/shell/extensiions/user-theme" = {
          name = "Catppuccin-Mocha-Standard-Pink-Dark";
        };
        "org/gnome/shell/app-switcher" = {
          current-workspace-only = true;
        };
        "org/gnome/settings-daemon/plugins/power" = {
          power-saver-profile-on-low-battery = false;
          sleep-inactive-battery-timeout = 3600;
          sleep-inactive-ac-timeout = 3600;
        };
        "org/gtk/settings/file-chooser" = {
          clock-format = "12h";
        };
      };
    };

    home.stateVersion = "23.11";
    programs.home-manager.enable = true;
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
