## Consideraciones

En el proyecto, interesan las siguientes carpetas:
- __src/__ contiene la clase que se comunica con la API de The Eye Tribe por el puerto 6555, donde se implementan los algoritmos de detección de pestañeo, doble pestañeo y guiño en `MyGaze.cpp`; así como el nodo extensión de Godot que utiliza dicha funcionalidad en `PeceraEyetracker.cpp`. Dicho nodo se conecta al servidor con el método `gaze_connect()`.
- __include/__ contiene las cabeceras de las clases y sus funciones implementadas en src/.
- __Pecera2D/__ es el proyecto Godot del juego que incluye el DLL del proyecto para conectarse al Eye Tracker y mover al personaje con las coordenadas en pantalla.
  - El juego en formato Windows (PeceraEyetracker.exe) se encuentra comprimido en __Pecera2D/export/PeceraEyetracker.zip__, junto con la librería de enlace dinámico `libpeceraeyetracker.windows.template_release.x86_64.dll`.
  - Pecera2D/project.godot es el fichero de descripción del proyecto Godot, ejecutable desde Godot.
  - Para utilizar el Eye Tracker en el juego, se debe tener la aplicación __EyeTribe UI__ ejecutada y el dispositivo conectado y calibrado. Además, elegir "Usar Eye Tracker" en la segunda opción del menú principal.
- __godot-cpp/__ incluye código fuente de Godot para compilar la librería de la extensión GDExtension.
- __tet-cpp-client-master/__ incluye código de la API cliente para comunicarse con el servidor del Eye Tracker de The Eye Tribe.

También interesa la solución de Visual Studio `PeceraEyetracker.sln`, donde se encuentran los proyectos juntados para visualizar más fácilmente.
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
