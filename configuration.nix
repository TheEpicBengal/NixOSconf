{ config, pkgs, ... }:



{
  imports =
    [
      ./hardware-configuration.nix
    ];


  boot.kernel.sysctl."vm.max_map_count" = 2147483642;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # Networking
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";

  systemd.packages = [ pkgs.cloudflare-warp ]; # for warp-cli
  systemd.targets.multi-user.wants = [ "warp-svc.service" ]; # causes warp-svc to be started automatically

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


  # Desktop Services
  services.xserver.enable = false;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Printing Services
  services.printing.enable = true;
  services.avahi = {
  enable = true;
  nssmdns = true;
  openFirewall  = true;
};


  # Audio Services
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
};


  # User Settings
  users.users.pc = {
    isNormalUser = true;
    description = "pc";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [

    ];
  };

  nixpkgs.config.allowUnfree = true;


  environment.systemPackages = with pkgs; [
      kdePackages.partitionmanager
      unstable.bisq-desktop
      ungoogled-chromium
      android-udev-rules
      android-tools
      pkgs.cloudflare-warp
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
      kdenlive
      ffmpeg
      godot_4
      qimgv
      krita
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

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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




