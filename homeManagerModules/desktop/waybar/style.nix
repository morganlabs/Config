{ config }:
with config.colorScheme.palette;
''
  * {
    font-family: "BlexMono Nerd Font";
    font-weight: 500;
    font-size: 1rem;
    color: #${base04};
    border: none;
    border-radius: 0;
    min-height: 0;
    transition: all 0s;
  }

  window#waybar {
    background: #${base01};
  }

  .modules-center * .module,
  .modules-right * .module {
    margin: 0 8px;
  }

  #workspaces .active {
    background-color: #${base0E};
  }

  #workspaces .active * {
    color: #${base00};
  }

  #window {
    padding: 0 16px;
  }

  #pulseaudio.muted {
    padding: 0 0px;
  }

  #battery.charged {
    color: #${base0B}
  }

  #battery.warning {
    color: #${base09}
  }

  #battery.critical {
    color: #${base08}
  }
''
