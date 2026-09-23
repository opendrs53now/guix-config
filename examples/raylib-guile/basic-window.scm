#!/usr/bin/env guile
!#
(use-modules (raylib))

(InitWindow 800 450 "raylib-guile test")
(SetTargetFPS 60)

(let loop ()
  (unless (WindowShouldClose)
    (BeginDrawing)
    (ClearBackground RAYWHITE)
    (DrawText "raylib-guile works!" 190 200 20 LIGHTGRAY)
    (EndDrawing)
    (loop)))

(CloseWindow)
