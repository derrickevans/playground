package playground

import rl "vendor:raylib"

// Globals
window_width :: 896 // Constant
window_height :: 480 // Constant
player, enemy: Entity

// Do initialization
init :: proc() {
    rl.InitWindow(window_width, window_height, "Playground")
    rl.SetTargetFPS(60)
    
    player = entity_create(rl.Vector2 {0, 0}, "res/Warrior_Red.png", 6)
    enemy = entity_create(rl.Vector2 {200, 200}, "res/Torch_Yellow.png", 7)
    enemy.animation.num_frames = 7
}

handle_input :: proc(dt: f32) {
    if rl.IsMouseButtonPressed(.LEFT) {
        player.animation.state = .ATTACK
    }

    if rl.IsKeyDown(.W) {
        player.animation.state = .WALK
        player.position.y -= 100.0 * dt
    }

    if rl.IsKeyDown(.S) {
        player.animation.state = .WALK
        player.position.y += 100.0 * dt
    }

    if rl.IsKeyDown(.A) {
        player.animation.state = .WALK
        player.animation.frame.flip = true
        player.position.x -= 100.0 * dt
    }

    if rl.IsKeyDown(.D) {
        player.animation.state = .WALK
        player.animation.frame.flip = false
        player.position.x += 100.0 * dt
    }

    if rl.IsKeyReleased(.W) || rl.IsKeyReleased(.A) || rl.IsKeyReleased(.S) || rl.IsKeyReleased(.D) {
        player.animation.state = .IDLE
    }
}

// Update the state
update :: proc(dt: f32) {

    animation_play(&player)
    animation_play(&enemy)
    
    handle_input(dt)
}

// Draw the state to the screen
render :: proc() {
    rl.BeginDrawing()
    rl.ClearBackground(rl.DARKBLUE)
    entity_draw(&player)
    entity_draw(&enemy)
    rl.EndDrawing()
}

// Deinitialize
shutdown :: proc() {
    rl.CloseWindow()
}

main :: proc() {
    init()

    for !rl.WindowShouldClose() {
        update(rl.GetFrameTime())
        render()
    }

    shutdown()
}