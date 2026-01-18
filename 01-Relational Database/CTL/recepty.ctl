LOAD DATA
CHARACTERSET AL32UTF8
INFILE 'CSV/recepty.csv'
BADFILE 'CTL/BAD/recepty.bad'
DISCARDFILE 'CTL/BAD/recepty.dsc'
INTO TABLE recepty
APPEND
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id_recepty,
  data_wystawienia DATE "YYYY-MM-DD",
  zalecenia,
  id_leku
)
