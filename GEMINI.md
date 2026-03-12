# Ginkgo Platformer - Godot 4 Project

This is a 2D platformer project developed in **Godot 4.2+**. The game features a playable cat character with character selection, procedural lava, and a full game loop (Menu, Gameplay, Pause, Game Over).

## Project Overview

*   **Engine**: Godot 4 (Mobile/Forward Plus renderer).
*   **Genre**: 2D Platformer.
*   **Main Features**:
    *   **Character Selection**: Choose between "Ginkgo" (Tabby) and "Raul" (Black cat).
    *   **Movement Mechanics**: Gravity, jumping, and horizontal movement with sprite flipping.
    *   **Procedural Lava**: Animated lava at the bottom of the screen using a custom shader (`assets/shaders/lava.gdshader`) and noise distortion.
    *   **UI System**: Main Menu, Character Selection, Pause Menu (ESC), and Game Over screen with restart options.
    *   **Global State**: `GameManager.gd` handles persistent data like the selected character across scenes.

## Key Files & Structure

### Gameplay Scenes
*   `Main.tscn`: The main level containing platforms, the player, and the lava.
*   `Player.tscn`: The character scene with physics (`CharacterBody2D`) and visual representation.
*   `Lava.tscn`: An `Area2D` zone that triggers Game Over on contact, using a procedural shader.

### UI & Menus
*   `Menu.tscn`: The starting screen with "New Game" and "Exit" options.
*   `CharacterSelection.tscn`: Screen for choosing the player sprite.
*   `PauseMenu.tscn`: In-game menu triggered by `ui_cancel` (Escape key).
*   `GameOver.tscn`: Screen displayed when the player falls into the lava.

### Scripts
*   `GameManager.gd`: (Autoload) Stores character choice and preloads textures.
*   `Player.gd`: Manages physics movement, gravity, and sprite initialization.
*   `Lava.gd`: Handles collision detection with the player.
*   `assets/shaders/lava.gdshader`: GLSL shader for the procedural lava effect.

## Building and Running

### Prerequisites
*   Godot Engine 4.x (preferably 4.2+).

### Commands
*   **Run Game**: 
    ```bash
    godot --path .
    ```
*   **Run Headless (for imports)**:
    ```bash
    godot --headless --editor --quit --path .
    ```
*   **Test**: (Godot doesn't have a default CLI test runner without plugins like GUT, but you can run specific scenes):
    ```bash
    godot --path . res://scenes/main_level/main.tscn
    ```

## Development Conventions

*   **Autoloads**: Use `GameManager` for global state.
*   **Input Actions**: 
    *   `ui_accept` (Space/Enter) for jumping.
    *   `ui_left`/`ui_right` for movement.
    *   `ui_cancel` (Escape) for pausing.
*   **Physics Layers**:
    *   Layer 1: World (Platforms).
    *   Layer 2: Player.
    *   Layer 3: Lava/Hazards (Area2D).
*   **Styling**: Scenes are modular (Player and UI are separate instances within `Main.tscn`).
