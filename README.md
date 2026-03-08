# Ginkgo Platformer 🐱🌋

Un juego de plataformas 2D infinito desarrollado con **Godot 4.2+**. Controla a un gato (Ginkgo o Raul) mientras saltas sobre plataformas de roca generadas procedimentalmente y evitas caer en la lava burbujeante.

## 🚀 Características Principales

*   **Scroller Infinito**: El nivel se genera automáticamente a medida que avanzas hacia la derecha.
*   **Selección de Personaje**: Elige entre **Ginkgo** (atigrado naranja) o **Raul** (negro) al iniciar la partida.
*   **Física de Movimiento Pulida**:
    *   **Inercia y Fricción**: El personaje tiene peso y no frena en seco.
    *   **Doble Salto**: Para alcanzar las plataformas más difíciles.
    *   **Muerte Animada**: El gato se da la vuelta (*upside down*) al tocar la lava.
*   **Efectos Visuales Procedimentales (Shaders)**:
    *   **Lava Dinámica**: Animada mediante ruido y shaders para un aspecto orgánico.
    *   **Plataformas de Roca**: Generadas con texturas NinePatch para evitar distorsiones.
    *   **Fondo Parallax**: Desplazamiento infinito con profundidad visual.
*   **Interfaz Completa (UI)**:
    *   Menú principal y selección de personaje.
    *   **HUD**: Retrato dinámico del gato seleccionado en alta resolución.
    *   Menús de Pausa y Game Over con soporte total para teclado.

## 🎮 Controles

| Acción | Tecla |
| :--- | :--- |
| **Moverse** | Flechas Izquierda / Derecha o `A` / `D` |
| **Saltar** | `Espacio` o `Enter` (Púlsalo dos veces para doble salto) |
| **Pausar** | `Esc` |
| **Navegar Menús** | Flechas y `Enter` |

## 🛠️ Instalación y Ejecución

### Requisitos
*   [Godot Engine 4.x](https://godotengine.org/download) instalado.

### Ejecución desde la Terminal
Clona o descarga el proyecto y ejecuta el siguiente comando en la carpeta raíz:

```bash
godot --path .
```

## 📂 Estructura del Proyecto

*   `Main.tscn`: Escena principal que gestiona la lógica de generación y el ciclo de juego.
*   `Player.tscn`: Escena del personaje con lógica de físicas y animaciones.
*   `HUD.tscn`: Interfaz de usuario en pantalla durante el juego.
*   `*.gdshader`: Shaders para los efectos de lava, roca y fondo.
*   `GameManager.gd`: Singleton (Autoload) que gestiona el estado global (personaje seleccionado).

## 🎨 Créditos
Desarrollado como un prototipo funcional para entusiastas de Godot y los gatos.
