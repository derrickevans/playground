package playground

import rl "vendor:raylib"

// Globals
window_width :: 896 // Constant
window_height :: 480 // Constant

// Do initialization
init :: proc() {
    rl.InitWindow(window_width, window_height, "Playground")

    rl.SetTargetFPS(60)
}

// Update the state
update :: proc() { 
}

// Draw the state to the screen
render :: proc() {
    rl.BeginDrawing()
    rl.ClearBackground(rl.DARKBLUE)
    rl.DrawText("Playground", 200, 200, 20, rl.WHITE)
    rl.EndDrawing()
}

// Deinitialize
shutdown :: proc() {
    rl.CloseWindow()
}

main :: proc() {
    init()

    for !rl.WindowShouldClose() {
        update()
        render()
    }

    shutdown()
}