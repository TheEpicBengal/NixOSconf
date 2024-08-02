{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Kernel/CPU/GPU
  boot.kernel.sysctl."vm.max_map_count" = 2147483642;
  powerManagement.cpuFreqGovernor = "performance";

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";
  networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  services.mullvad-vpn.enable = true;
  services.resolved = {
   enable = true;
   dnssec = "true";
   domains = [ "~." ];
   fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
   dnsovertls = "true";
};
  # services.openssh.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  # Desktop                 
  services.xserver.enable = false;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Printing
  services.printing.enable = true;
   services.avahi = {
   enable = true;
   nssmdns = true;
   openFirewall  = true;
  };

  # Audio
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.audio.enable = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.wireplumber.enable = true;

  # User
  users.users.pc = {
    isNormalUser = true;
    description = "pc";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [

    ];
  };

  nixpkgs.config.allowUnfree = true;

  # System-Wide Packages

  environment.systemPackages = with pkgs; [      
      kdePackages.filelight
      kdePackages.partitionmanager
      unstable.bisq-desktop
      mullvad-vpn
      ungoogled-chromium
      android-udev-rules
      android-tools
      discord
      protontricks
      gamescope
      qbittorrent
      thunderbird
      tor-browser
      fastfetch
      dolphin-emu
      keepassxc
      protonup
      mangohud
      gamemode
      corectrl
      firefox
      kdenlive
      ffmpeg
      godot_4
      qimgv
      krita
      htop
      grim
      kcalc
      mpv
      git
      yt-dlp
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    gamescopeSession.enable = true;
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "/home/user/.steam/root/compatibilitytools.d";

    };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [

  ];

   hardware.opengl = {
     enable = true;
     driSupport = true;
     driSupport32Bit = true;
   };

  system.stateVersion = "24.05";

  nixpkgs.config = {
  packageOverrides = pkgs: {
    unstable = import <nixos-unstable> {
      config = config.nixpkgs.config;
    };
  };
};

}




