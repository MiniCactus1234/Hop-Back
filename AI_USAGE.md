# AI usage log (Harvest rule: max 1/3 of code AI-written)

Written with Claude (AI):
- Project setup: renderer, window size, project name, test_room.tscn, lily_pad.tscn group/placeholder
- lily_pad.gd (whole file, ~20 lines)
- frog.gd: basic movement, jump and lily pad bounce in _physics_process (~25 lines)
- level_1.tscn: empty starting structure (Background, Platforms, LilyPads folders)
- export_presets.cfg (web export settings) and build/ in .gitignore

Written by me:
- frog.gd: coyote time
- frog.gd: jump buffer
- frog.gd: variable jump height (jump cut)
- lily_pad.gd: came_alive signal and emitting it
- level.gd (whole file): counting lily pads, level complete, background colour fade
- level_1.tscn: level layout (platforms and lily pad positions)
- frog.gd: facing direction and tongue input
- frog.gd: use_tongue() (raycast, waking targets, drawing the tongue)
- flower.tscn + flower.gd (whole thing)
- tuning: jump_velocity, bounce_strength
