-- Input configuration
-- https://wiki.hypr.land/Configuring/Basics/Variables/
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/

hl.config({
    input = {
        kb_layout     = "us",
        kb_variant    = "",
        kb_model      = "",
        kb_options    = "",
        kb_rules      = "",
        repeat_rate   = 50,
        repeat_delay  = 200,
        follow_mouse  = 1,
        sensitivity   = -0.5,
        accel_profile = "flat",

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- https://wiki.hypr.land/Configuring/Gestures/
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

-- Per-device overrides
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
hl.device({
    name          = "asuf1204:00-2808:0202-touchpad",
    sensitivity   = 0.0,
    accel_profile = "adaptive",
})
