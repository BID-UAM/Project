#include "PeceraEyetracker.hpp"

// --- MyGaze implementation
MyGaze::MyGaze()
    : m_api(0) // verbose_level 0 (disabled)
{
    data = gtl::GazeData();

    last_blink = -1;
    first_wink = -1;

    blinking = false;
    double_blinking = false;
    winking = false;
}

MyGaze::~MyGaze()
{
    disconnect();
}

void MyGaze::connect()
{
    // Connect to the server on the default TCP port (6555)
    if (m_api.connect())
    {
        // Enable GazeData notifications
        m_api.add_listener(*this);
    }
}

void MyGaze::disconnect()
{
    if (m_api.is_connected()) {
        m_api.remove_listener(*this);
        m_api.disconnect();
    }
}

void MyGaze::on_gaze_data(gtl::GazeData const& gaze_data)
{
    data = gaze_data;

    // Comprobar pestañeo, doble pestañeo y guiño
    check_blink();
    check_double_blink();
    check_wink();

}

gtl::GazeData MyGaze::get_data() const {
    return data;
}

void MyGaze::check_blink() {
    // Comprobar si se estan detectando ambos ojos
    if (!get_state(gtl::GazeData::GD_STATE_TRACKING_GAZE)) {
        blinking = true;
    }
    else {
        // Guardar ultimo instante
        if (blinking)
            last_blink = data.time;
        blinking = false;
    }
}

void MyGaze::check_double_blink() {
    int inter_blink_interval = data.time - last_blink;
    
    // Umbrales para considerar doble pestañeo
    if (blinking && ((unsigned)(inter_blink_interval - MIN_INTERVAL)
        < (MAX_DBLINK_INTERVAL - MIN_INTERVAL))) {
        double_blinking = true;
    }
    else {
        double_blinking = false;
    }
}

void MyGaze::check_wink() {
    // Comprobar que se detecta bien al menos un ojo y que no hubo blink justo antes
    if (!blinking && ((data.time - last_blink) > MIN_INTERVAL)) {
        bool lefteye_wink = data.lefteye.avg.x == 0 && data.lefteye.avg.y == 0;
        bool righteye_wink = data.righteye.avg.x == 0 && data.righteye.avg.y == 0;
        
        // Comprobar wink
        if ((lefteye_wink != righteye_wink)) {
            // Guardar primer instante
            if (!first_wink)
                first_wink = data.time;

            // Comprobar intervalo desde posible comienzo de wink
            if ((data.time - first_wink) > MIN_INTERVAL)
                winking = true;
        }
        else {
            winking = false;
            first_wink = 0;
        }
    }
    else {
        winking = false;
        first_wink = 0;
    }
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

bool MyGaze::get_state(int mask) const {
    return (data.state & mask);
}
