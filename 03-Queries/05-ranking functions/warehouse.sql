
------FUNKCJE RANKINGOWE--------------------------------------------------------------------------------------------------------

-- Ranking powiatów po liczbie wystawionych recept dla zrealizowanych wizyt
SELECT 
    sub.id_powiat,
    dp.nazwa AS powiat,
    sub.liczba_recept,
    RANK() OVER (ORDER BY sub.liczba_recept DESC) AS miejsce
FROM (
    SELECT 
        fw.id_powiat,
        COUNT(fw.id_recepty) AS liczba_recept
    FROM wizyty fw
    JOIN status s ON fw.id_status = s.id_status
    WHERE s.status = 'zrealizowana'
    GROUP BY fw.id_powiat
) sub
JOIN powiat dp ON sub.id_powiat = dp.id_powiat
ORDER BY miejsce;

-- Ranking przychodni po liczbie zrealizowanych wizyt
SELECT 
    sub.id_przychodni,
    dp.nazwa AS przychodnia,
    sub.liczba_wizyt,
    DENSE_RANK() OVER (ORDER BY sub.liczba_wizyt DESC) AS miejsce
FROM (
    SELECT 
        fw.id_przychodni,
        COUNT(fw.id_wizyty) AS liczba_wizyt
    FROM wizyty fw
    JOIN status s ON fw.id_status = s.id_status
    WHERE s.status = 'zrealizowana'
    GROUP BY fw.id_przychodni
) sub
JOIN przychodnie dp ON sub.id_przychodni = dp.id_przychodni
ORDER BY miejsce;

-- Ranking przychodni w każdym województwie wg liczby pacjentów
SELECT 
    sub.id_wojewodztwo,
    dw.nazwa AS wojewodztwo,
    sub.id_przychodni,
    dp.nazwa AS przychodnia,
    sub.liczba_pacjentow,
    RANK() OVER (PARTITION BY sub.id_wojewodztwo ORDER BY sub.liczba_pacjentow DESC) AS miejsce
FROM (
    SELECT 
        fw.id_wojewodztwo,
        fw.id_przychodni,
        COUNT(DISTINCT fw.id_pacjenta) AS liczba_pacjentow
    FROM wizyty fw
    JOIN status s ON fw.id_status = s.id_status
    WHERE s.status = 'zrealizowana'
    GROUP BY fw.id_wojewodztwo, fw.id_przychodni
) sub
JOIN wojewodztwo dw ON sub.id_wojewodztwo = dw.id_wojewodztwo
JOIN przychodnie dp ON sub.id_przychodni = dp.id_przychodni
ORDER BY sub.id_wojewodztwo, miejsce;
