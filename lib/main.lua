
-- =============================================================================
--                          Invoke the main loop
-- =============================================================================

function main ()
    screen_init (all_screens ())
    screen_load ("main")
    screen_exec ()
end

main ()
