
#ifndef PLAYER_H
#define PLAYER_H

#include "raylib.h"

class Player {
    private:
        Vector2 pos;
        Vector2 size;
        Vector2 body[6];
        Color color;

    public:
        Player(float posX, float posY, Color color);
        void Draw(void);
        void Move(void);
};

#endif

