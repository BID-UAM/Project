## Consideraciones

En el proyecto, interesan las siguientes carpetas:
- src/ contiene la clase que se comunica con la API de The Eye Tribe por el puerto 6555, donde se implementan los algoritmos de detección de pestañeo, doble pestañeo y guiño en `MyGaze.cpp`; así como el nodo extensión de Godot que utiliza dicha funcionalidad en `PeceraEyetracker.cpp`. Dicho nodo se conecta al servidor con el método `gaze_connect()`.
- include/ contiene las cabeceras de las clases y sus funciones implementadas en src/.
- Pecera2D/ es el proyecto Godot del juego que incluye el DLL del proyecto para conectarse al Eye Tracker y mover al personaje con las coordenadas en pantalla.
  - El juego en formato Windows (PeceraEyetracker.exe) se encuentra comprimido en Pecera2D/export/PeceraEyetracker.zip, junto con la librería de enlace dinámico `libpeceraeyetracker.windows.template_release.x86_64.dll`.
  - Pecera2D/project.godot es el proyecto Godot como tal, abrirlo en Godot.
  - Para utilizar el Eye Tracker en el juego, se debe tener la EyeTribeUI ejecutada y el dispositivo conectado y calibrado. Además elegir "Usar Eye Tracker" en la segunda opción del menú principal.
- godot-cpp/ incluye código fuente de Godot para compilar la librería de la extensión GDExtension.
- tet-cpp-client-master/ incluye código de la API cliente para comunicarse con el servidor del Eye Tracker de The Eye Tribe.

También interesa la solución de Visual Studio "PeceraEyetracker.sln", donde se encuentran los proyectos juntados para visualizar más fácilmente.
Para compilar la librería, que se guardará en Pecera2D/bin/, ejecutar `scons platform=windows` en una terminal desde la raíz del proyecto. Se necesita:
- La librería SCons de Python, instalable con `pip3 install scons`.
- Especificar la librería de boost, instalable siguiendo pasos de https://github.com/EyeTribe/tet-cpp-client, en el fichero `SConstruct` de la carpeta raíz.

## Referencias

__The Eye Tribe__
- TET C++ Client. https://github.com/EyeTribe/tet-cpp-client
- TET C++ SDK Tutorial. https://theeyetribe.com/dev.theeyetribe.com/dev.theeyetribe.com/cpp/index.html
- API Reference. https://theeyetribe.com/dev.theeyetribe.com/dev.theeyetribe.com/api/index.html

__Godot__
- GDExtension C++ Example. https://docs.godotengine.org/en/stable/tutorials/scripting/gdextension/gdextension_cpp_example.html
- Visual Studio IDE Configuration. https://docs.godotengine.org/en/stable/contributing/development/configuring_an_ide/visual_studio.html
