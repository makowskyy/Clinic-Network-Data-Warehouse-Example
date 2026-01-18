LOAD DATA
CHARACTERSET AL32UTF8
INFILE 'CSV/lekarze_przychodnie.csv'
BADFILE 'CTL/BAD/lekarze_przychodnie.bad'
DISCARDFILE 'CTL/BAD/lekarze_przychodnie.dsc'
INTO TABLE lekarze_przychodnie
APPEND
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id_lekarza,
  id_przychodni
)
