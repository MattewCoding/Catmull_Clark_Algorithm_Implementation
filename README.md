# Catmull Clark Algorithm Implementation
[![fr](https://img.shields.io/badge/lang-fr-fr)](https://github.com/MattewCoding/Catmull_Clark_Algorithm_Implementation/blob/main/README.fr.md)

An implementation of the Catmull-Clark algorithm in Processing (Java).

## Getting Started

### Prerequisites
Make sure you have Processing installed on your machine. You can download it from Processing.org.

### Installation
Clone or download this repository to your local machine.
```bash
git clone https://github.com/your-username/processing-sandbox.git
```

Open the project in Processing by double-clicking the .pde file or navigating to "File > Open" within the Processing IDE.

## Running the Program

Once you have the project open in Processing, simply click the "Run" button (a play icon) in the top-left corner of the Processing IDE.
This will compile and execute the program, launching a window displaying the visual output.

## Project Overview
Once you've entered the program, you'll be greeting with a cube in the center and options on the left and right.

The left panel is used to select the specific shape to modify (cube, pyramid, torus), by clicking on the corresponding tickbox. Additional options open up if you choose the pyramid or torus. For the pyramid, you can modify its base. For the torus, you can select how many points are used to approximate the circle to draw the torus on. You can also select the number of times to apply the Catmull-Clark algorithm on the shape. **Notice:** The program drastically slows down at levels 3 and 4, and this is because the code is not that optimized. Be prepared to have the program freeze for a while as it runs the algorithm.

The right panel is used to modify the orientation of the shape, in the x or y plane, as well as adjust the distance from the camera (i.e. making it bigger or smaller).

## License
This project is licensed under the GPL 3.0 License - see `LICENSE.txt` for details.
