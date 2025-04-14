{ pkgs, ... }:

{
  environment.systemPackages = 
    (with pkgs; [
      bat
      cron
      curl
      dig
      eza
      fastfetch
      fd
      fishPlugins.autopair # Auto-complete matching pairs in the Fish command line
      fishPlugins.bang-bang # !! replaced by last command
      fishPlugins.bass # Fish function making it easy to use utilities written for Bash in Fish shell
      fishPlugins.colored-man-pages
      fishPlugins.done # Automatically receive notifications when long processes finish
      fishPlugins.humantime-fish # Turn milliseconds into a human-readable string
      fishPlugins.fifc # Fzf powers on top of fish completion engine and allows customizable completion rules
      fishPlugins.fish-you-should-use # Reminds you to use your aliases
      fishPlugins.fish-bd # Go back to a parent directory up in your current working directory tree
      fishPlugins.fzf # Ef-fish-ient fish keybindings for fzf
      fishPlugins.forgit # Utility tool powered by fzf for using git interactively
      fishPlugins.puffer # Typing consecutive dots after .. will automatically expand to ../..
      fishPlugins.sponge # Keeps your fish shell history clean from typos
      fishPlugins.z
      fzf
      htop
      nmap
      powershell
      ranger
      ripgrep-all
      tcpdump
      tldr
      wget
      zellij
    ])
    ++
    (with pkgs.unstable; [
    ]);
}