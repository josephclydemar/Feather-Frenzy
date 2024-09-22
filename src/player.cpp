#include "player.hpp"

Player::Player(float posX, float posY, Color color) {
    this->pos.x = posX;
    this->pos.y = posY;
    this->color = color;

    this->size.x = 50.0f;
    this->size.y = 18.0f;

    this->body[0].x = this->pos.x + this->size.x * 0.4f;
    this->body[0].y = this->pos.y;

    this->body[1].x = this->pos.x + this->size.x * 0.5f;
    this->body[1].y = this->pos.y - this->size.y * 0.5f;

    this->body[2].x = this->pos.x - this->size.x * 0.2f;
    this->body[2].y = this->pos.y - this->size.y;

    this->body[3].x = this->pos.x - this->size.x * 0.5f;
    this->body[3].y = this->pos.y - this->size.y * 0.5f;

    this->body[4].x = this->pos.x - this->size.x * 0.4f;
    this->body[4].y = this->pos.y;

    this->body[5].x = this->pos.x + this->size.x * 0.4f;
    this->body[5].y = this->pos.y;
}

void Player::Draw(void) {
    this->Move();

    this->body[0].x = this->pos.x + this->size.x * 0.4f;
    this->body[0].y = this->pos.y;

    this->body[1].x = this->pos.x + this->size.x * 0.5f;
    this->body[1].y = this->pos.y - this->size.y * 0.5f;

    this->body[2].x = this->pos.x - this->size.x * 0.2f;
    this->body[2].y = this->pos.y - this->size.y;

    this->body[3].x = this->pos.x - this->size.x * 0.5f;
    this->body[3].y = this->pos.y - this->size.y * 0.5f;

    this->body[4].x = this->pos.x - this->size.x * 0.4f;
    this->body[4].y = this->pos.y;

    this->body[5].x = this->pos.x + this->size.x * 0.4f;
    this->body[5].y = this->pos.y;

    DrawSplineLinear(this->body, 6, 2.0f, this->color);
}


void Player::Move(void) {
    if(IsKeyDown(KEY_A)) this->pos.x -= 4.0f;
    else if(IsKeyDown(KEY_D)) this->pos.x += 4.0f;
}