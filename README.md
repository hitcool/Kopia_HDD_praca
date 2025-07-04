# 🗂️ Backup Scripts for Windows

Skrypty `.bat` służą do wykonywania lustrzanej kopii folderu pomiędzy lokalnym komputerem, dyskiem zewnętrznym oraz serwerem sieciowym. 
Skrypty korzystają z wbudowanego narzędzia `robocopy`

---

## 📦 Zawartość repozytorium


## ⚙️ Funkcje i właściwości

- ✅ Automatyczne wykrywanie dysku zewnętrznego po etykiecie (`Toshiba_2TB`)
- ✅ Lustrzane kopie danych z opcją `/MIR` (pełna synchronizacja)
- ✅ Obsługa logowania do plików `.log` z datą i godziną
- ✅ Tworzenie folderów docelowych, jeśli nie istnieją
- ✅ Zabezpieczenie przed uruchomieniem na **niewłaściwym komputerze** lub **koncie użytkownika**

---

## 🔧 Zabezpieczene przed niewłaścicym kopiowaniem
 
- **Użytkownik:** `OBAC`    set "EXPECTED_USERNAME=OBAC"
- **Komputer:** `L01R25`    set "EXPECTED_COMPUTERNAME=L01R25"
- **Zewnętrzny dysk:** Etykieta `Toshiba_2TB`    set "TARGET_LABEL=Toshiba_2TB"
- **Uprawnienia:** Dostęp do źródłowych i docelowych folderów

## 🔧🧰  === Konfiguracja folderów ===
set "SOURCE1=C:\Users\OBAC\Documents\MM"

set "DEST1=D:\ARCHIWUM\Work\Laborex\1.Laborex_backup_Dokuments_folder_MM\MM"

## 🔧🧰=== Sprawdzanie nazwy komputera i użytkownika ===
set "EXPECTED_COMPUTERNAME=L01R25"

set "EXPECTED_USERNAME=OBAC"

---


