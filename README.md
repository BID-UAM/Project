En el proyecto, interesan las siguientes carpetas:
- src/ contiene la implementación de los algoritmos de detección de pestañeo, doble pestañeo y guiño, además de la clase que se comunica a la API de The Eye Tribe por el puerto 6555 por TCP; y el nodo extensión de Godot que utiliza dicha funcionalidad.
- include/ contiene las cabeceras de las clases y sus funciones implementadas en src/
- Pecera2D/ es el proyecto Godot del juego que incluye el DLL del proyecto para conectarse al Eye Tracker y mover al personaje con las coordenadas en pantalla.
  - El juego en formato Windows (PeceraEyetracker.exe) se encuentra comprimido en Pecera2D/export/PeceraEyetracker.zip, junto con la librería dinámica libpeceraeyetracker.windows.template_release.x86_64.dll.
  - Pecera2D/project.godot es el proyecto Godot como tal, abrirlo en Godot.
  - Para utilizar el Eye Tracker en el juego, se debe tener la EyeTribeUI ejecutada y el dispositivo conectado y calibrado.
- godot-cpp/ incluye código fuente de Godot para compilar la librería de la extensión GDExtension.
- tet-cpp-client-master/ incluye código de la API cliente para comunicarse con el servidor del Eye Tracker de The Eye Tribe.

También interesa la solución de Visual Studio "PeceraEyetracker.sln", donde se encuentran los proyectos juntados para visualizar más fácilmente.
Para compilar la librería, que se guardará en Pecera2D/bin/, ejecutar `scons platform=windows` en una terminal desde la raíz del proyecto. Se necesita:
- La librería SCons de Python, instalable con `pip3 install scons`.
- Especificar la librería de boost, instalable siguiendo pasos de https://github.com/EyeTribe/tet-cpp-client, en el fichero SConstruct de la carpeta raíz.
