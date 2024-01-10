#include "PeceraEyetracker.hpp"

// --- MyGaze implementation
MyGaze::MyGaze()
    : m_api(0) // verbose_level 0 (disabled)
{
    last_blink = -1;

    blinking = false;
    double_blinking = false;
    winking = false;

    // Connect to the server on the default TCP port (6555)
    if (m_api.connect())
    {
        // Enable GazeData notifications
        m_api.add_listener(*this);
    }
}

MyGaze::~MyGaze()
{
    m_api.remove_listener(*this);
    m_api.disconnect();
}

void MyGaze::on_gaze_data(gtl::GazeData const& gaze_data)
{
    if (gaze_data.state & gtl::GazeData::GD_STATE_TRACKING_GAZE)
    {
        data = gaze_data;

        // Comprobar pesta�eo, doble pesta�eo y gui�o
        check_blink();
        check_double_blink();
        check_wink();
    }
}

gtl::GazeData MyGaze::get_data() const {
    return data;
}

void MyGaze::check_blink() {
    // TODO
    int current_ms = data.time;


    if (!blinking && true) { // Umbral para considerar pesta�eo
        blinking = true;
        last_blink = current_ms;
    }
}

void MyGaze::check_double_blink() {
    // TODO

}

void MyGaze::check_wink() {
    // TODO

}

bool MyGaze::is_blinking() const {
    return blinking;
}

bool MyGaze::is_double_blinking() const {
    return double_blinking;
}

bool MyGaze::is_winking() const {
    return winking;
}