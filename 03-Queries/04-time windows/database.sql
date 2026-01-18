
------OKNA CZASOWE----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Liczba wizyt miesięcznie
SELECT 
    EXTRACT(YEAR FROM data_wizyty) AS rok,
    EXTRACT(MONTH FROM data_wizyty) AS miesiac,
    COUNT(*) AS liczba_wizyt
FROM wizyty
WHERE status = 'zrealizowana'
GROUP BY EXTRACT(YEAR FROM data_wizyty), EXTRACT(MONTH FROM data_wizyty)
ORDER BY rok, miesiac;


-- Liczba wizyt kwartal
SELECT 
    EXTRACT(YEAR FROM data_wizyty) AS rok,
    CEIL(EXTRACT(MONTH FROM data_wizyty) / 3) AS kwartal,
    COUNT(*) AS liczba_wizyt
FROM wizyty
WHERE status = 'zrealizowana'
GROUP BY EXTRACT(YEAR FROM data_wizyty), CEIL(EXTRACT(MONTH FROM data_wizyty) / 3)
ORDER BY rok, kwartal;

-- Liczba recept wypisanych codziennie 2024-2025
SELECT 
    EXTRACT(YEAR FROM r.data_wystawienia) AS rok,
    EXTRACT(MONTH FROM r.data_wystawienia) AS miesiac,
    EXTRACT(DAY FROM r.data_wystawienia) AS dzien,
    COUNT(*) AS liczba_recept
FROM recepty r
WHERE r.data_wystawienia IS NOT NULL
  AND EXTRACT(YEAR FROM r.data_wystawienia) IN (2024, 2025)
GROUP BY 
    EXTRACT(YEAR FROM r.data_wystawienia),
    EXTRACT(MONTH FROM r.data_wystawienia),
    EXTRACT(DAY FROM r.data_wystawienia)
ORDER BY rok, miesiac, dzien;
