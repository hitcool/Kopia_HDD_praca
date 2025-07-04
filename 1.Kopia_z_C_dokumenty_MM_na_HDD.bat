@echo off
chcp 65001 >nul
:: kolor czcionki color XY  X = kolor tła, Y = kolor czcionki
color 0B
setlocal ENABLEDELAYEDEXPANSION

:: --------------------------------------------------------------------------------------------
:: === Konfiguracja folderów ===
set "SOURCE1=C:\Users\OBAC\Documents\MM"
set "DEST1=D:\ARCHIWUM\Work\Laborex\1.Laborex_backup_Dokuments_folder_MM\MM"

:: set "SOURCE2=C:\Users\OBAC\Downloads\Urz do chleba"
:: set "DEST2=D:\zzzzz"
:: --------------------------------------------------------------------------------------------

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

:: === Szukaj litery dysku o etykiecie Toshiba_2TB ===
set "TARGET_LABEL=Toshiba_2TB"
set "TARGET_DRIVE="

for %%D in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    vol %%D: 2>nul | findstr /C:"%TARGET_LABEL%" >nul
    if !errorlevel! == 0 (
        set "TARGET_DRIVE=%%D:"
        goto :FOUND
    )
)
:: --------------------------------------------------------------------------------------------

:NOTFOUND

color 0C
echo.
echo !!! ERROR: Nie znaleziono podłączonego dysku z etykietą:    %TARGET_LABEL% !!!
echo  Włóż poprawny pendrive i spróbuj ponownie.
echo.
pause
exit /b 1

:FOUND
echo Znaleziono pendrive: %TARGET_DRIVE%
echo.

:: === Generowanie daty dla logów ===
for /f %%a in ('wmic os get localdatetime ^| find "."') do set datetime=%%a
set "LOGDATE=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%_%datetime:~8,2%-%datetime:~10,2%"


:: === Tworzenie folderów docelowych, jeśli nie istnieją ===
if not exist "%DEST1%" (
    echo Tworzenie folderu: %DEST1%
    mkdir "%DEST1%"
)
:: if not exist "%DEST2%" (
::     echo Tworzenie folderu: %DEST2%
 ::    mkdir "%DEST2%"
:: )

:: === Lustrzane odbicie (mirror) ===
echo === [1/2] Mirror: %SOURCE1% -> %DEST1%
:: ------------------------------------------------------------------------------------------------------------------
robocopy "%SOURCE1%" "%DEST1%" /MIR /DCOPY:T /COPY:DAT /MT:4 /R:2 /W:3 /NP /LOG:"%~dp0%LOGDATE%-Kopia_2TB_z_C_dokumenty_MM_na_HDD.log" /TEE
:: ------------------------------------------------------------------------------------------------------------------
echo === [1/2] Zakończono
echo.

:: === Aktualizacja bez usuwania (update only) ===
:: echo === [2/2] Aktualizacja: %SOURCE2% -> %DEST2%
:: robocopy "%SOURCE2%" "%DEST2%" /E /XO /DCOPY:T /COPY:DAT /MT:4 /R:2 /W:3 /NP /LOG+:"%~dp0Kopia_2TB_%LOGDATE%.log" /TEE

:: echo === [2/2] Zakończono

:: echo.
:: echo === Backup zakończony pomyślnie ===
pause

:: === Opis komend ===
:: /XD "%SOURCE%\OBAC" "%SOURCE%\INNY_FOL"
:: /MIR – lustrzana kopia,
:: /E – kopiuj wszystkie podfoldery (nawet puste),
:: /MT:8 – szybkie kopiowanie,
:: /NP – brak paska postępu (logi czytelniejsze),
:: /DCOPY:T – zachowaj daty folderów,
:: /R:n	Liczba prób ponowienia przy błędzie (np. /R:3 = 3 próby).
:: /W:n	Czas oczekiwania (w sekundach) pomiędzy kolejnymi próbami. Np. /W:5 = 5 sekund.
:: /LOG:plik.txt	Zapisuje logi do pliku (nadpisuje istniejący).
:: /LOG+:plik.txt	Dodaje logi do istniejącego pliku (nie nadpisuje).
:: /TEE	Pokazuje logi na ekranie oraz zapisuje je do pliku.
:: /LOG+:ppp.log /TEE  zapisuje logi i je pokazuje 
:: /NFL	(No File List) – nie pokazuje nazw plików w logu.
:: /NDL	(No Directory List) – nie pokazuje nazw folderów w logu.
:: /XC – pomiń pliki zmienione,
:: /XN – pomiń nowsze,
:: /XO – pomiń starsze.
:: /COPY:DAT = tylko dane, atrybuty, czas (bez ACL, właściciela, audytu) – działa lepiej na pendrive’ach.
:: 
:: Tylko zwykłe pliki (np. dokumenty, zdjęcia)	                    /COPY:DAT
:: Chcesz zachować uprawnienia, właściciela, ACL	                /COPYALL
:: Kopiujesz na system plików FAT32/exFAT (np. pendrive) nie używaj /COPYALL
:: 
:: Używa /COPY:DAT – czyli bez NTFS-owych uprawnień, dzięki czemu działa na dyskach HDD i FAT32,
:: 
:: 
:: 
:: 
:: 
:: 
:: 
:: 
:: 
:: 
:: 
:: 
:: 
:: 
:: 
:: 
:: 
:: 
:: 
:: 
:: 
