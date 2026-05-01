-- Scale down map sizes for faster gameplay
UPDATE Worlds
SET
    GridWidth = CASE
        -- Calculate new size, round to nearest INT, then subtract 1 if odd to make sure it's even
        -- Use MAX to set minimum map size; smaller sizes might cause crashes
        WHEN ROUND(GridWidth * 0.45) % 2 = 1
            THEN MAX(16, ROUND(GridWidth * 0.45) - 1)
        ELSE MAX(16, ROUND(GridWidth * 0.45))
    END,
    GridHeight = CASE
        WHEN ROUND(GridHeight * 0.45) % 2 = 1
            THEN MAX(10, ROUND(GridHeight * 0.45) - 1)
        ELSE MAX(10, ROUND(GridHeight * 0.45))
    END;

-- Scale down natural wonders too. Technically this should be
-- NumNaturalWonders * 0.4 * 0.4 (map size is width and height) but that seems too
-- extreme. Adjust as needed.
UPDATE Worlds
SET NumNaturalWonders = ROUND(NumNaturalWonders * 0.4);
