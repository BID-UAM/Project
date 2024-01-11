#include "PeceraEyetracker.hpp"
#include <godot_cpp/core/class_db.hpp>

using namespace godot;

void PeceraEyetracker::_bind_methods() {
}

PeceraEyetracker::PeceraEyetracker() {
	// Initialize any variables here.
	coordinates = Vector2(0, 0);

	ClassDB::bind_method(D_METHOD("gaze_connect"), &PeceraEyetracker::gaze_connect);
	ClassDB::bind_method(D_METHOD("gaze_disconnect"), &PeceraEyetracker::gaze_disconnect);

	ClassDB::bind_method(D_METHOD("get_coordinates"), &PeceraEyetracker::get_coordinates);
	ClassDB::bind_method(D_METHOD("set_coordinates", "new_coordinates"), &PeceraEyetracker::set_coordinates);
	ClassDB::add_property("PeceraEyetracker", PropertyInfo(Variant::VECTOR2, "coordinates"), "set_coordinates", "get_coordinates");
	
	ClassDB::bind_method(D_METHOD("is_blinking"), &PeceraEyetracker::is_blinking);
	ClassDB::bind_method(D_METHOD("is_double_blinking"), &PeceraEyetracker::is_double_blinking);
	ClassDB::bind_method(D_METHOD("is_winking"), &PeceraEyetracker::is_winking);

	ClassDB::bind_method(D_METHOD("get_state", "mask"), &PeceraEyetracker::get_state);
	ClassDB::bind_method(D_METHOD("get_lefteye_coordinates"), &PeceraEyetracker::get_lefteye_coordinates);
	ClassDB::bind_method(D_METHOD("get_righteye_coordinates"), &PeceraEyetracker::get_righteye_coordinates);
}

PeceraEyetracker::~PeceraEyetracker() {
	// Add your cleanup here.
	gaze_disconnect();
}

void PeceraEyetracker::gaze_connect() {
	gaze.connect();
}

void PeceraEyetracker::gaze_disconnect() {
	gaze.disconnect();
}

void PeceraEyetracker::_process(double delta) {
	if (get_state(gtl::GazeData::GD_STATE_TRACKING_GAZE)) {
		gtl::GazeData data = gaze.get_data();
		set_coordinates(Vector2(data.avg.x, data.avg.y));
	}
}

void PeceraEyetracker::set_coordinates(Vector2 new_coordinates) {
	coordinates = new_coordinates;
}

Vector2 PeceraEyetracker::get_coordinates() const {
	return coordinates;
}

Vector2 PeceraEyetracker::get_lefteye_coordinates() const {
	gtl::Point2D left_avg = gaze.get_data().lefteye.avg;
	return Vector2(left_avg.x, left_avg.y);
}

Vector2 PeceraEyetracker::get_righteye_coordinates() const {
	gtl::Point2D right_avg = gaze.get_data().righteye.avg;
	return Vector2(right_avg.x, right_avg.y);
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

bool PeceraEyetracker::get_state(int mask) {
	return gaze.get_state(mask);
}
