LOAD DATA
CHARACTERSET AL32UTF8
INFILE 'CSV/pacjenci.csv'
BADFILE 'CTL/BAD/pacjenci.bad'
DISCARDFILE 'CTL/BAD/pacjenci.dsc'
INTO TABLE pacjenci
APPEND
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  id_pacjenta,
  imie,
  nazwisko,
  pesel,
  data_urodzenia DATE "YYYY-MM-DD",
  telefon,
  email,
  id_miejscowosc
)
