
-- =============================================================================
--                            Application screens
-- =============================================================================

-- return a table of all application screens
function all_screens ()
    return {
        main       = scr_main,
        second     = scr_foo,
        third      = scr_bar,
    }
end

-- -----------------------------------------------------------------------------
function scr_main ()
    return {
        t = "Problem 969",
        p = function (d)
            d.Instructions = dialog.AddLabel    ("Set these values:")
            d.Invert       = dialog.AddCheckbox ("Invert", true)
            d.Iterations   = dialog.AddSlider   ("Iterations", 3, 1, 25, 0)
        end,
        b = {
            "Reset",
            "Go",
            "Freeze",
            "Foo",
            "Quit",
        },
        m = {
            reset_puzzle,
            create_connectors,
            freeze_ss,
            "second",
            nil,
        }
    }
end

-- -----------------------------------------------------------------------------
function scr_foo ()
    return {
        t = "Foo",
        p = function (d)
            d.Instructions    = dialog.AddLabel    ("Second screen...")
        end,
        b = {
            "Bar",
            "Quit",
        },
        m = {
            "third",
            nil,
        }
    }
end

-- -----------------------------------------------------------------------------
function scr_bar ()
    return {
        t = "Bar",
        p = function (d)
            d.Instructions    = dialog.AddLabel    ("Final screen...")
        end,
        b = {
            "Restart",
            "Quit",
        },
        m = {
            "main",
            nil,
        }
    }
end
