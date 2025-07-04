# 🗂️ Backup Scripts for Windows

Zestaw czterech wsadowych skryptów `.bat` służących do wykonywania kopii zapasowych pomiędzy lokalnym komputerem, dyskiem zewnętrznym oraz serwerem sieciowym. Skrypty korzystają z wbudowanego narzędzia `robocopy`, oferując niezawodne i szybkie kopiowanie danych z możliwością tworzenia logów.

---

## 📦 Zawartość repozytorium

| Nazwa skryptu                                            | Opis                                                                                   |
|----------------------------------------------------------|----------------------------------------------------------------------------------------|
| `Kopia_z_C_dokumenty_MM_na_HDD.bat`                      | Tworzy lustrzaną kopię folderu `MM` z dysku C:\ na zewnętrzny HDD (np. Toshiba_2TB).  |
| `Kopia_z_C_dokumenty_TEMP - tru_na_HDD.bat`              | Backup danych tymczasowych z `TEMP` na dysk zewnętrzny.                               |
| `Kopia_z_sewera_do_C_MM_z_serwera.bat`                   | Kopiuje folder `MM` z serwera do lokalnego dysku C:\.                                 |
| `Kopia_z_sewera_na_HDD_Toschiba.bat`                     | Kopiuje dane z serwera bezpośrednio na zewnętrzny dysk Toshiba.                       |

---

## ⚙️ Funkcje i właściwości

- ✅ Automatyczne wykrywanie dysku zewnętrznego po etykiecie (`Toshiba_2TB`)
- ✅ Lustrzane kopie danych z opcją `/MIR` (pełna synchronizacja)
- ✅ Obsługa logowania do plików `.log` z datą i godziną
- ✅ Tworzenie folderów docelowych, jeśli nie istnieją
- ✅ Zabezpieczenie przed uruchomieniem na niewłaściwym komputerze lub koncie użytkownika

---

## 🔧 Wymagania 

- **System:** Windows 10 lub nowszy  
- **Użytkownik:** `OBAC`  
- **Komputer:** `L01R25`  
- **Zewnętrzny dysk:** Etykieta `Toshiba_2TB`  
- **Uprawnienia:** Dostęp do źródłowych i docelowych folderów

## 🔧🧰  === Konfiguracja folderów ===
set "SOURCE1=C:\Users\OBAC\Documents\MM"
set "DEST1=D:\ARCHIWUM\Work\Laborex\1.Laborex_backup_Dokuments_folder_MM\MM"

## 🔧🧰=== Sprawdzanie nazwy komputera i użytkownika ===
set "EXPECTED_COMPUTERNAME=L01R25"
set "EXPECTED_USERNAME=OBAC"

---

## 🧪 Przykład działania

Uruchomienie skryptu `Kopia_z_C_dokumenty_MM_na_HDD.bat`:

:: === Lustrzane odbicie (mirror) ===
echo === [1/2] Mirror: %SOURCE1% -> %DEST1%
:: ------------------------------------------------------------------------------------------------------------------
robocopy "%SOURCE1%" "%DEST1%" /MIR /DCOPY:T /COPY:DAT /MT:4 /R:2 /W:3 /NP /LOG:"%~dp0%LOGDATE%-Kopia_2TB_z_C_dokumenty_MM_na_HDD.log" /TEE
:: ------------------------------------------------------------------------------------------------------------------
echo === [1/2] Zakończono
echo.



