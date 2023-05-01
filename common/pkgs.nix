{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    dig
    emacs
    fd
    git
    lsof
    netcat
    vim
    wget
    zsh

    virt-manager
  ];
}