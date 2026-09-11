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
  ];
}
