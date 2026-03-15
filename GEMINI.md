# Ginkgo Platformer - Godot 4 Project

This is a procedural 2D platformer project developed in **Godot 4.2+**. The game features multiple playable cat characters, RNG level generation, retro ANSI aesthetics, and a complete rogue-lite loop.

## Project Overview

*   **Engine**: Godot 4 (Mobile/Forward Plus renderer).
*   **Genre**: Procedural 2D Platformer / Rogue-lite.
*   **Aesthetics**: Retro MS-DOS style using authentic ANSI Art and DOS 437 typography.

## Main Features

### Gameplay & Mechanics
*   **RNG Level Generation**: Levels are procedurally generated with a fixed finish line. Platforms are placed with guaranteed jumpability (MIN/MAX gap control).
*   **Character Selection**: Choose between **Ginkgo** (Tabby), **Raul** (Black), **Steve**, and **Isabel**.
*   **Sensitive Jump**: Jump height depends on how long the key is held.
*   **Look-ahead Camera**: Smooth camera anticipation that shifts the view based on the player's movement direction.
*   **Inertia Sliding**: Characters slide to a stop with a static pose when movement keys are released.
*   **Procedural Lava**: Animated hazard at the bottom using a custom noise-distortion shader.
*   **Victory Portal**: An interactive portal at the end of each level that triggers a cinematic "Iris Out" transition.

### Visuals & UI
*   **ANSI Splash Screen**: A cinematic intro featuring randomized "Triad inc." logos in authentic Block-Art (CP437) with color gradients.
*   **Iris Transition**: A circular shader effect that closes on the character upon completing a level.
*   **Retro Typography**: Global use of the `dos437.ttf` font for all UI elements.
*   **Full Game Loop**: Splash -> Menu -> Character Selection -> Gameplay -> Pause/Game Over.

## Directory Structure (Organized)

*   `assets/`: Raw resources.
    *   `backgrounds/`: Level backgrounds and parallax layers.
    *   `characters/`: Sprite sheets for all playable cats.
    *   `fonts/`: Retro typography (`dos437.ttf`).
    *   `shaders/`: Custom GLSL shaders (lava, vortex, iris, etc.).
    *   `textures/`: Environment and UI textures.
    *   `ui/`: Icons and splash assets.
*   `entities/`: Objects with logic and scenes.
    *   `player/`: Base character logic and specific cat scenes.
    *   `environment/`: Platforms, lava, and portal.
*   `scenes/`: Main flow scenes.
    *   `main_level/`: The procedural level scene.
    *   `menus/`: Splash, Menu, Character Selection, etc.
    *   `ui/`: HUD and transition layers.
*   `scripts/`: Global logic.
    *   `autoloads/`: `game_manager.gd` for persistent state.

## Building and Running

### Prerequisites
*   Godot Engine 4.x (preferably 4.2+).

### Commands
*   **Run Game**: 
    ```bash
    godot --path .
    ```
*   **Run Specific Scene**:
    ```bash
    godot --path . res://scenes/main_level/main.tscn
    ```

## Development Conventions

*   **Autoloads**: Use `GameManager` for global state (selected character, textures).
*   **Naming**: All files follow the `snake_case` convention.
*   **Inheritance**: All characters inherit from `base_player.gd` to ensure unified mechanics (camera, jump, dash).
*   **Physics Layers**:
    *   Layer 1: World (Platforms).
    *   Layer 2: Player.
    *   Layer 3: Lava/Hazards.
    *   Layer 4: Interactive (Portal).
