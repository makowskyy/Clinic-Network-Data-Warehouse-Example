
------PARTYCJE OBLICZENIOWE--------------------------------------------------------------------------------------------------------

-- Liczba zrealizowanych wizyt danego pacjenta u konkretnego lekarza w poszczególnych województwach
SELECT 
    sub.id_wojewodztwo,
    dw.nazwa AS wojewodztwo,
    sub.id_pacjenta,
    dp.nazwisko AS nazwisko_pacjenta,
    sub.id_lekarza,
    dl.nazwisko AS nazwisko_lekarza,
    sub.liczba_wizyt,
    COUNT(*) OVER (PARTITION BY sub.id_lekarza) AS wizyty_ogolem_lekarza
FROM (
    SELECT 
        fw.id_wojewodztwo,
        fw.id_pacjenta,
        fw.id_lekarza,
        COUNT(fw.id_wizyty) AS liczba_wizyt
    FROM wizyty fw
    JOIN status s ON fw.id_status = s.id_status
    WHERE s.status = 'zrealizowana'
    GROUP BY fw.id_wojewodztwo, fw.id_pacjenta, fw.id_lekarza
) sub
JOIN lekarze dl ON sub.id_lekarza = dl.id_lekarza
JOIN pacjenci dp ON sub.id_pacjenta = dp.id_pacjenta
JOIN wojewodztwo dw ON sub.id_wojewodztwo = dw.id_wojewodztwo
ORDER BY sub.id_wojewodztwo, sub.liczba_wizyt DESC;

-- Liczba recept wystwionych przez lekarza dla zrealizowanych wizyt oraz suma wszystkich recept lekarzy w województwie
SELECT 
    sub.id_wojewodztwo,
    dw.nazwa AS wojewodztwo,
    sub.id_lekarza,
    dl.nazwisko AS nazwisko_lekarza,
    sub.liczba_recept,
    SUM(sub.liczba_recept) OVER (PARTITION BY sub.id_wojewodztwo) AS suma_recept_w_woj
FROM (
    SELECT 
        fw.id_wojewodztwo,
        fw.id_lekarza,
        COUNT(fw.id_recepty) AS liczba_recept
    FROM wizyty fw
    JOIN status s ON fw.id_status = s.id_status
    WHERE s.status = 'zrealizowana'
    GROUP BY fw.id_wojewodztwo, fw.id_lekarza
) sub
JOIN wojewodztwo dw ON sub.id_wojewodztwo = dw.id_wojewodztwo
JOIN lekarze dl ON sub.id_lekarza = dl.id_lekarza
ORDER BY sub.id_wojewodztwo, sub.id_lekarza;

-- Numeruje badania pacjentów w ramach każdej przychodni według daty wizyty
SELECT 
    sub.id_przychodni,
    dp.nazwa AS przychodnia,
    sub.id_pacjenta,
    dpac.nazwisko AS pacjent,
    TO_CHAR(TO_DATE(r.rok || '-' || m.id_miesiac || '-' || dz.dzien, 'YYYY-MM-DD'), 'DD/MM/YYYY') AS data_wizyty,
    ROW_NUMBER() OVER (
        PARTITION BY sub.id_przychodni, sub.id_pacjenta
        ORDER BY r.rok, m.id_miesiac, dz.dzien
    ) AS nr_badania
FROM (
    SELECT 
        fw.id_przychodni,
        fw.id_pacjenta,
        fw.id_dzien,
        fw.id_miesiac,
        fw.id_rok
    FROM wizyty fw
    WHERE fw.id_badania IS NOT NULL
) sub
JOIN przychodnie dp ON sub.id_przychodni = dp.id_przychodni
JOIN pacjenci dpac ON sub.id_pacjenta = dpac.id_pacjenta
JOIN dzien dz ON sub.id_dzien = dz.id_dzien
JOIN miesiac m ON sub.id_miesiac = m.id_miesiac
JOIN rok r ON sub.id_rok = r.id_rok
ORDER BY sub.id_przychodni, sub.id_pacjenta, r.rok, m.id_miesiac, dz.dzien;
