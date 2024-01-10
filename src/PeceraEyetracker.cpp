#include "PeceraEyetracker.hpp"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void PeceraEyetracker::_bind_methods() {
}

PeceraEyetracker::PeceraEyetracker() {
	// Initialize any variables here.

	ClassDB::bind_method(D_METHOD("get_coordinates"), &PeceraEyetracker::get_coordinates);
	ClassDB::bind_method(D_METHOD("set_coordinates", "new_coordinates"), &PeceraEyetracker::set_coordinates);
	ClassDB::add_property("PeceraEyetracker", PropertyInfo(Variant::VECTOR2, "coordinates"), "set_coordinates", "get_coordinates");
	
	ClassDB::bind_method(D_METHOD("is_blinking"), &PeceraEyetracker::is_blinking);
	ClassDB::bind_method(D_METHOD("is_double_blinking"), &PeceraEyetracker::is_double_blinking);
	ClassDB::bind_method(D_METHOD("is_winking"), &PeceraEyetracker::is_winking);
}

PeceraEyetracker::~PeceraEyetracker() {
	// Add your cleanup here.
}

void PeceraEyetracker::_process(double delta) {
	gtl::GazeData data = gaze.get_data();
	set_coordinates(Vector2(data.avg.x, data.avg.y));
}

void PeceraEyetracker::set_coordinates(Vector2 new_coordinates) {
	coordinates = new_coordinates;
}

Vector2 PeceraEyetracker::get_coordinates() const {
	return coordinates;
}

bool PeceraEyetracker::is_blinking() {
	return gaze.is_blinking();
}

bool PeceraEyetracker::is_double_blinking() {
	return gaze.is_double_blinking();
}

bool PeceraEyetracker::is_winking() {
	return gaze.is_winking();
}