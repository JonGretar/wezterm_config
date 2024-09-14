# Wezterm configuration

This is my personal configuration for [Wezterm](https://wezfurlong.org/wezterm/).
Place it in your `~/.config/wezterm/` directory.

## Status bar

Status bar is simple. Left of tabs is just a nice icon. 

![](docs/left_status.jpg)

On the right status bar you have a clock, notification of leader being active, 
notification of zoom level and the active key table.

![](docs/right_status.jpg)


## The Pane Management key table

`<Leader> w` enters the terminal in to pane management mode. 

 - *direction_keys*: Activate pane in direction 
 - *SHIFT+direction_keys*: Resize the active pane
 - *s*: Split pane horizontal
 - *v*: Split pane vertically
 - *r*: Rotate panes 
 - *m*: Swap pane with another
 - *z*: Zoom pane
 - *<number>*: Activate tab
 - *!*: Split pane into it's own tab
 - *enter or esc*: Exit pane management mode.
