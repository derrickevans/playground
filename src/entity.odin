package playground

import rl "vendor:raylib"

//Texture_Type :: union { rl.Texture2D, Animation }

Entity :: struct {
    position: rl.Vector2,
    animation: Animation
}

entity_create :: proc(postion: rl.Vector2, spritesheet: string, num_frames: i32) -> (entity: Entity) {
    entity.position = postion
    entity.animation = animation_create(spritesheet, num_frames)
    return entity
}

entity_draw :: proc(e: ^Entity) {
    //rl.DrawTexturePro(texture, src, dest, origin, rotation, color)
    if e.animation.frame.flip {
        // Flip the frame
        rl.DrawTexturePro(e.animation.spritesheet,
            rl.Rectangle {e.animation.src_rect.x, e.animation.src_rect.y, -f32(e.animation.frame.width), f32(e.animation.frame.height)},
            rl.Rectangle {e.position.x, e.position.y, f32(e.animation.frame.width), f32(e.animation.frame.height)}, rl.Vector2 {0, 0},
            0,
            rl.WHITE
        )
    } else {
        rl.DrawTexturePro(e.animation.spritesheet,
            rl.Rectangle {e.animation.src_rect.x, e.animation.src_rect.y, f32(e.animation.frame.width), f32(e.animation.frame.height)},
            rl.Rectangle {e.position.x, e.position.y, f32(e.animation.frame.width), f32(e.animation.frame.height)}, rl.Vector2 {0, 0},
            0,
            rl.WHITE
        )

    } 
    rl.DrawRectangleLinesEx(rl.Rectangle {e.position.x, e.position.y, f32(e.animation.frame.width), f32(e.animation.frame.height)}, 2.0, rl.LIME)
}