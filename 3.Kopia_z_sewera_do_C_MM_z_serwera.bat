@echo off
chcp 65001 >nul
setlocal
:: -------------------------------------------------------------------------------------------
:: === Sprawdzanie nazwy komputera i użytkownika ===
set "EXPECTED_COMPUTERNAME=L01R25"
set "EXPECTED_USERNAME=OBAC"

if /I not "%COMPUTERNAME%"=="%EXPECTED_COMPUTERNAME%" (
    echo ERROR: Ten skrypt może być uruchomiony tylko na komputerze: %EXPECTED_COMPUTERNAME%
    echo Aktualna nazwa komputera: %COMPUTERNAME%
    pause
    exit /b 1
)

if /I not "%USERNAME%"=="%EXPECTED_USERNAME%" (
    echo ERROR: Ten skrypt może być uruchomiony tylko przez użytkownika: %EXPECTED_USERNAME%
    echo Aktualny użytkownik: %USERNAME%
    pause
    exit /b 1
)
:: --------------------------------------------------------------------------------------------

:: Konfiguracja

set "SOURCE=\\192.168.1.252\laborex\MM"
set "DEST=C:\Users\OBAC\Documents\MM\MM_z_servera"

:: === Sprawdza, czy folder źródłowy istnieje. Jeśli nie, wyświetla komunikat o błędzie, zatrzymuje skrypt i wychodzi z kodem błędu.
if not exist "%SOURCE%" (
    echo ERROR: Folder źródłowy nie istnieje
    pause
    exit /b 1
)
:: === Tworzenie folderów docelowych, jeśli nie istnieją ===
if not exist "%DEST%" (
    echo Tworzenie folderu: %DEST%
    mkdir "%DEST%"
)

:: === Test połączenie z serwerem docelowym, wysyłając dwa pakiety ping. Jeśli nie otrzyma odpowiedzi, zgłasza błąd i kończy skrypt.
echo Sprawdzam połączenie z serwerem...
ping -n 2 192.168.1.252 > nul || (
    echo ERROR: Serwer nieosiągalny
    pause
    exit /b 1
)

:: === Dodatkowe sprawdzenie dostępności do sserwerze. Jeśli nie jest dostępny, sugeruje możliwe przyczyny błędu i kończy skrypt.
dir "%DEST%" >nul 2>&1 || (
    echo ERROR: Nie można uzyskać dostępu do udziału sieciowego
    echo Sprawdź czy:
    echo 1. Ścieżka %DEST% jest poprawna
    echo 2. Masz uprawnienia dostępu
    echo 3. Serwer wymaga uwierzytelnienia
    pause
    exit /b 1
)

:: === Generowanie daty dla logów ===
for /f %%a in ('wmic os get localdatetime ^| find "."') do set datetime=%%a
set "LOGDATE=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%_%datetime:~8,2%-%datetime:~10,2%"


:: === Kopiowanie (uproszczone parametry)
echo Kopiuję pliki na serwer...
echo Kopiuję pliki na serwer (z wykluczeniem folderu OBAC)
:: --------------------------------------------------------------------------------------------------------------------
:: robocopy "%SOURCE%" "%DEST%" /MIR /R:3 /W:3 /NP /MT:8 /LOG:"%~dp0%LOGDATE%-Kopia_z_serwera_do_C_MM_z_serwera.log" /TEE /XD "%SOURCE%\OBAC"
robocopy "%SOURCE%" "%DEST%" /MIR /R:3 /W:3 /MT:8 /XD "%SOURCE%\OBAC"
:: --------------------------------------------------------------------------------------------------------------------

:: Używa narzędzia `robocopy` do kopiowania plików:
:: -  /XD "%SOURCE%\OBAC" "%SOURCE%\INNY_FOL"
:: - `/E`    – Kopiuje wszystkie pliki i podfoldery, nawet te puste.
:: - `/R:3`  – W przypadku błędów podejmie jedną próbę ponownego kopiowania.
:: - `/W:3`  – Odczeka 3 sekundy przed ponowną próbą kopiowania.
:: - `/NP`   – Nie wyświetla postępu kopiowania.
:: - `/MT:8` – Używa 8 wątków do kopiowania (przyspiesza operację).

if errorlevel 8 (
    echo ERROR: Wystąpił błąd podczas kopiowania ...
    pause
    exit /b 1
)

echo Kopiowanie zakończone pomyślnie
pause
