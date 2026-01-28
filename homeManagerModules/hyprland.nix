{ config, lib, pkgs, settings, ... }:

let
  font = "Mononoki Nerd Font Mono";
in

{
  options.hyprland.enable = lib.mkEnableOption "Hyprland wayland compositor";

  config = lib.mkIf config.hyprland.enable {
    home.packages = with pkgs.stable; [
      xfce.thunar
      # lf
      hyprpaper
      hypridle
      pavucontrol
      wdisplays
    ];

    gtk = {
      enable = true;
      font = {
        name = font;
        package = pkgs.stable.nerd-fonts.mononoki;
        size = 10;
      };
      colorScheme = "dark";
    };

    programs.foot = {
      enable = true;
      settings = {
        main = {
          font = "${font}:size=10";
          pad = "20x20";
        };
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      settings = {
        "$mainMod" = "SUPER";
        "$terminal" = "${pkgs.foot}/bin/foot";
        "$fileManager" = "${pkgs.xfce.thunar}/bin/thunar";
        "$browser" = "flatpak run io.gitlab.librewolf-community";
        "$menu" = "${pkgs.wofi}/bin/wofi --show run";
        exec-once = [
          "hyprpaper"
          "hyprlauncher --dameon"
          "hypridle"
          "waybar"
        ];
        input = {
          kb_layout = "fr";
          follow_mouse = "1";
          touchpad = {
            natural_scroll = "true";
          };
        };
        bind = [
          "$mainMod, Q, killactive,"
          "ALT, F4, killactive,"
          "$mainMod, T, exec, $terminal"
          # "$mainMod, M, exit,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, B, exec, $browser"
          "$mainMod, V, togglefloating,"
          "$mainMod, SPACE, exec, $menu"
          "$mainMod, P, pseudo, # dwindle"
          "$mainMod, J, togglesplit, # dwindle"

          # Move focus
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"

          # Switch workspaces
          "$mainMod, ampersand, workspace, 1"
          "$mainMod, eacute, workspace, 2"
          "$mainMod, quotedbl, workspace, 3"
          "$mainMod, apostrophe, workspace, 4"
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
          "ALT, TAB, workspace, e+1"

          # Move active window to a workspace
          "$mainMod SHIFT, ampersand, movetoworkspace, 1"
          "$mainMod SHIFT, eacute, movetoworkspace, 2"
          "$mainMod SHIFT, quotedbl, movetoworkspace, 3"
          "$mainMod SHIFT, apostrophe, movetoworkspace, 4"

          "$mainMod, F, fullscreen"
        ];
        bindl = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl -e4 -n2 set 5%+"
          ",XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl -e4 -n2 set 5%-"
        ];
        bindm = [
          # Move/resize windows with mouse
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
        general = {
          border_size = 3;
          gaps_in = 15;
          gaps_out = 15;
          animation = [
            "windows, 0"
            "layers, 0"
            "fade, 0"
            "border, 0"
            "borderangle, "
            "workspaces, 0"
            "zoomFactor, 0"
            "monitorAdded, 0"
          ];
        };
        decoration = {
          rounding = 5;
        };
        misc = {
          disable_splash_rendering = true;
          disable_hyprland_logo = true;
        };
        monitor = ",preferred,auto,1";
      };
    };

    programs.waybar = {
      enable = true;
      systemd.enable = true;

      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 35;

          "modules-left" = [
            "clock"
          ];

          "modules-center" = [
            "hyprland/workspaces"
          ];

          "modules-right" = [
            "pulseaudio"
            "custom/separator"
            "bluetooth"
            "custom/separator"
            "network"
            "custom/separator"
            "battery"
          ];

          "custom/separator" = {
            exec = "echo '\ |\ '";
            interval = 0;
          };

          clock = {
            format = "{:%H:%M - %A %d/%m/%y}";
          };

          battery = {
            format = "BAT {capacity}%";
          };

          network = {
            format = "{ifname}";
            format-disconnected = "N/A";
            on-click = "foot nmtui";
          };

          bluetooth = {
            format-disabled = "BT dis";
            format-off = "BT off";
            format-on = "BT {status}";
          };

          pulseaudio = {
            format = "VOL {volume}%";
            format-muted = "muted";
            on-click = "pavucontrol";
          };

          "hyprland/workspaces" = {
            format = "{icon}";
            on-click = "activate";
            format-icons = {
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "active" = "";
            };
            sort-by-number = true;
          };
        };
      };

      style = ''
        * {
          font-family: ${font};
          font-size: 12px;
          font-weight: bold;
          color: #ffffff;
        }

        .modules-left {
          background-color: #000000;
          padding: 0 15px;      
          border-radius: 15px;
          margin: 5px;
        }

        .modules-center {
          background-color: #000000;
          padding: 0 15px;
          margin: 5px;
          border-radius: 15px;
        }

        .modules-right {
          background-color: #000000;
          padding: 0 15px;      
          margin: 5px;
          border-radius: 15px;
        }

        window#waybar {
          background-color: rgba(255, 255, 255, 0.0);
        }
      '';
    };

    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          hide_cursor = true;
        };
        animations = {
          enabled = false;
        };
        background = {
          color = "rgba(0, 0, 0, 1.0)";
        };
        label = {
          text = "locked";
          font_size = 16;
          font_family = font;
          position = "0, 35";
          halign = "center";
          valign = "center";
        };
        input-field = {
          size = "150,30";
          outer_color = "rgba(255, 255, 255, 1.0)";
          inner_color = "rgba(0, 0, 0, 1.0)";
          font_color = "rgba(255, 255, 255, 1.0)";
          font_family = font;
        };
      };
    };

    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
          before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
          after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
        };
        listener = [
          {
            timeout = 2 * 60;
            on-timeout = "brightnessctl -s set 20%-";
            on-resume = "brightnessctl -r";
          }
          {
            timeout = 3 * 60;

            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
          }
          {
            timeout = 5 * 60;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 30 * 60;
            on-timeout = "systemctl suspend";
          }
          {
            timeout = 120 * 60;
            on-timeout = "systemctl hibernate";
          }
        ];
      };
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "/home/${settings.username}/nixos-config/wallpapers/wallhaven-e8717l.jpg"
        ];
        wallpaper = [
          "eDP-1,/home/${settings.username}/nixos-config/wallpapers/wallhaven-e8717l.jpg"
        ];
      };
    };
  };
}
