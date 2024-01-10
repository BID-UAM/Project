#include "PeceraEyetracker.hpp"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void PeceraEyetracker::_bind_methods() {
}

PeceraEyetracker::PeceraEyetracker() {
	// Initialize any variables here.
	time_passed = 0.0;
}

PeceraEyetracker::~PeceraEyetracker() {
	// Add your cleanup here.
}

void PeceraEyetracker::_process(double delta) {
	//time_passed += delta;

	//Vector2 new_position = Vector2(10.0 + (10.0 * sin(time_passed * 2.0)), 10.0 + (10.0 * cos(time_passed * 1.5)));

	//set_position(new_position);

	x = gaze.data.avg.x;
	y = gaze.data.avg.y;
}

//int main() {
//    MyGaze g;
//	gtl::GazeData data;
//
//	while (true) {
//
//		std::cout << "Smoothed coordinates: " << g.data.avg.x << ", " << g.data.avg.y << std::endl;
//
//		std::cout << "Left eye: " << g.data.lefteye.avg.x << ", " << g.data.lefteye.avg.y << std::endl;
//
//		std::cout << "Right eye: " << g.data.righteye.avg.x << ", " << g.data.righteye.avg.y << std::endl;
//	}
//
//}

//int main() {
//	printf("main");
//}