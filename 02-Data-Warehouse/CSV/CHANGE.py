import pandas as pd

def wizyty_data():
    df = pd.read_csv("wizyty.csv", encoding="utf-8", header=0)
    df["data_wizyty"] = pd.to_datetime(df["data_wizyty"], errors="coerce")

    # Dodaj kolumny z datą
    df["id_dzien"] = df["data_wizyty"].dt.day
    df["id_miesiac"] = df["data_wizyty"].dt.month
    df["id_rok"] = df["data_wizyty"].dt.year

    df.drop(columns=["data_wizyty"], inplace=True)
    # Zapisz do nowego pliku
    df.to_csv("wizyty.csv", index=False, encoding="utf-8")
    print("Zapisano zmodyfikowany plik: wizyty.csv")

wizyty_data()

def wizyty_miejscowosc():
    wizyty = pd.read_csv("wizyty.csv", encoding="utf-8", header=0)
    przychodnie = pd.read_csv("przychodnie.csv", encoding="utf-8", header=0)

    wizyty.columns = ["id_wizyty","id_pacjenta","id_gabinetu","status","id_recepty","id_przychodni","id_lekarza","id_diagnozy","id_badania","id_dzien","id_miesiac","id_rok"]
    przychodnie.columns = ["id_przychodni","nazwa","adres","telefon","id_miejscowosc"]
    
    # Dołączenie ID_MIEJSCOWOSC do wizyty
    merged = wizyty.merge(przychodnie[["id_przychodni","id_miejscowosc"]], left_on="id_przychodni", right_on="id_przychodni", how="left")

    merged.to_csv("wizyty.csv", index=False, encoding="utf-8")
    print("Zapisano zmodyfikowany plik: wizyty.csv")

wizyty_miejscowosc()

def wizyty_gmina():
    wizyty = pd.read_csv("wizyty.csv", encoding="utf-8", header=0)
    miejscowosc = pd.read_csv("miejscowosc.csv", encoding="utf-8", header=0)

    wizyty.columns = ["id_wizyty","id_pacjenta","id_gabinetu","status","id_recepty","id_przychodni","id_lekarza","id_diagnozy","id_badania","id_dzien","id_miesiac","id_rok","id_miejscowosc"]
    miejscowosc.columns = ["id_miejscowosc", "nazwa", "id_gmina"]
    
    merged = wizyty.merge(miejscowosc[["id_miejscowosc","id_gmina"]], left_on="id_miejscowosc", right_on="id_miejscowosc", how="left")
    
    merged.to_csv("wizyty.csv", index=False, encoding="utf-8")
    print("Zapisano zmodyfikowany plik: wizyty.csv")
    
wizyty_gmina()
    
def wizyty_powiat():
    wizyty = pd.read_csv("wizyty.csv", encoding="utf-8", header=0)
    gmina = pd.read_csv("gmina.csv", encoding="utf-8", header=0)
    
    wizyty.columns = ["id_wizyty","id_pacjenta","id_gabinetu","status","id_recepty","id_przychodni","id_lekarza","id_diagnozy","id_badania","id_dzien","id_miesiac","id_rok","id_miejscowosc","id_gmina"]
    gmina.columns = ["id_gmina", "nazwa", "id_powiat"]
    
    merged = wizyty.merge(gmina[["id_gmina","id_powiat"]], left_on="id_gmina", right_on="id_gmina", how="left")
    
    merged.to_csv("wizyty.csv", index=False, encoding="utf-8")
    print("Zapisano zmodyfikowany plik: wizyty.csv")
    
wizyty_powiat()
    
def wizyty_wojewodztwo():
    wizyty = pd.read_csv("wizyty.csv", encoding="utf-8", header=0)
    powiat = pd.read_csv("powiat.csv", encoding="utf-8", header=0)
    
    wizyty.columns = ["id_wizyty","id_pacjenta","id_gabinetu","status","id_recepty","id_przychodni","id_lekarza","id_diagnozy","id_badania","id_dzien","id_miesiac","id_rok","id_miejscowosc","id_gmina","id_powiat"]
    powiat.columns = ["id_powiat", "nazwa", "id_wojewodztwo"]

    merged = wizyty.merge(powiat[["id_powiat","id_wojewodztwo"]], left_on="id_powiat", right_on="id_powiat", how="left")
    
    merged.to_csv("wizyty.csv", index=False, encoding="utf-8")
    print("Zapisano zmodyfikowany plik: wizyty.csv")

