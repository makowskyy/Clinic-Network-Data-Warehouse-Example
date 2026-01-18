
------FUNKCJE RANKINGOWE----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Ranking powiatów po liczbie wystawionych recept dla zrealizowanych wizyt
SELECT 
    sub.id_powiat,
    (SELECT nazwa FROM powiat p2 WHERE p2.id_powiat = sub.id_powiat) AS powiat,
    sub.liczba_recept,
    RANK() OVER (ORDER BY sub.liczba_recept DESC) AS miejsce
FROM (
    SELECT 
        pow.id_powiat,
        COUNT(r.id_recepty) AS liczba_recept
    FROM recepty r
    JOIN wizyty wz ON r.id_recepty = wz.id_recepty
    JOIN przychodnie p ON wz.id_przychodni = p.id_przychodni
    JOIN miejscowosc m ON p.id_miejscowosc = m.id_miejscowosc
    JOIN gmina g ON m.id_gmina = g.id_gmina
    JOIN powiat pow ON g.id_powiat = pow.id_powiat
    WHERE wz.status = 'zrealizowana'
    GROUP BY pow.id_powiat
) sub
ORDER BY miejsce;

-- Ranking przychodni po liczbie zrealizowanych wizyt
SELECT 
    sub.id_przychodni,
    (SELECT nazwa FROM przychodnie p2 WHERE p2.id_przychodni = sub.id_przychodni) AS przychodnia,
    sub.liczba_wizyt,
    DENSE_RANK() OVER (ORDER BY sub.liczba_wizyt DESC) AS miejsce
FROM (
    SELECT 
        wz.id_przychodni,
        COUNT(wz.id_wizyty) AS liczba_wizyt
    FROM wizyty wz
    WHERE wz.status = 'zrealizowana'
    GROUP BY wz.id_przychodni
) sub
ORDER BY miejsce;

-- Ranking przychodni w każdym województwie wg liczby pacjentów
SELECT 
    sub.id_wojewodztwo,
    (SELECT nazwa FROM wojewodztwo w2 WHERE w2.id_wojewodztwo = sub.id_wojewodztwo) AS wojewodztwo,
    sub.id_przychodni,
    (SELECT nazwa FROM przychodnie p2 WHERE p2.id_przychodni = sub.id_przychodni) AS przychodnia,
    sub.liczba_pacjentow,
    RANK() OVER (PARTITION BY sub.id_wojewodztwo ORDER BY sub.liczba_pacjentow DESC) AS miejsce
FROM (
    SELECT 
        w.id_wojewodztwo,
        prz.id_przychodni,
        COUNT(DISTINCT wz.id_pacjenta) AS liczba_pacjentow
    FROM wizyty wz
    JOIN przychodnie prz ON wz.id_przychodni = prz.id_przychodni
    JOIN miejscowosc m ON prz.id_miejscowosc = m.id_miejscowosc
    JOIN gmina g ON m.id_gmina = g.id_gmina
    JOIN powiat pow ON g.id_powiat = pow.id_powiat
    JOIN wojewodztwo w ON pow.id_wojewodztwo = w.id_wojewodztwo
    WHERE wz.status = 'zrealizowana'
    GROUP BY w.id_wojewodztwo, prz.id_przychodni
) sub
ORDER BY id_wojewodztwo, miejsce;
