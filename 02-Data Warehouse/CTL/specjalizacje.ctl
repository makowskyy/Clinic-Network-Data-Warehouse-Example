LOAD DATA
CHARACTERSET AL32UTF8
INFILE 'CSV/specjalizacje.csv'
BADFILE 'CTL/BAD/specjalizacje.bad'
DISCARDFILE 'CTL/BAD/specjalizacje.dsc'
INTO TABLE specjalizacje
APPEND
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id_specjalizacji,
  nazwa_specjalizacji
)
