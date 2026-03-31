{ self, inputs, ... }:
{

  flake.nixosModules.niri =
    { pkgs, lib, ... }:
    {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
      };
    };

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs; # THIS PART IS VERY IMPORTAINT, I FORGOT IT IN THE VIDEO!!!
        settings = {

          spawn-at-startup = [
            (lib.getExe self'.packages.myNoctalia)
          ];

          prefer-no-csd = _: { };

          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          input.mouse = {
            accel-speed = 0;
            accel-profile = "flat";
          };

          input.tablet = {
            off = _: { };
          };

          outputs = {
            "DP-1" = {
              mode = "1280x1024@75.025";
              position = _: {
                props = {
                  x = 0;
                  y = 0;
                };
              };
              scale = 1;
              transform = "90";
            };

            "HDMI-A-1" = {
              mode = "1366x768@59.790";
              position = _: {
                props = {
                  x = 1024;
                  y = 408;
                };
              };
              scale = 1;
              transform = "normal";
            };

          };

          layout = {
            gaps = 10;
            border = {
              off = _: { };
            };
            focus-ring = {
              width = 2;
              active-color = "#d3e2e8";
              inactive-color = "#505050";
            };

            preset-column-widths = [
              { proportion = 0.33333; }
              { proportion = 0.5; }
              { proportion = 0.66666; }
            ];

            default-column-width = {
              proportion = 0.5;
            };

          };

          binds = {
            # Hotkey overlay
            "Mod+Shift+Slash".show-hotkey-overlay = { };

            # Applications
            "Mod+Return" = {
              spawn = lib.getExe pkgs.alacritty;
            };
            "Mod+Space" = {
              spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
            };

            # Overview / window management
            "Mod+O".toggle-overview = { };
            "Mod+X".close-window = { };

            # Focus movement
            "Mod+Left".focus-column-left = { };
            "Mod+Down".focus-window-down = { };
            "Mod+Up".focus-window-up = { };
            "Mod+Right".focus-column-right = { };

            # Move windows/columns
            "Mod+Ctrl+Left".move-column-left = { };
            "Mod+Ctrl+Down".move-window-down = { };
            "Mod+Ctrl+Up".move-window-up = { };
            "Mod+Ctrl+Right".move-column-right = { };

            # Monitor focus
            "Mod+Shift+Left".focus-monitor-left = { };
            "Mod+Shift+Down".focus-monitor-down = { };
            "Mod+Shift+Up".focus-monitor-up = { };
            "Mod+Shift+Right".focus-monitor-right = { };

            # Move column to monitor
            "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = { };
            "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = { };
            "Mod+Shift+Ctrl+H".move-column-to-monitor-left = { };
            "Mod+Shift+Ctrl+L".move-column-to-monitor-right = { };

            # Workspace navigation
            "Mod+I".focus-workspace-down = { };
            "Mod+U".focus-workspace-up = { };

            "Mod+Ctrl+I".move-column-to-workspace-down = { };
            "Mod+Ctrl+U".move-column-to-workspace-up = { };

            "Mod+Shift+I".move-workspace-down = { };
            "Mod+Shift+U".move-workspace-up = { };

            # Scroll workspace/column navigation
            "Mod+WheelScrollDown".focus-workspace-down = { };
            "Mod+WheelScrollUp".focus-workspace-up = { };
            "Mod+Ctrl+WheelScrollDown".move-column-to-workspace-down = { };
            "Mod+Ctrl+WheelScrollUp".move-column-to-workspace-up = { };

            "Mod+Shift+WheelScrollDown" = _: {
              props = {
                cooldown-ms = 150;
              };
              content = {
                focus-column-right = _: { };
              };
            };

            "Mod+Shift+WheelScrollUp" = _: {
              props = {
                cooldown-ms = 150;
              };
              content = {
                focus-column-left = _: { };
              };
            };

            "Mod+Ctrl+Shift+WheelScrollDown" = _: {
              props = {
                cooldown-ms = 150;
              };
              content = {
                move-column-right = _: { };
              };
            };

            "Mod+Ctrl+Shift+WheelScrollUp" = _: {
              props = {
                cooldown-ms = 150;
              };
              content = {
                move-column-left = _: { };
              };
            };

            # Numbered workspaces - focus
            "Mod+1".focus-workspace = 1;
            "Mod+2".focus-workspace = 2;
            "Mod+3".focus-workspace = 3;
            "Mod+4".focus-workspace = 4;
            "Mod+5".focus-workspace = 5;
            "Mod+6".focus-workspace = 6;
            "Mod+7".focus-workspace = 7;
            "Mod+8".focus-workspace = 8;
            "Mod+9".focus-workspace = 9;

            # Numbered workspaces - move column
            "Mod+Ctrl+1".move-column-to-workspace = 1;
            "Mod+Ctrl+2".move-column-to-workspace = 2;
            "Mod+Ctrl+3".move-column-to-workspace = 3;
            "Mod+Ctrl+4".move-column-to-workspace = 4;
            "Mod+Ctrl+5".move-column-to-workspace = 5;
            "Mod+Ctrl+6".move-column-to-workspace = 6;
            "Mod+Ctrl+7".move-column-to-workspace = 7;
            "Mod+Ctrl+8".move-column-to-workspace = 8;
            "Mod+Ctrl+9".move-column-to-workspace = 9;

            # Column/window grouping
            "Mod+BracketLeft".consume-or-expel-window-left = { };
            "Mod+BracketRight".consume-or-expel-window-right = { };
            "Mod+Comma".consume-window-into-column = { };
            "Mod+Period".expel-window-from-column = { };

            # Sizing
            "Mod+R".switch-preset-column-width = { };
            "Mod+Shift+R".switch-preset-window-height = { };
            "Mod+Ctrl+R".reset-window-height = { };

            "Mod+F".maximize-column = { };
            "Mod+Shift+F".fullscreen-window = { };
            "Mod+Ctrl+F".expand-column-to-available-width = { };

            "Mod+Minus".set-column-width = "-10%";
            "Mod+Equal".set-column-width = "+10%";
            "Mod+Shift+Minus".set-window-height = "-10%";
            "Mod+Shift+Equal".set-window-height = "+10%";

            # Floating / tiling
            "Mod+V".toggle-window-floating = { };
            "Mod+Shift+V".switch-focus-between-floating-and-tiling = { };
            "Mod+C".center-column = { };
            "Mod+Ctrl+C".center-visible-columns = { };

            # Tabbed display
            "Mod+W".toggle-column-tabbed-display = { };

            # Screenshots
            "Mod+Shift+S".screenshot = { };
            "Print".screenshot-screen = { };
            "Alt+Print".screenshot-window = { };

            "Mod+Shift+E".quit = { };
            "Ctrl+Alt+Delete".quit = { };
            "Mod+Shift+P".power-off-monitors = { };

            "Mod+Escape" = _: {
              props = {
                allow-inhibiting = false;
              };
              content = {
                toggle-keyboard-shortcuts-inhibit = _: { };
              };
            };

          };
          cursor = {
            xcursor-theme = "catppuccin-mocha-dark-cursors";
            xcursor-size = 24;
          };

          window-rules = [
            {
              geometry-corner-radius = 20;
              clip-to-geometry = true;
            }
          ];

        };
      };
    };
}
