LOAD DATA
CHARACTERSET AL32UTF8
INFILE 'CSV/wizyty.csv'
BADFILE 'CTL/BAD/wizyty.bad'
DISCARDFILE 'CTL/BAD/wizyty.dsc'
INTO TABLE wizyty
APPEND
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id_wizyty,
  id_pacjenta,
  id_gabinetu,
  id_recepty,
  id_przychodni,
  id_lekarza,
  id_diagnozy,
  id_badania,
  id_dzien,
  id_miesiac,
  id_rok,
  id_miejscowosc,
  id_gmina,
  id_powiat,
  id_wojewodztwo,
  id_status,
  id_specjalizacji,
  id_leku
)
