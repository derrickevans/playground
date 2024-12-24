package playground

import "core:strings"
import rl "vendor:raylib"

// The state of the aniamtion. Corresponds to the spritesheet row
Entity_State :: enum {
    IDLE,
    WALK,
    ATTACK
}

Frame :: struct {
    width: i32,
    height: i32,
    speed: i32,
    flip: bool
}

Animation :: struct {
    spritesheet: rl.Texture2D,
    position: rl.Vector2,
    src_rect: rl.Rectangle,
    frame: Frame,
    current_frame: i32,
    frame_counter: i32,
    num_frames: i32,
    state: Entity_State
}

// Create a new animation
animation_create :: proc(filepath: string, total_animimation_frames: i32) -> (animation: Animation) {
    animation.spritesheet = rl.LoadTexture(strings.clone_to_cstring(filepath, context.temp_allocator))
    animation.position = rl.Vector2 {0, 0}
    animation.src_rect = rl.Rectangle {0, 0, f32(animation.frame.width), f32(animation.frame.height)}
    animation.frame = Frame {
        width = 192,
        height = 192,
        speed = 10,
        flip = false
    }
    animation.current_frame = 0
    animation.frame_counter = 0
    animation.num_frames = total_animimation_frames
    animation.state = .IDLE
  
    // Frees the temp allocator from the string to cstring clone
    free_all(context.temp_allocator)
    return animation
}


animation_play :: proc(entity: ^Entity) {
    entity.animation.frame_counter += 1

    if (entity.animation.frame_counter >= (60 / entity.animation.frame.speed)) {
        entity.animation.frame_counter = 0
        entity.animation.current_frame += 1

        if entity.animation.current_frame > (entity.animation.num_frames - 1) {
            entity.animation.current_frame = 0
        }

        entity.animation.src_rect.x = f32(entity.animation.current_frame * (entity.animation.spritesheet.width / entity.animation.num_frames))
        entity.animation.src_rect.y = f32(i32(entity.animation.state) * entity.animation.frame.height)
    }
}
