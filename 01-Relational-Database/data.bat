@echo off

set ORA_USER=test
set ORA_PASS=test
set ORA_HOST=localhost
set ORA_PORT=1521
set ORA_SERVICE=XE

set CONNECT_STRING=%ORA_USER%/%ORA_PASS%@%ORA_HOST%:%ORA_PORT%/%ORA_SERVICE%

sqlldr %CONNECT_STRING% control=CTL\wojewodztwo.ctl skip=1 log=CTL\LOG\wojewodztwo.log bad=CTL\BAD\wojewodztwo.bad
sqlldr %CONNECT_STRING% control=CTL\powiat.ctl skip=1 log=CTL\LOG\powiat.log bad=CTL\BAD\powiat.bad
sqlldr %CONNECT_STRING% control=CTL\gmina.ctl skip=1 log=CTL\LOG\gmina.log bad=CTL\BAD\gmina.bad
sqlldr %CONNECT_STRING% control=CTL\miejscowosc.ctl skip=1 log=CTL\LOG\miejscowosc.log bad=CTL\BAD\miejscowosc.bad
sqlldr %CONNECT_STRING% control=CTL\pacjenci.ctl skip=1 log=CTL\LOG\pacjenci.log bad=CTL\BAD\pacjenci.bad
sqlldr %CONNECT_STRING% control=CTL\leki.ctl skip=1 log=CTL\LOG\leki.log bad=CTL\BAD\leki.bad
sqlldr %CONNECT_STRING% control=CTL\recepty.ctl skip=1 log=CTL\LOG\recepty.log bad=CTL\BAD\recepty.bad
sqlldr %CONNECT_STRING% control=CTL\diagnozy.ctl skip=1 log=CTL\LOG\diagnozy.log bad=CTL\BAD\diagnozy.bad
sqlldr %CONNECT_STRING% control=CTL\gabinet.ctl skip=1 log=CTL\LOG\gabinet.log bad=CTL\BAD\gabinet.bad
sqlldr %CONNECT_STRING% control=CTL\badania.ctl skip=1 log=CTL\LOG\badania.log bad=CTL\BAD\badania.bad
sqlldr %CONNECT_STRING% control=CTL\specjalizacje.ctl skip=1 log=CTL\LOG\specjalizacje.log bad=CTL\BAD\specjalizacje.bad
sqlldr %CONNECT_STRING% control=CTL\lekarze.ctl skip=1 log=CTL\LOG\lekarze.log bad=CTL\BAD\lekarze.bad
sqlldr %CONNECT_STRING% control=CTL\przychodnie.ctl skip=1 log=CTL\LOG\przychodnie.log bad=CTL\BAD\przychodnie.bad
sqlldr %CONNECT_STRING% control=CTL\lekarze_przychodnie.ctl skip=1 log=CTL\LOG\lekarze_przychodnie.log bad=CTL\BAD\lekarze_przychodnie.bad
sqlldr %CONNECT_STRING% control=CTL\wizyty.ctl skip=1 log=CTL\LOG\wizyty.log bad=CTL\BAD\wizyty.bad

pause
