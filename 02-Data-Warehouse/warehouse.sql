
CREATE TABLE dzien (
    id_dzien NUMBER(6) NOT NULL,
    dzien    NUMBER(6)
);

CREATE UNIQUE INDEX dzien_pk ON
    dzien (
        id_dzien
    ASC );

ALTER TABLE dzien ADD CONSTRAINT dzien_pk PRIMARY KEY ( id_dzien );

CREATE TABLE miesiac (
    id_miesiac NUMBER(6) NOT NULL,
    miesiac    VARCHAR2(100 BYTE)
);

CREATE UNIQUE INDEX miesiac_pk ON
    miesiac (
        id_miesiac
    ASC );

ALTER TABLE miesiac ADD CONSTRAINT miesiac_pk PRIMARY KEY ( id_miesiac );

CREATE TABLE rok (
    id_rok NUMBER(6) NOT NULL,
    rok    NUMBER(6)
);

CREATE UNIQUE INDEX rok_pk ON
    rok (
        id_rok
    ASC );

ALTER TABLE rok ADD CONSTRAINT rok_pk PRIMARY KEY ( id_rok );

CREATE TABLE status (
    id_status NUMBER(6) NOT NULL,
    status    VARCHAR2(100 BYTE)
);

CREATE UNIQUE INDEX status_pk ON
    status (
        id_status
    ASC );

ALTER TABLE status ADD CONSTRAINT status_pk PRIMARY KEY ( id_status );

CREATE TABLE badania (
    id_badania NUMBER(6) NOT NULL,
    nazwa      VARCHAR2(100 BYTE)
);

CREATE UNIQUE INDEX badania_pk ON
    badania (
        id_badania
    ASC );

ALTER TABLE badania ADD CONSTRAINT badania_pk PRIMARY KEY ( id_badania );

CREATE TABLE diagnozy (
    id_diagnozy NUMBER(6) NOT NULL,
    nazwa       VARCHAR2(100 BYTE)
);

CREATE UNIQUE INDEX diagnozy_pk ON
    diagnozy (
        id_diagnozy
    ASC );

ALTER TABLE diagnozy ADD CONSTRAINT diagnozy_pk PRIMARY KEY ( id_diagnozy );

CREATE TABLE gabinet (
    id_gabinetu    NUMBER(6) NOT NULL,
    numer_gabinetu VARCHAR2(10 BYTE)
);

CREATE UNIQUE INDEX gabinet_pk ON
    gabinet (
        id_gabinetu
    ASC );

ALTER TABLE gabinet ADD CONSTRAINT gabinet_pk PRIMARY KEY ( id_gabinetu );

CREATE TABLE gmina (
    id_gmina  NUMBER(6) NOT NULL,
    nazwa     VARCHAR2(50 BYTE)
);

CREATE UNIQUE INDEX gmina_pk ON
    gmina (
        id_gmina
    ASC );

ALTER TABLE gmina ADD CONSTRAINT gmina_pk PRIMARY KEY ( id_gmina );

CREATE TABLE lekarze (
    id_lekarza       NUMBER(6) NOT NULL,
    imie             VARCHAR2(50 BYTE),
    nazwisko         VARCHAR2(50 BYTE)
);

CREATE UNIQUE INDEX lekarze_nr_licencji_un ON
    lekarze (
        nr_licencji
    ASC );

CREATE UNIQUE INDEX lekarze_pk ON
    lekarze (
        id_lekarza
    ASC );

ALTER TABLE lekarze ADD CONSTRAINT lekarze_pk PRIMARY KEY ( id_lekarza );

ALTER TABLE lekarze ADD CONSTRAINT lekarze_nr_licencji_un UNIQUE ( nr_licencji );

CREATE TABLE leki (
    id_leku    NUMBER(6) NOT NULL,
    nazwa      VARCHAR2(100 BYTE)
);

CREATE UNIQUE INDEX leki_pk ON
    leki (
        id_leku
    ASC );

ALTER TABLE leki ADD CONSTRAINT leki_pk PRIMARY KEY ( id_leku );

