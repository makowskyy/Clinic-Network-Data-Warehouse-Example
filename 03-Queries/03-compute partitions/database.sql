
------PARTYCJE OBLICZENIOWE----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Liczba zrealizowanych wizyt danego pacjenta u konkretnego lekarza w poszczególnych województwach
SELECT
    sub.id_wojewodztwo,
    (SELECT nazwa FROM wojewodztwo w2 WHERE w2.id_wojewodztwo = sub.id_wojewodztwo) AS wojewodztwo,
    sub.id_pacjenta,
    (SELECT nazwisko FROM pacjenci p2 WHERE p2.id_pacjenta = sub.id_pacjenta) AS nazwisko_pacjenta,
    sub.id_lekarza,
    (SELECT nazwisko FROM lekarze l2 WHERE l2.id_lekarza = sub.id_lekarza) AS nazwisko_lekarza,
    sub.liczba_wizyt,
    AVG(sub.liczba_wizyt) OVER (PARTITION BY sub.id_wojewodztwo) AS srednia_wizyt_woj
FROM (
    SELECT
        w.id_wojewodztwo,
        pa.id_pacjenta,
        l.id_lekarza,
        COUNT(wz.id_wizyty) AS liczba_wizyt
    FROM wizyty wz
    JOIN pacjenci pa ON wz.id_pacjenta = pa.id_pacjenta
    JOIN przychodnie p ON wz.id_przychodni = p.id_przychodni
    JOIN miejscowosc m ON m.id_miejscowosc = p.id_miejscowosc
    JOIN gmina g ON g.id_gmina = m.id_gmina
    JOIN powiat po ON po.id_powiat = g.id_powiat
    JOIN wojewodztwo w ON w.id_wojewodztwo = po.id_wojewodztwo
    JOIN lekarze l ON l.id_lekarza = wz.id_lekarza
    WHERE wz.status = 'zrealizowana'
    GROUP BY w.id_wojewodztwo, pa.id_pacjenta, l.id_lekarza
) sub
ORDER BY sub.id_wojewodztwo, sub.liczba_wizyt DESC;

-- Liczba recept wystwionych przez lekarza dla zrealizowanych wizyt oraz suma wszystkich recept lekarzy w województwie
SELECT 
    sub.id_wojewodztwo,
    (SELECT nazwa FROM wojewodztwo w2 WHERE w2.id_wojewodztwo = sub.id_wojewodztwo) AS wojewodztwo,
    sub.id_lekarza,
    (SELECT nazwisko FROM lekarze l2 WHERE l2.id_lekarza = sub.id_lekarza) AS nazwisko_lekarza,
    sub.liczba_recept,
    SUM(sub.liczba_recept) OVER (PARTITION BY sub.id_wojewodztwo) AS suma_recept_w_wojewodztwie
FROM (
    SELECT 
        w.id_wojewodztwo,
        l.id_lekarza,
        COUNT(r.id_recepty) AS liczba_recept
    FROM wizyty wz
    JOIN recepty r ON wz.id_recepty = r.id_recepty
    JOIN lekarze l ON wz.id_lekarza = l.id_lekarza
    JOIN przychodnie p ON wz.id_przychodni = p.id_przychodni
    JOIN miejscowosc m ON p.id_miejscowosc = m.id_miejscowosc
    JOIN gmina g ON m.id_gmina = g.id_gmina
    JOIN powiat pow ON g.id_powiat = pow.id_powiat
    JOIN wojewodztwo w ON pow.id_wojewodztwo = w.id_wojewodztwo
    WHERE wz.status = 'zrealizowana'
    GROUP BY w.id_wojewodztwo, l.id_lekarza
) sub
ORDER BY sub.id_wojewodztwo, sub.id_lekarza;

-- Numeruje badania pacjentów w ramach każdej przychodni według daty wizyty
SELECT 
    sub.id_przychodni,
    (SELECT nazwa FROM przychodnie p2 WHERE p2.id_przychodni = sub.id_przychodni) AS przychodnia,
    sub.id_pacjenta,
    (SELECT nazwisko FROM pacjenci p2 WHERE p2.id_pacjenta = sub.id_pacjenta) AS pacjent,
    sub.data_wizyty,
    ROW_NUMBER() OVER (PARTITION BY sub.id_przychodni, sub.id_pacjenta ORDER BY sub.data_wizyty) AS nr_badania
FROM (
    SELECT 
        wz.id_przychodni,
        wz.id_pacjenta,
        wz.data_wizyty
    FROM wizyty wz
    WHERE wz.id_badania IS NOT NULL
) sub
ORDER BY sub.id_przychodni, sub.id_pacjenta, sub.data_wizyty;
