{ config, pkgs, ...}:

{ 

  # Enables Systemwide Audio
  services.pipewire = {
  enable = true;
  pulse.enable = true;
  };
  
}