CREATE TABLE miejscowosc (
    id_miejscowosc NUMBER(6) NOT NULL,
    nazwa          VARCHAR2(50 BYTE) NOT NULL
);

CREATE UNIQUE INDEX miejscowosc_pk ON
    miejscowosc (
        id_miejscowosc
    ASC );

ALTER TABLE miejscowosc ADD CONSTRAINT miejscowosc_pk PRIMARY KEY ( id_miejscowosc );

CREATE TABLE pacjenci (
    id_pacjenta    NUMBER(6) NOT NULL,
    imie           VARCHAR2(50 BYTE),
    nazwisko       VARCHAR2(50 BYTE)
);

ALTER TABLE pacjenci ADD CHECK ( length(imie) > 1 );

ALTER TABLE pacjenci ADD CHECK ( length(nazwisko) > 1 );

CREATE UNIQUE INDEX pacjenci_pesel_un ON
    pacjenci (
        pesel
    ASC );

CREATE UNIQUE INDEX pacjenci_pk ON
    pacjenci (
        id_pacjenta
    ASC );

ALTER TABLE pacjenci ADD CONSTRAINT pacjenci_pk PRIMARY KEY ( id_pacjenta );

ALTER TABLE pacjenci ADD CONSTRAINT pacjenci_pesel_un UNIQUE ( pesel );

CREATE TABLE powiat (
    id_powiat      NUMBER(6) NOT NULL,
    nazwa          VARCHAR2(50 BYTE)
);

CREATE UNIQUE INDEX powiat_pk ON
    powiat (
        id_powiat
    ASC );

ALTER TABLE powiat ADD CONSTRAINT powiat_pk PRIMARY KEY ( id_powiat );

CREATE TABLE przychodnie (
    id_przychodni              NUMBER(6) NOT NULL,
    nazwa                      VARCHAR2(100 BYTE)
);

CREATE UNIQUE INDEX przychodnie_pk ON
    przychodnie (
        id_przychodni
    ASC );

ALTER TABLE przychodnie ADD CONSTRAINT przychodnie_pk PRIMARY KEY ( id_przychodni );

CREATE TABLE recepty (
    id_recepty       NUMBER(6) NOT NULL,
    zalecenia        CLOB
);

CREATE UNIQUE INDEX recepty_pk ON
    recepty (
        id_recepty
    ASC );

ALTER TABLE recepty ADD CONSTRAINT recepty_pk PRIMARY KEY ( id_recepty );

CREATE TABLE specjalizacje (
    id_specjalizacji    NUMBER(6) NOT NULL,
    nazwa_specjalizacji VARCHAR2(100 BYTE)
);

CREATE UNIQUE INDEX specjalizacje_pk ON
    specjalizacje (
        id_specjalizacji
    ASC );

ALTER TABLE specjalizacje ADD CONSTRAINT specjalizacje_pk PRIMARY KEY ( id_specjalizacji );

CREATE TABLE wizyty (
    id_wizyty      NUMBER(6) NOT NULL,
    id_pacjenta    NUMBER(6) NOT NULL,
    id_gabinetu    NUMBER(6) NOT NULL,
    id_dzien       NUMBER(6) NOT NULL,
    id_miesiac     NUMBER(6) NOT NULL,
    id_rok         NUMBER(6) NOT NULL,
    id_status      NUMBER(6) NOT NULL,
    id_recepty     NUMBER(6) NOT NULL,
    id_leku        NUMBER(6) NOT NULL,
    id_przychodni  NUMBER(6) NOT NULL,
    id_lekarza     NUMBER(6) NOT NULL,
    id_specjalizacji     NUMBER(6) NOT NULL,
    id_diagnozy    NUMBER(6) NOT NULL,
    id_badania     NUMBER(6) NOT NULL,
    id_miejscowosc NUMBER(6) NOT NULL,
    id_gmina       NUMBER(6) NOT NULL,
    id_powiat      NUMBER(6) NOT NULL,
    id_wojewodztwo NUMBER(6) NOT NULL
);

