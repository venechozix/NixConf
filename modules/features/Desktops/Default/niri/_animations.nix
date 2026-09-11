{
  workspace-switch = {
    spring = _: {
      props = {
        damping-ratio = 0.75;
        stiffness = 1600;
        epsilon = 0.0001;
      };
    };
  };

  window-open = {
    duration-ms = 150;
    curve = "ease-out-quad";

    custom-shader = "

    vec4 slide_from_bottom(vec3 coords_geo, vec3 size_geo){

      float progress = niri_clamped_progress;

      // Bounce suave
      float bounce = sin(progress * 3.14159265) * 0.08;
      float offset = (1.0 - progress) - bounce;

      vec2 coords = coords_geo.xy;

      coords.y -= offset;

      if ( coords.y > 1.0 || coords.y < 0.0 ) {
        return vec4(0.0);
      }

      vec3 coords_tex = niri_geo_to_tex * vec3(coords, 1.0);
      vec4 color = texture2D(niri_tex, coords_tex.st);

      return color;
    }

    vec4 open_color(vec3 coords_geo, vec3 size_geo) {
      return slide_from_bottom(coords_geo, size_geo);
    }

  ";

  };

  window-close = {
    duration-ms = 200;
    curve = "linear";
    custom-shader = ''
      // ── Easing ────────────────────────────────────────────────────────
      float easeInExpo(float t)   { return t == 0.0 ? 0.0 : pow(2.0, 10.0 * (t - 1.0)); }
      float easeOutQuad(float t)  { return 1.0 - (1.0 - t) * (1.0 - t); }
      float easeInQuad(float t)   { return t * t; }
      float easeOutCubic(float t) { float f = t - 1.0; return f * f * f + 1.0; }
      float easeInQuart(float t)  { return t * t * t * t; }

      float saturate(float x) {
          return clamp(x, 0.0, 1.0);
      }

      float remap(float t, float a, float b) {
          return saturate((t - a) / (b - a));
      }

      vec2 scaleUV(vec2 uv, vec2 scale) {
          return (uv - 0.5) / scale + 0.5;
      }

      float centerGradient(float x) {
          x *= 2.0;
          return x < 1.0 ? x : 2.0 - x;
      }

      vec2 barrelDistort(vec2 uv, float strength) {
          vec2 cc = uv - 0.5;
          float dist = dot(cc, cc);
          return uv + cc * dist * strength;
      }

      vec4 close_color(vec3 coords_geo, vec3 size_geo) {

          if (coords_geo.x < 0.0 || coords_geo.x > 1.0 ||
              coords_geo.y < 0.0 || coords_geo.y > 1.0)
              return vec4(0.0);

          vec2 uv = (niri_geo_to_tex * coords_geo).xy;

          if (uv.x < 0.0 || uv.x > 1.0 ||
              uv.y < 0.0 || uv.y > 1.0)
              return vec4(0.0);

          float p = niri_clamped_progress;
          float inv = 1.0 - p;

          float py = remap(inv, 0.30, 1.00);
          float px = remap(inv, 0.00, 0.80);

          float scaleX = mix(0.06, 1.0, easeOutCubic(px));
          float scaleY = mix(0.00, 1.0, easeInQuad(py));

          float barrelStr = (1.0 - easeOutQuad(px)) * 0.20;
          vec2 distortedUV = barrelDistort(uv, barrelStr);

          vec2 sampleUV = scaleUV(distortedUV, vec2(scaleX, scaleY));

          if (sampleUV.x < 0.0 || sampleUV.x > 1.0 ||
              sampleUV.y < 0.0 || sampleUV.y > 1.0)
              return vec4(0.0);

          vec4 color = texture2D(niri_tex, sampleUV);

          float edgeSoft = mix(0.14, 0.04, easeInQuad(p));

          float tb = centerGradient(sampleUV.y);
          float lr = centerGradient(sampleUV.x);

          float mask =
              smoothstep(0.0, edgeSoft, tb) *
              smoothstep(0.0, edgeSoft, lr);

          color.a *= mask;
          color *= easeOutQuad(inv);

          color *= 1.0 - easeInQuart(remap(p, 0.90, 1.00));

          return color;
      }
    '';
  };

  horizontal-view-movement = {
    spring = _: {
      props = {
        damping-ratio = 0.75;
        stiffness = 800;
        epsilon = 0.0003;
      };
    };
  };

  window-movement = {
    spring = _: {
      props = {
        damping-ratio = 0.75;
        stiffness = 760;
        epsilon = 0.0003;
      };
    };
  };

  window-resize = {
    spring = _: {
      props = {
        damping-ratio = 0.75;
        stiffness = 750;
        epsilon = 0.0001;
      };
    };
  };

  overview-open-close = {
    spring = _: {
      props = {
        damping-ratio = 0.75;
        stiffness = 900;
        epsilon = 0.001;
      };
    };
  };

  recent-windows-close = {
    spring = _: {
      props = {
        damping-ratio = 0.75;
        stiffness = 900;
        epsilon = 0.001;
      };
    };
  };

  screenshot-ui-open = {
    duration-ms = 200;
    curve = "ease-out-quad";
  };

  slowdown = 1.3;
}
