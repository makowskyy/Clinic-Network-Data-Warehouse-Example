
------ROLLUP----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Liczba wizyt dla każdego leku, lekarza i województwa
SELECT 
    NVL(TO_CHAR(w.id_wojewodztwo), 'SUMA') AS id_wojewodztwo,
    NVL((SELECT nazwa FROM wojewodztwo w2 WHERE w2.id_wojewodztwo = w.id_wojewodztwo), 'SUMA') AS wojewodztwo,
    NVL(TO_CHAR(l.id_lekarza), 'SUMA') AS id_lekarza,
    NVL((SELECT nazwisko FROM lekarze l2 WHERE l2.id_lekarza = l.id_lekarza), 'SUMA') AS lekarz,
    NVL(TO_CHAR(r.id_leku), 'SUMA') AS id_leku,
    NVL((SELECT nazwa FROM leki lek WHERE lek.id_leku = r.id_leku), 'SUMA') AS lek,
    COUNT(wz.id_wizyty) AS liczba_recept
FROM wizyty wz
JOIN recepty r ON r.id_recepty = wz.id_recepty
JOIN przychodnie p ON wz.id_przychodni = p.id_przychodni
JOIN miejscowosc m ON p.id_miejscowosc = m.id_miejscowosc
JOIN gmina g ON m.id_gmina = g.id_gmina
JOIN powiat pow ON g.id_powiat = pow.id_powiat
JOIN wojewodztwo w ON pow.id_wojewodztwo = w.id_wojewodztwo
JOIN lekarze l ON wz.id_lekarza = l.id_lekarza
GROUP BY ROLLUP(w.id_wojewodztwo, l.id_lekarza, r.id_leku)
ORDER BY w.id_wojewodztwo, l.id_lekarza, r.id_leku;

-- Liczba wizyt dla każdego badania, specjalizacji i powiatu
SELECT 
    NVL(TO_CHAR(pow.id_powiat), 'SUMA') AS id_powiatu,
    NVL((SELECT pow2.nazwa FROM powiat pow2 WHERE pow2.id_powiat = pow.id_powiat), 'SUMA') AS powiat,
    NVL(TO_CHAR(s.id_specjalizacji), 'SUMA') AS id_specjalizacji,
    NVL((SELECT s2.nazwa_specjalizacji FROM specjalizacje s2 WHERE s2.id_specjalizacji = s.id_specjalizacji), 'SUMA') AS specjalizacja,
    NVL(TO_CHAR(b.id_badania), 'SUMA') AS id_badania,
    NVL((SELECT b2.nazwa FROM badania b2 WHERE b2.id_badania = b.id_badania), 'SUMA') AS nazwa_badania,
    COUNT(wz.id_wizyty) AS liczba_zlecen
FROM wizyty wz
JOIN przychodnie p ON wz.id_przychodni = p.id_przychodni
JOIN miejscowosc m ON p.id_miejscowosc = m.id_miejscowosc
JOIN gmina g ON m.id_gmina = g.id_gmina
JOIN powiat pow ON g.id_powiat = pow.id_powiat
JOIN wojewodztwo w ON pow.id_wojewodztwo = w.id_wojewodztwo
JOIN lekarze l ON wz.id_lekarza = l.id_lekarza
JOIN specjalizacje s ON l.id_specjalizacji = s.id_specjalizacji
JOIN badania b ON wz.id_badania = b.id_badania
GROUP BY ROLLUP(pow.id_powiat, s.id_specjalizacji, b.id_badania)
ORDER BY pow.id_powiat, s.id_specjalizacji, b.id_badania;

-- Liczba wizyt dla każdej diagnozy, specjalizacji i gminy
SELECT 
    NVL(TO_CHAR(g.id_gmina), 'SUMA') AS id_gminy,
    NVL((SELECT g2.nazwa FROM gmina g2 WHERE g2.id_gmina = g.id_gmina), 'SUMA') AS gmina,
    NVL(TO_CHAR(s.id_specjalizacji), 'SUMA') AS id_specjalizacji,
    NVL((SELECT s2.nazwa_specjalizacji FROM specjalizacje s2 WHERE s2.id_specjalizacji = s.id_specjalizacji), 'SUMA') AS specjalizacja,
    NVL(TO_CHAR(d.id_diagnozy), 'SUMA') AS id_diagnozy,
    NVL((SELECT d2.nazwa FROM diagnozy d2 WHERE d2.id_diagnozy = d.id_diagnozy), 'SUMA') AS nazwa_diagnozy,
    COUNT(wz.id_wizyty) AS liczba_zlecen
FROM wizyty wz
JOIN przychodnie p ON wz.id_przychodni = p.id_przychodni
JOIN miejscowosc m ON p.id_miejscowosc = m.id_miejscowosc
JOIN gmina g ON m.id_gmina = g.id_gmina
JOIN lekarze l ON wz.id_lekarza = l.id_lekarza
JOIN specjalizacje s ON l.id_specjalizacji = s.id_specjalizacji
JOIN diagnozy d ON wz.id_diagnozy = d.id_diagnozy
GROUP BY ROLLUP(g.id_gmina, s.id_specjalizacji, d.id_diagnozy)
ORDER BY g.id_gmina, s.id_specjalizacji, d.id_diagnozy;