CREATE UNIQUE INDEX wizyty_pk ON
    wizyty (
        id_wizyty
    ASC );

ALTER TABLE wizyty ADD CONSTRAINT wizyty_pk PRIMARY KEY ( id_wizyty );

CREATE TABLE wojewodztwo (
    id_wojewodztwo NUMBER(6) NOT NULL,
    nazwa          VARCHAR2(50 BYTE)
);

CREATE UNIQUE INDEX wojewodztwo_pk ON
    wojewodztwo (
        id_wojewodztwo
    ASC );

ALTER TABLE wojewodztwo ADD CONSTRAINT wojewodztwo_pk PRIMARY KEY ( id_wojewodztwo );

ALTER TABLE wizyty
    ADD CONSTRAINT wizyty_badania_fk
        FOREIGN KEY ( id_badania )
            REFERENCES badania ( id_badania );

ALTER TABLE wizyty
    ADD CONSTRAINT wizyty_diagnozy_fk
        FOREIGN KEY ( id_diagnozy )
            REFERENCES diagnozy ( id_diagnozy );

ALTER TABLE wizyty
    ADD CONSTRAINT wizyty_gabinet_fk
        FOREIGN KEY ( id_gabinetu )
            REFERENCES gabinet ( id_gabinetu );

ALTER TABLE wizyty
    ADD CONSTRAINT wizyty_pacjenci_fk
        FOREIGN KEY ( id_pacjenta )
            REFERENCES pacjenci ( id_pacjenta );

ALTER TABLE wizyty
    ADD CONSTRAINT wizyty_recepty_fk
        FOREIGN KEY ( id_recepty )
            REFERENCES recepty ( id_recepty );

ALTER TABLE wizyty
    ADD CONSTRAINT wizyty_specjalizacja_fk
        FOREIGN KEY ( id_specjalizacji )
            REFERENCES specjalizacje ( id_specjalizacji );

ALTER TABLE wizyty
    ADD CONSTRAINT wizyty_leki_fk
        FOREIGN KEY ( id_leku )
            REFERENCES leki ( id_leku );

ALTER TABLE wizyty
    ADD CONSTRAINT wizyty_lekarze_fk
        FOREIGN KEY ( id_lekarza )
            REFERENCES lekarze ( id_lekarza );

ALTER TABLE wizyty
    ADD CONSTRAINT wizyty_przychodnia_fk
        FOREIGN KEY ( id_przychodni )
            REFERENCES przychodnie ( id_przychodni );

ALTER TABLE wizyty
    ADD CONSTRAINT wizyty_miejscowosc_fk
        FOREIGN KEY ( id_miejscowosc )
            REFERENCES miejscowosc ( id_miejscowosc );

ALTER TABLE wizyty
    ADD CONSTRAINT wizyty_gmina_fk
        FOREIGN KEY ( id_gmina )
            REFERENCES gmina ( id_gmina );

ALTER TABLE wizyty
    ADD CONSTRAINT wizyty_powiat_fk
        FOREIGN KEY ( id_powiat )
            REFERENCES powiat ( id_powiat );

ALTER TABLE wizyty
    ADD CONSTRAINT wizyty_wojewodztwo_fk
        FOREIGN KEY ( id_wojewodztwo )
            REFERENCES wojewodztwo ( id_wojewodztwo );

ALTER TABLE wizyty
    ADD CONSTRAINT wizyty_dzien_fk
        FOREIGN KEY ( id_dzien )
            REFERENCES dzien ( id_dzien );

ALTER TABLE wizyty
    ADD CONSTRAINT wizyty_miesiac_fk
        FOREIGN KEY ( id_miesiac )
            REFERENCES miesiac ( id_miesiac );

ALTER TABLE wizyty
    ADD CONSTRAINT wizyty_rok_fk
        FOREIGN KEY ( id_rok )
            REFERENCES rok ( id_rok );

ALTER TABLE wizyty
    ADD CONSTRAINT wizyty_status_fk
        FOREIGN KEY ( id_status )
            REFERENCES status ( id_status );

EXIT;