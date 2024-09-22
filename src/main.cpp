#include "raylib.h"
#include "common.hpp"
#include "player.hpp"

int main(void) {

    InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Feather Frenzy");
    SetTargetFPS(60);                   // Set our game to run at 60 frames-per-second

    Player* p1 = new Player(50.5f, 50.0f, RED);


    // Main game loop
    while(!WindowShouldClose()) {       // Detect window close button or ESC key
        
        BeginDrawing();
        ClearBackground(BLACK);
        p1->Draw();
        EndDrawing();
    }
    CloseWindow();                      // Close window and OpenGL context
    return 0;
}