wizyty_wojewodztwo()

def wizyty_status():
    wizyty = pd.read_csv("wizyty.csv", encoding="utf-8", header=0)
    status = pd.read_csv("status.csv", encoding="utf-8", header=0)

    wizyty.columns = ["id_wizyty","id_pacjenta","id_gabinetu","status","id_recepty","id_przychodni","id_lekarza","id_diagnozy","id_badania","id_dzien","id_miesiac","id_rok","id_miejscowosc","id_gmina","id_powiat","id_wojewodztwo"]
    status.columns = ["id_status", "nazwa"]

    merged = wizyty.merge(status, left_on="status", right_on="nazwa", how="left")
    
    # Usuń oryginalne kolumny tekstowe, zachowaj ID_STATUS
    merged = merged.drop(columns=["status", "nazwa"])

    # Zmień nazwę kolumny ID_STATUS na odpowiednią pozycję
    merged = merged.rename(columns={"id_status": "id_status"})
    merged.to_csv("wizyty.csv", index=False, encoding="utf-8")
    print("Zapisano zmodyfikowany plik: wizyty.csv")

wizyty_status()

def wizyty_specjalizacje():
    wizyty = pd.read_csv("wizyty.csv", encoding="utf-8", header=0)
    lekarze = pd.read_csv("lekarze.csv", encoding="utf-8", header=0)

    wizyty.columns = ["id_wizyty","id_pacjenta","id_gabinetu","id_recepty","id_przychodni","id_lekarza","id_diagnozy","id_badania","id_dzien","id_miesiac","id_rok","id_miejscowosc","id_gmina","id_powiat","id_wojewodztwo","id_status"]
    lekarze.columns = ["id_lekarza","imie","nazwisko","nr_licencji","id_specjalizacji"]

    merged = wizyty.merge(lekarze[["id_lekarza", "id_specjalizacji"]], left_on="id_lekarza", right_on="id_lekarza", how="left")
    
    merged.to_csv("wizyty.csv", index=False, encoding="utf-8")
    print("Zapisano zmodyfikowany plik: wizyty.csv")

wizyty_specjalizacje()

def wizyty_lek():
    wizyty = pd.read_csv("wizyty.csv", encoding="utf-8", header=0)
    recepty = pd.read_csv("recepty.csv", encoding="utf-8", header=0)

    wizyty.columns = ["id_wizyty","id_pacjenta","id_gabinetu","id_recepty","id_przychodni","id_lekarza","id_diagnozy","id_badania","id_dzien","id_miesiac","id_rok","id_miejscowosc","id_gmina","id_powiat","id_wojewodztwo","id_status","id_specjalizaji"]
    recepty.columns = ["id_recepty","data_wystawienia","zalecenia","id_leku"]

    merged = wizyty.merge(recepty[["id_recepty", "id_leku"]], left_on="id_recepty", right_on="id_recepty", how="left")
    
    merged.to_csv("wizyty.csv", index=False, encoding="utf-8")
    print("Zapisano zmodyfikowany plik: wizyty.csv")

wizyty_lek()

