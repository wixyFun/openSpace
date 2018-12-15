README

**-prerequisites**

1. Download and install Godot Engine 3.0.6: [https://godotengine.org/](https://godotengine.org/) 

    1. Install binary version for your platform, such as: [https://godotengine.org/download/windows](https://godotengine.org/download/windows) 

    2. Or  use the source files and compile yourself by following - [https://docs.godotengine.org/en/3.0/development/compiling/index.html](https://docs.godotengine.org/en/3.0/development/compiling/index.html) 

2. Clone the repository with submodules recursively:

    3. $ git clone --recursive [https://github.com/wixyFun/openSpace.git](https://github.com/wixyFun/openSpace.git)

3. Install boost library [https://www.boost.org/](https://www.boost.org/) 

4. Install odeint [http://headmyshoulder.github.io/odeint-v2/](http://headmyshoulder.github.io/odeint-v2/) 

5. Download precompiled libraries for SQLite database or compile your own: [https://github.com/khairul169](https://github.com/khairul169) and have lib folder containing libraries in the project folder

**-build application:**

1. Compile the C++ bindings for physics code

    1. $ cd path/to/project

    2. $ pushd godot-cpp

    3. $ scons platform=<windows/linux/osx> generate_bindings=yes

    4. $ popd

    5. $ scons platform=<windows/linux/osx> 

**-install and run:**

1. Open Godot Editor

2. Click scan on the editor to find the project

3. Click run to run the project 

**-test:**

1. For testing the godot script, please refer to this detailed post about unit testing script used in the project and an example on how to run the script and create more tests: 

    1.  [http://michaelb.org/unit-tests-for-your-godot-scripts/](http://michaelb.org/unit-tests-for-your-godot-scripts/)

    2. To run the existing unit tests on the godot script, please refer to the travis.yml and see how the  ./tests/menu/runtests.gd is run

2. For testing the C/C++  code of the project that is a part of the NativeGD library:

    3.  Refer to the travis.yml that runs the test.sh 

    4. Uses Doctest framework for unit testing

**-operate application :**

1. Add a planet

    1. Click on the "+" button

    2. Input desired name, mass, radius, coordinate, and velocity for a planet

    3. Click "Add"

    4. Add more planets, or set orbit on the right panel

2. Set orbits

    5. Each listbox on the right panel corresponds to a planet (call it A) whose orbit can be automatically calculated

    6. Select a planet (B) from a listbox will set the center of orbit for A

    7. A’s velocity will be updated so that it will orbit B if the entire galaxy contains only A and B

    8. If more bodies are present, the orbit may be affected by other bodies

    9. The algorithm tries to respect the original velocity setting and keep its inclination. When it cannot find a solution, an arbitrary inclination is chosen for the circular orbit.

3. Save the data

    10. In the simulation screen, press ‘+’ to add the data to be saved or used in simulation

    11. Enter the data and make sure that values for mass and radius are positive numeric values, name can contain any type of data and the rest are numeric positive or negative. You will have a maximum of 20 characters precision enabled in the application

    12. Press "ADD" first before pressing “Save” since only added data will be saved

    13. Can add and save multiple values

4. Reload the saved data

    14. Make sure you have a saved data since otherwise there will be no way of getting into the load previous data screen

    15. Press "load previous games" button and choose the project to load into the simulations

    16. The data in that project will be displayed in the right panel

    17. Press "load project" under the  data to load the data into the simulation

5. Delete the saved data

    18. Follow the instructions for reload the saved data till point d.

    19. Press "delete project" to permanently delete the project data 

6. Observe simulation closer/faster:

    20. Use the speed up and slow down buttons in the simulation screen to make the planets in the simulation move faster/slower

    21. Use arrow keys to move the camera around 

**-documentation:**

* GUI Classes:

    * **_Components Classes:_**

        * Main_button.gd: extends Button Node to customize the buttons appearance in the application

        * center_container.gd: extends CenterContainer Node with methods to customize its appearance and to be used for centering the child components in the layout

        * controls.gd: extends Node with data fields to keep track of the smaller controllers used in the layout and methods to instantiate various types of the controllers such as buttons and option buttons

        * message_box.gd: extends CenterContainer Node with methods to customize its appearance and position on the screen and data label to hold the customizable prompts for user

    * **_Layout Classes:_**

        * base_layout.gd: extends the Grid Node, used to maintain the desirable position of the smaller components on the screen, uses center_container and message_box for full layout needed by the menus

        * menu_layout.gd: extends the base_layout.gd, used for containing and organizing components on the screen for the main_menu_scene.gd 

        * loadPrev_layout.gd: extends base_layout.gd, used as the layouts above but for the load_prev_menu.gd

    * **_Scene Classes/Scripts:_**

        * start_menu.gd: the first screen in the application, directs user to the load_prev_menu screen, NBodyScene screen or allows user to exit the application

        * main_menu_scene.gd: main/simulation screen of the application, allows user to enter the data for the planets, to control the camera and speed in the simulation, as well as to save the data for later use.

        * load_prev_menu.gd: reload/delete the previously saved data, allows the user to delete past saved projects, or load them into simulation or play a new simulation, exit the application.

        * Load_prev_scene.tscn: class generated by the editor that has the load_prev_menu.gd attach to it and can be instantiated by the game engine

        * Start_scene.tscn: class generated by the editor that has the main_menu_scene.gd attached to it and can be instantiated by the game engine

        * NBodyScene.gd: Maintains a singleton `NBodyVisualizer` and a camera. It also handles input to move camera or change simulation settings

* global.gd: a singleton that is autoloaded in the beginning of the run of the application and holds globally available data

* db.gd: extends the sqlite NativeGD library (https://github.com/khairul169/gdsqlite) and contains the basic database operations

* top_db.gd: extends the db.gd and contains queries and database operations specific to the application

* Godot to C++ binder

    * **_NBodyVisualizer_** is the class which binds GDScript to C++.

        * This class will construct and update a 3D space with planet meshes

        * It is also responsible for setting orbits of the planets

        * NBodyVisualizer.tscn is the scene file that can be instantiated by Godot

        * NBodyVisualizer.gd is the script used by the scene. All methods are in this file

* C++ to Godot binder

    * Function exports are defined in src/gdlibrary.cpp

    * Binder class is defined in `src/nbody/gdnbody.h` and `src/nbody/gdnbody.cpp`

    * The binder class is a wrapper around the physics class which converts requests and responses between Godot types and C++ types

* Physics simulator

    * Physics simulator is implemented as a header-only C++ class `NBodySimulator`

    * The class is defined in `src/nbody/NBPhysics.hpp`

    * This class uses Eigen in its state vectors, and uses `boost::odeint` to simulate the nbody movement

    * The integrator used is `symplectic_rkn_sb3a_mclachlan` to conserve energy and handle large time steps

