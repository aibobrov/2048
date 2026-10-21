# 2048 for iOS

A native iOS implementation of the famous puzzle game [2048](https://en.wikipedia.org/wiki/2048_(video_game)), written in pure Swift 4 with UIKit.

<p align="center">
  <img src="./img/2048-gameplay.png" alt="2048 gameplay" width="30%">
  <img src="./img/2048-restart.png" alt="2048 restart confirmation" width="30%">
  <img src="./img/2048-lost.png" alt="2048 game over" width="30%">
</p>

## Features

- Classic 2048 gameplay: swipe up, down, left or right to slide and merge tiles, reach the **2048** tile to win.
- **Current score** and **high score** tracking, stored separately for every board dimension.
- **Game state persistence** — the board is restored exactly where you left it after relaunching the app.
- **Restart** button with a confirmation alert so you never lose progress by accident.
- **Configurable board size** — play 3×3, 5×5 or any other N×N board by changing a single value.
- Programmatic UI with **Auto Layout**, built without Interface Builder.

## Requirements

- Xcode 9 or later
- Swift 4.0
- iOS 11.0+

## Getting started

1. Clone the repository:
   ```sh
   git clone https://github.com/aibobrov/2048.git
   cd 2048
   ```
2. Open `2048.xcodeproj` in Xcode.
3. Select a simulator or a connected device and press **Run** (`⌘R`).

## Configuration

Gameplay constants live in [`ViewController.swift`](./2048/Gameplay/Controllers/ViewController.swift):

```swift
var dimensions: Int {   // board size (N×N), default 4×4
    return 4
}

var extraSpace: CGFloat { // spacing between tiles and screen edges
    return 13
}

var winValue: Int {     // tile value required to win
    return 2048
}
```

Change `dimensions` to play on a different board size — the layout, game logic and persistence adapt automatically.

## How it works

- **Persistence** — tiles are saved with **Core Data** (`TileModel`, `ScoreModel`, `HighScoreModel`), while the current score and high score are stored in **UserDefaults**, keyed by board dimension.
- **Game logic** — `GameLogicManager` handles moves, merges, spawning of new tiles and win/lose detection, and reports changes to the view layer through delegates.
- **Rendering** — `GameBoardRenderer` animates tile moves and merges on the `Board` view.
- **Input** — `UISwipeGestureRecognizer`s for all four directions are set up in `ViewControllerGestures.swift`.

## Project structure

```
2048/
├── AppDelegate.swift
├── Gameplay/
│   ├── Controllers/   # ViewController, gesture handling, delegate conformances
│   ├── Model/         # Tile, Position, Core Data models, ModelController (persistence)
│   ├── Services/      # GameLogicManager and its delegate protocols
│   └── View/          # Board, TileView, Score, HighScore, RestartButton, renderer, colors
├── Assets.xcassets
└── Base.lproj/LaunchScreen.storyboard
```

## License

Copyright © 2017 Artem Bobrov. All rights reserved.
