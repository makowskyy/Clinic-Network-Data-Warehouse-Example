@echo off
echo Usuwanie plików .log i .bad...

del /q CTL\LOG\wojewodztwo.log
del /q CTL\BAD\wojewodztwo.bad

del /q CTL\LOG\powiat.log
del /q CTL\BAD\powiat.bad

del /q CTL\LOG\gmina.log
del /q CTL\BAD\gmina.bad

del /q CTL\LOG\miejscowosc.log
del /q CTL\BAD\miejscowosc.bad

del /q CTL\LOG\pacjenci.log
del /q CTL\BAD\pacjenci.bad

del /q CTL\LOG\leki.log
del /q CTL\BAD\leki.bad

del /q CTL\LOG\recepty.log
del /q CTL\BAD\recepty.bad

del /q CTL\LOG\diagnozy.log
del /q CTL\BAD\diagnozy.bad

del /q CTL\LOG\gabinet.log
del /q CTL\BAD\gabinet.bad

del /q CTL\LOG\badania.log
del /q CTL\BAD\badania.bad

del /q CTL\LOG\dzien.log
del /q CTL\BAD\dzien.bad

del /q CTL\LOG\miesiac.log
del /q CTL\BAD\miesiac.bad

del /q CTL\LOG\rok.log
del /q CTL\BAD\rok.bad

del /q CTL\LOG\status.log
del /q CTL\BAD\status.bad

del /q CTL\LOG\specjalizacje.log
del /q CTL\BAD\specjalizacje.bad

del /q CTL\LOG\lekarze.log
del /q CTL\BAD\lekarze.bad

del /q CTL\LOG\przychodnie.log
del /q CTL\BAD\przychodnie.bad

del /q CTL\LOG\wizyty.log
del /q CTL\BAD\wizyty.bad

echo Gotowe!
pause
