#ifndef PECERA_EYETRACKER_H
#define PECERA_EYETRACKER_H

#include <iostream>

#include <gazeapi.h>

#include <godot_cpp/classes/node2d.hpp>

// --- MyGaze definition
class MyGaze : public gtl::IGazeListener
{
public:
	gtl::GazeData data;

    MyGaze();
    ~MyGaze();
private:
    // IGazeListener
    void on_gaze_data(gtl::GazeData const& gaze_data);
private:
    gtl::GazeApi m_api;
};

namespace godot {

	class PeceraEyetracker : public Node2D {
		GDCLASS(PeceraEyetracker, Node2D)

	private:
		double time_passed;
		MyGaze gaze;
		
	protected:
		static void _bind_methods();

	public:
		double x;
		double y;
		bool blinking;
		bool winking;

		PeceraEyetracker();
		~PeceraEyetracker();

		void _process(double delta) override;
	};

}

#endif