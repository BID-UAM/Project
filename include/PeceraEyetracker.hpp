#ifndef PECERA_EYETRACKER_H
#define PECERA_EYETRACKER_H

#include <iostream>

#include <gazeapi.h>

#include <godot_cpp/classes/node.hpp>

// --- MyGaze definition
class MyGaze : public gtl::IGazeListener
{
private:
    // IGazeListener
    void on_gaze_data(gtl::GazeData const& gaze_data);

	void check_blink();
	void check_double_blink();
	void check_wink();

private:
    gtl::GazeApi m_api;
	gtl::GazeData data;

	time_t last_blink;

	bool blinking;
	bool double_blinking;
	bool winking;

public:
    MyGaze();
    ~MyGaze();

	gtl::GazeData get_data();

	bool is_blinking() const;
	bool is_double_blinking() const;
	bool is_winking() const;
};

namespace godot {

	class PeceraEyetracker : public Node {
		GDCLASS(PeceraEyetracker, Node)

	private:
		MyGaze gaze;
		Vector2 coordinates;
		
	protected:
		static void _bind_methods();

	public:
		PeceraEyetracker();
		~PeceraEyetracker();

		void _process(double delta) override;

		void set_coordinates(Vector2 new_coordinates);
		Vector2 get_coordinates() const;

		bool is_blinking();
		bool is_double_blinking();
		bool is_winking();
	};

}

#endif