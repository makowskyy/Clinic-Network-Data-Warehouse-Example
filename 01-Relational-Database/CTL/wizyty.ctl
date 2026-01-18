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
  data_wizyty DATE "YYYY-MM-DD HH24:MI:SS",
  status,
  id_recepty,
  id_przychodni,
  id_lekarza,
  id_diagnozy,
  id_badania
)