def kasuj():
    recepty = pd.read_csv("recepty.csv", encoding="utf-8", header=0)
    lekarze = pd.read_csv("lekarze.csv", encoding="utf-8", header=0)
    powiat = pd.read_csv("powiat.csv", encoding="utf-8", header=0)
    gmina = pd.read_csv("gmina.csv", encoding="utf-8", header=0)
    miejscowosc = pd.read_csv("miejscowosc.csv", encoding="utf-8", header=0)
    przychodnie = pd.read_csv("przychodnie.csv", encoding="utf-8", header=0)
    pacjenci = pd.read_csv("pacjenci.csv", encoding="utf-8", header=0)
    specjalizacje = pd.read_csv("specjalizacje.csv", encoding="utf-8", header=0)
    badania = pd.read_csv("badania.csv", encoding="utf-8", header=0)
    leki = pd.read_csv("leki.csv", encoding="utf-8", header=0)
    diagnozy = pd.read_csv("diagnozy.csv", encoding="utf-8", header=0)
    
    recepty.columns = ["id_recepty","data_wystawienia","zalecenia","id_leku"]
    lekarze.columns = ["id_lekarza","imie","nazwisko","nr_licencji","id_specjalizacji"]
    powiat.columns = ["id_powiat", "nazwa", "id_wojewodztwo"]
    gmina.columns = ["id_gmina", "nazwa", "id_powiat"]
    miejscowosc.columns = ["id_miejscowosc", "nazwa", "id_gmina"]
    przychodnie.columns = ["id_przychodni","nazwa","adres","telefon","id_miejscowosc"]
    pacjenci.columns = ["id_pacjenta","imie","nazwisko","pesel","data_urodzenia","telefon","email","id_miejscowosc"]
    specjalizacje.columns = ["id_specjalizacji","nazwa_specjalizacji","opis"]
    badania.columns = ["id_badania","nazwa","opis"]
    leki.columns = ["id_leku","nazwa","dawkowanie","opis"]
    diagnozy.columns = ["id_diagnozy","nazwa","opis"]
    
    recepty = recepty.drop(columns=["data_wystawienia","id_leku"])
    lekarze = lekarze.drop(columns=["nr_licencji","id_specjalizacji"])
    powiat = powiat.drop(columns=["id_wojewodztwo"])
    gmina = gmina.drop(columns=["id_powiat"])
    miejscowosc = miejscowosc.drop(columns=["id_gmina"])
    przychodnie = przychodnie.drop(columns=["adres","telefon","id_miejscowosc"])
    pacjenci = pacjenci.drop(columns=["pesel","data_urodzenia","telefon","email","id_miejscowosc"])
    specjalizacje = specjalizacje.drop(columns=["opis"])
    badania = badania.drop(columns=["opis"])
    leki = leki.drop(columns=["dawkowanie","opis"])
    diagnozy = diagnozy.drop(columns=["opis"])
    
    recepty.to_csv("recepty.csv", index=False, encoding="utf-8")
    print("Zapisano zmodyfikowany plik: recepty.csv") 
    lekarze.to_csv("lekarze.csv", index=False, encoding="utf-8")
    print("Zapisano zmodyfikowany plik: lekarze.csv")
    powiat.to_csv("powiat.csv", index=False, encoding="utf-8")
    print("Zapisano zmodyfikowany plik: powiat.csv") 
    gmina.to_csv("gmina.csv", index=False, encoding="utf-8")
    print("Zapisano zmodyfikowany plik: gmina.csv") 
    miejscowosc.to_csv("miejscowosc.csv", index=False, encoding="utf-8")
    print("Zapisano zmodyfikowany plik: miejscowosc.csv") 
    przychodnie.to_csv("przychodnie.csv", index=False, encoding="utf-8")
    print("Zapisano zmodyfikowany plik: przychodnie.csv") 
    pacjenci.to_csv("pacjenci.csv", index=False, encoding="utf-8")
    print("Zapisano zmodyfikowany plik: pacjenci.csv") 
    specjalizacje.to_csv("specjalizacje.csv", index=False, encoding="utf-8")
    print("Zapisano zmodyfikowany plik: specjalizacje.csv") 
    badania.to_csv("badania.csv", index=False, encoding="utf-8")
    print("Zapisano zmodyfikowany plik: badania.csv") 
    leki.to_csv("leki.csv", index=False, encoding="utf-8")
    print("Zapisano zmodyfikowany plik: leki.csv") 
    diagnozy.to_csv("diagnozy.csv", index=False, encoding="utf-8")
    print("Zapisano zmodyfikowany plik: diagnozy.csv") 
    

kasuj()
