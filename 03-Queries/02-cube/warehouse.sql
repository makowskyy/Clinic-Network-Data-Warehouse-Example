
------CUBE-----------------------------------------------------------------------------------------------------------

-- Liczba wizyt dla każdego leku, lekarza i województwa
SELECT 
    NVL(TO_CHAR(sub.id_wojewodztwo), 'SUMA') AS id_wojewodztwo,
    NVL(dw.nazwa, 'SUMA') AS wojewodztwo,
    NVL(TO_CHAR(sub.id_lekarza), 'SUMA') AS id_lekarza,
    NVL(dl.nazwisko, 'SUMA') AS lekarz,
    NVL(TO_CHAR(sub.id_leku), 'SUMA') AS id_leku,
    NVL(dl2.nazwa, 'SUMA') AS lek,
    sub.liczba_wizyt
FROM (
    SELECT 
        fw.id_wojewodztwo,
        fw.id_lekarza,
        fw.id_leku,
        COUNT(fw.id_wizyty) AS liczba_wizyt
    FROM wizyty fw
    GROUP BY CUBE(fw.id_wojewodztwo, fw.id_lekarza, fw.id_leku)
) sub
LEFT JOIN wojewodztwo dw ON sub.id_wojewodztwo = dw.id_wojewodztwo
LEFT JOIN lekarze dl ON sub.id_lekarza = dl.id_lekarza
LEFT JOIN leki dl2 ON sub.id_leku = dl2.id_leku
ORDER BY sub.id_wojewodztwo, sub.id_lekarza, sub.id_leku;

-- Liczba wizyt dla każdego badania, specjalizacji i powiatu
SELECT 
    NVL(TO_CHAR(sub.id_powiat), 'SUMA') AS id_powiatu,
    NVL(dp.nazwa, 'SUMA') AS powiat,
    NVL(TO_CHAR(sub.id_specjalizacji), 'SUMA') AS id_specjalizacji,
    NVL(ds.nazwa_specjalizacji, 'SUMA') AS specjalizacja,
    NVL(TO_CHAR(sub.id_badania), 'SUMA') AS id_badania,
    NVL(db.nazwa, 'SUMA') AS nazwa_badania,
    sub.liczba_wizyt
FROM (
    SELECT 
        fw.id_powiat,
        fw.id_specjalizacji,
        fw.id_badania,
        COUNT(fw.id_wizyty) AS liczba_wizyt
    FROM wizyty fw
    GROUP BY CUBE(fw.id_powiat, fw.id_specjalizacji, fw.id_badania)
) sub
LEFT JOIN powiat dp ON sub.id_powiat = dp.id_powiat
LEFT JOIN specjalizacje ds ON sub.id_specjalizacji = ds.id_specjalizacji
LEFT JOIN badania db ON sub.id_badania = db.id_badania
ORDER BY sub.id_powiat, sub.id_specjalizacji, sub.id_badania;

-- Liczba wizyt dla każdej diagnozy, specjalizacji i gminy
SELECT 
    NVL(TO_CHAR(sub.id_gmina), 'SUMA') AS id_gmina,
    NVL(dg.nazwa, 'SUMA') AS gmina,
    NVL(TO_CHAR(sub.id_specjalizacji), 'SUMA') AS id_specjalizacji,
    NVL(ds.nazwa_specjalizacji, 'SUMA') AS specjalizacja,
    NVL(TO_CHAR(sub.id_diagnozy), 'SUMA') AS id_diagnozy,
    NVL(dd.nazwa, 'SUMA') AS nazwa_diagnozy,
    sub.liczba_wizyt
FROM (
    SELECT 
        fw.id_gmina,
        fw.id_specjalizacji,
        fw.id_diagnozy,
        COUNT(fw.id_wizyty) AS liczba_wizyt
    FROM wizyty fw
    GROUP BY CUBE(fw.id_gmina, fw.id_specjalizacji, fw.id_diagnozy)
) sub
LEFT JOIN gmina dg ON sub.id_gmina = dg.id_gmina
LEFT JOIN specjalizacje ds ON sub.id_specjalizacji = ds.id_specjalizacji
LEFT JOIN diagnozy dd ON sub.id_diagnozy = dd.id_diagnozy
ORDER BY sub.id_gmina, sub.id_specjalizacji, sub.id_diagnozy;
