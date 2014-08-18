
-- =============================================================================
--                          Screen helper library
-- =============================================================================

-- initialize the global screen table
g_screens = nil
function screen_init (s)
    g_screens = s
end

-- activate the specified screen
g_screen = nil
function screen_load (name)

    -- look up the screen name
    g_screen = g_screens[name]

    -- bail if not found
    if g_screen == nil
    then
        print ("screen " .. name .. " not found")
        return

    -- construct and memoize the screen if needed
    elseif type(g_screen) == "function"
    then
        print ("creating screen: " .. name)
        g_screen = screen_make (g_screen ())
        g_screens[name] = g_screen

    end
end

-- execute the active screen
function screen_exec ()
    local rc

    while true
    do
        -- execute the screen
        rc = dialog.Show (g_screen.d)

        -- look up the result handler
        rc = g_screen.m[rc]

        -- nil means to quit the app
        if rc == nil
        then
            print ("Quit (from button)")
            break

        -- strings are screen names
        elseif type(rc) == "string"
        then
            screen_load (rc)

        -- functions take parms from screen and return false to quit the app
        elseif type(rc) == "function"
        then
            rc = rc (g_screen.d)
            if rc == false
            then
                print ("Quit (from function)")
                break
            end
        end
    end
end

-- helper function to create a screen object
function screen_make (x)
    local d = dialog.CreateDialog (x.t)
    x.p (d)
    for k, v in ipairs (x.b)
    do
        d[v] = dialog.AddButton (v, k)
    end
    return {
        d = d,
        m = x.m,
    }
end


