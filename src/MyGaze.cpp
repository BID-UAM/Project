#include "PeceraEyetracker.hpp"

// --- MyGaze implementation
MyGaze::MyGaze()
    : m_api(0) // verbose_level 0 (disabled)
{
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

        // Comprobar pestañeo, doble pestañeo y guiño
        check_blink();
        if (blinking) {
            check_double_blink();
        }
        check_wink();
    }
}

gtl::GazeData MyGaze::get_data() {
    return data;
}

void MyGaze::check_blink() {
    // TODO


    if (blinking && true) { // intervalo threshold para blink
        /*last_blink = std::time(data.time.toInt());
        strftime()*/
    }
}

void MyGaze::check_double_blink() {
    //difftime(, last_blink)
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