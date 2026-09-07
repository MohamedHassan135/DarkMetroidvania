# DarkMetroidvania — Godot 4.7.2

Vertical slice (Phase 1) — playable core systems for a 2D Metroidvania.

Import instructions
1. Download or clone this repository.
2. Open Godot 4.7.2.
3. Click "Import" and choose the project.godot file in the project root.
4. Run the project (Main scene is the default).

Notes
- Controls (keyboard): A/D or Left/Right for movement, Space for Jump, J for Attack, K for Dash.
- Mobile touch controls present in the scene (UI) — they send signals to the player.

This vertical slice includes:
- Player movement (walk, run, jump, double jump, dash, wall jump, wall slide)
- Combat: basic attack with hitbox, Health system
- Enemy example (melee) with simple AI
- Boss framework (example boss with phases)
- Save/Load manager (user://savegame.json)
- Mobile controls (virtual joystick + buttons)
- HUD showing Health and Currency
- Placeholder graphics (procedural) and placeholder sounds

License: MIT
