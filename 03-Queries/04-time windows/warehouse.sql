
------OKNA CZASOWE--------------------------------------------------------------------------------------------------------

-- Liczba wizyt miesięcznie
SELECT 
    r.rok AS rok,
    m.id_miesiac AS miesiac,
    COUNT(*) AS liczba_wizyt
FROM wizyty fw
JOIN status s ON fw.id_status = s.id_status
JOIN rok r ON fw.id_rok = r.id_rok
JOIN miesiac m ON fw.id_miesiac = m.id_miesiac
WHERE s.status = 'zrealizowana'
GROUP BY r.rok, m.id_miesiac
ORDER BY r.rok, m.id_miesiac;

-- Liczba wizyt kwartal
SELECT 
    sub.rok,
    sub.kwartal,
    COUNT(*) AS liczba_wizyt
FROM (
    SELECT 
        fw.id_wizyty,
        r.rok,
        CEIL(m.id_miesiac / 3) AS kwartal
    FROM wizyty fw
    JOIN status s ON fw.id_status = s.id_status
    JOIN rok r ON fw.id_rok = r.id_rok
    JOIN miesiac m ON fw.id_miesiac = m.id_miesiac
    WHERE s.status = 'zrealizowana'
) sub
GROUP BY sub.rok, sub.kwartal
ORDER BY sub.rok, sub.kwartal;

-- Liczba recept wypisanych codziennie 2024-2025
SELECT 
    r.rok AS rok,
    m.id_miesiac AS miesiac,
    d.dzien AS dzien,
    COUNT(fw.id_recepty) AS liczba_recept
FROM wizyty fw
JOIN dzien d ON fw.id_dzien = d.id_dzien
JOIN miesiac m ON fw.id_miesiac = m.id_miesiac
JOIN rok r ON fw.id_rok = r.id_rok
WHERE fw.id_recepty IS NOT NULL
  AND r.rok IN (2024, 2025)
GROUP BY r.rok, m.id_miesiac, d.dzien
ORDER BY r.rok, m.id_miesiac, d.dzien;




