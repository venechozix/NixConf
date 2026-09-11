{
  layer-rule = [
    {
      match = _: {
        props = {
          namespace = "^linux-wallpaperengine$";
        };
      };
      place-within-backdrop = true;
    }
  ];

  window-rules = [
    {
      geometry-corner-radius = 20;
      clip-to-geometry = true;
    }
    {
      match = _: {
        props = {
          app-id = "^steam$";
          title = "^notificationtoasts_\\d+_desktop$";
        };
      };
      default-floating-position = _: {
        props = {
          x = 10;
          y = 10;
          relative-to = "bottom-right";
        };
      };
      open-focused = false;
    }
    {
      match = _: {
        props = {
          app-id = "Alacritty";
        };
      };
      open-floating = true;
    }
    {
      match = _: {
        props = {
          app-id = "org.gnome.Nautilus";
        };
      };
      open-floating = true;
    }

  ];
}
