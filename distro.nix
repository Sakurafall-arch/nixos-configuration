{ config, lib, pkgs, inputs, ... }:

{
virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };
}
