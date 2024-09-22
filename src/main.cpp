#include "raylib.h"
#include "common.hpp"

int main(void) {

    InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Feather Frenzy");
    SetTargetFPS(60);                   // Set our game to run at 60 frames-per-second


    // Main game loop
    while(!WindowShouldClose()) {       // Detect window close button or ESC key
        
        BeginDrawing();
        ClearBackground(BLACK);

        EndDrawing();
    }
    CloseWindow();                      // Close window and OpenGL context
    return 0;
}