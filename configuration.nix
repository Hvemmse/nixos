{ config, pkgs, ... }:

{
  # Definerer systemets version
  system.stateVersion = "23.05"; # Opdater til den version, du bruger

  # Netværkskonfiguration
  networking.hostName = "nixos"; # Angiv hostnavn
  networking.useDHCP = true; # Brug DHCP til netværksopsætning

  # Brugerkonfiguration
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Tilføj bruger til 'wheel' gruppen for sudo-adgang
    hashedPassword = "$6$XwjT5FqvmQrSNDYC$p2.sNvKVdh/NUtRA5XY4trrMlrSGJi5UownI60ib8AxeNA0lUKfBE6FilnshHWJBdB6C5POXbHTIxTrCcNLMv."; # Erstat med hash af brugerens kodeord
  };
  {
  # Bootloader konfiguration
  boot.loader.grub = {
    enable = true;           # Aktiver GRUB bootloader
    version = 2;             # Brug GRUB version 2
    device = "/dev/sda";     # Installer GRUB på MBR af den første disk (erstat /dev/sda hvis din disk er en anden)
  };
  # Installer essentielle pakker til programmering
  environment.systemPackages = with pkgs; [
    vim           # Teksteditor
    git           # Versionsstyringssystem
    gcc           # GNU Compiler Collection
    gdb           # GNU Debugger
    python310     # Python 3.10
    nodejs        # Node.js runtime
    npm           # Node Package Manager
    docker        # Containerplatform
    curl          # Filoverførselsværktøj
    wget          # HTTP-klient
    vscode        # Visual Studio Code
  ];

  # Aktiver LXQt-skrivebordsmiljø
  services.xserver.enable = true;
  services.xserver.layout = "dk"; # Sætter tastaturlayout til dansk
  services.xserver.displayManager.lightdm.enable = true; # Bruger LightDM som display manager
  services.xserver.desktopManager.lxqt.enable = true;

  # Aktiver og konfigurer nogle udviklingsrelaterede tjenester
  services.docker.enable = true;
  services.openssh.enable = true; # Aktiverer SSH-tjeneste

  # Firewall-indstillinger
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 ]; # Åbner porte til SSH, HTTP, og HTTPS

  # Yderligere systemkonfiguration
  environment.variables.EDITOR = "vim"; # Sætter standard teksteditor til Vim
}
