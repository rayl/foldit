-- -----------------------------------------------------------------------------
-- Restart the design problem from scratch

function reset_puzzle (d)
    puzzle.StartOver ()
    create_aa ()
    create_ss ()
    freeze_ss (d)
    create_bands ()
    --create_cuts ()
    selection.DeselectAll ()
    return true
end

-- set the types of amino acids
function create_aa ()
    create_ends ()
    create_strands ()
    --create_connectors ()
end

-- create 2 ends
function create_ends ()
end

-- create 7 strands
function create_strands ()

    -- create 4 phobics
    selection.DeselectAll ()
    for i = 2,75,11
    do
        selection.Select (i)
        selection.Select (i+2)
        selection.Select (i+4)
        selection.Select (i+6)
    end
    structure.SetAminoAcidSelected ("i")

    -- create 3 philics
    selection.DeselectAll ()
    for i = 2,75,11
    do
        selection.Select (i+1)
        selection.Select (i+3)
        selection.Select (i+5)
    end
    structure.SetAminoAcidSelected ("s")

end

-- create 6 random connectors
function create_connectors (d)

    selection.DeselectAll ()
    for i = 2,64,11
    do
        selection.SelectRange (i+7, i+10)
    end
    structure.MutateSidechainsSelected (1)
    structure.RebuildSelected (1)

    return false
end



-- -----------------------------------------------------------------------------
-- set up secondary structure

function create_ss ()

    -- set entire puzzle to SHEET
    selection.SelectAll ()
    structure.SetSecondaryStructureSelected ("e")

    -- set ends and connectors to LOOP
    selection.DeselectAll ()
    selection.Select (1)
    selection.Select (75)
    for i = 2,64,11
    do
        selection.SelectRange (i+7,i+10)
    end
    structure.SetSecondaryStructureSelected ("l")

end



-- -----------------------------------------------------------------------------
-- freeze secondary structure

function freeze_ss (d)

    -- freeze the beta sheets
    selection.DeselectAll ()
    for i = 2,75,11
    do
        selection.SelectRange (i,i+6)
    end
    freeze.FreezeSelected (true, true)

    return true
end



-- -----------------------------------------------------------------------------
-- band the philics on adjacent strands

function create_bands ()
    print ("create_bands")

    band.DeleteAll ()
    for i = 2,64,11
    do
        band.AddBetweenSegments (i+1, i+1+11+4)
        band.AddBetweenSegments (i+3, i+3+11  )
        band.AddBetweenSegments (i+5, i+5+11-4)
    end
    band.AddBetweenSegments (2+1, 68+1)
    band.AddBetweenSegments (2+3, 68+3)
    band.AddBetweenSegments (2+5, 68+5)
    band.EnableAll ()

end
