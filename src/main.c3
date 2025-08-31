module c3_test;

import std::io;
import raylib5::rl;

fn int main(String[] args) {

  const int SCREEN_WIDTH = 800;
  const int SCREEN_HEIGHT = 450;

  rl::setConfigFlags(rl::FLAG_VSYNC_HINT);

  rl::initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "c3_test");

  Vector2 ballPosition = {-100.0f, -100.0f};
  Color ballColor = rl::DARKBLUE;

  // rl::setTargetFPS(240);

  while (!rl::windowShouldClose()) {
    if (rl::isKeyPressed(rl::KEY_H)) {
      if (rl::isCursorHidden()) {
        rl::showCursor();
      } else {
        rl::hideCursor();
      }
    }

    ballPosition = rl::getMousePosition();

    if (rl::isMouseButtonPressed(rl::MouseButton.LEFT)) {
      ballColor = rl::MAROON;
    } else if (rl::isMouseButtonPressed(rl::MouseButton.MIDDLE)) {
      ballColor = rl::LIME;
    } else if (rl::isMouseButtonPressed(rl::MouseButton.RIGHT)) {
      ballColor = rl::DARKBLUE;
    } else if (rl::isMouseButtonPressed(rl::MouseButton.SIDE)) {
      ballColor = rl::PURPLE;
    } else if (rl::isMouseButtonPressed(rl::MouseButton.EXTRA)) {
      ballColor = rl::YELLOW;
    } else if (rl::isMouseButtonPressed(rl::MouseButton.FORWARD)) {
      ballColor = rl::ORANGE;
    } else if (rl::isMouseButtonPressed(rl::MouseButton.BACK)) {
      ballColor = rl::BEIGE;
    }

    int fps = rl::getFPS();

    char[32] fps_buffer;
    ZString fps_slice = (ZString)io::bprintf(&fps_buffer, "%d\0", fps) !!;

    int fps_width = rl::measureText(fps_slice, 20);

    int width = rl::getRenderWidth();

    rl::beginDrawing();

    rl::clearBackground(rl::RAYWHITE);

    rl::drawCircleV(ballPosition, 40, ballColor);

    rl::drawText(fps_slice, width - fps_width - 10, 10, 20, rl::DARKGRAY);

    rl::drawText("move ball with mouse and click mouse button to change color",
                 10, 10, 20, rl::DARKGRAY);

    rl::drawText("Press 'H' to toggle cursor visibility", 10, 30, 20,
                 rl::DARKGRAY);

    if (!rl::isCursorHidden()) {
      rl::drawText("CURSOR HIDDEN", 20, 60, 20, rl::RED);
    } else {
      rl::drawText("CURSOR VISIBLE", 20, 60, 20, rl::LIME);
    }

    rl::endDrawing();
  }

  rl::closeWindow();

  return 0;
}
