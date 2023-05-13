{ ... }: ''
* {
    border: none;
    border-radius: 0;
    /* `otf-font-awesome` is required to be installed for icons */
    font-family: Ubuntu Mono;
    min-height: 20px;
}

window#waybar {
    background: transparent;
}

window#waybar.hidden {
    opacity: 0.2;
}

#workspaces {
    margin-right: 8px;
    border-radius: 10px;
    transition: none;
    background: #1e1e2e;
    font-size: 12px;
}

#workspaces button {
    transition: none;
    color: #6c7086;
    background: transparent;
    padding: 5px;
}

#workspaces button.persistent {
    color: #313244;
}

#workspaces button:hover {
    transition: none;
    box-shadow: inherit;
    text-shadow: inherit;
    border-radius: inherit;
    color: #383c4a;
    background: #9399b2;
}

#workspaces button.focused {
    color: #89b4fa;
}

#keyboard-state {
    margin-right: 8px;
    padding-right: 16px;
    border-radius: 0px 10px 10px 0px;
    transition: none;
    color: #ffffff;
    background: #383c4a;
}

#custom-mail {
    margin-right: 8px;
    padding-right: 16px;
    border-radius: 0px 10px 10px 0px;
    transition: none;
    color: #ffffff;
    background: #383c4a;
}

#mode {
    padding-left: 16px;
    padding-right: 16px;
    border-radius: 10px;
    transition: none;
    color: #ffffff;
    background: #383c4a;
}

#clock {
    padding-left: 16px;
    padding-right: 16px;
    border-radius: 10px;
    transition: none;
    color: #cdd6f4;
    background: #1e1e2e;
}

#pulseaudio {
    margin-right: 8px;
    padding-left: 16px;
    padding-right: 16px;
    border-radius: 10px;
    transition: none;
    color: #cdd6f4;
    background: #1e1e2e;
}

#pulseaudio.muted {
    background-color: #90b1b1;
    color: #2a5c45;
}

#tray {
    padding-left: 16px;
    padding-right: 16px;
    border-radius: 10px;
    transition: none;
    color: #cdd6f4;
    background: #1e1e2e;
}

@keyframes blink {
    to {
        background-color: #ffffff;
        color: #000000;
    }
}
''