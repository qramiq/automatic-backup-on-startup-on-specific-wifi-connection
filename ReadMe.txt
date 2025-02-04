Voraussetzungen:

    Dein Skript (.ps1) ist bereits gespeichert, und du hast die Pfade zum Skript sowie den WLAN-Namen (SSID) in deinem PowerShell-Skript angepasst, wie zum Beispiel:
        WLAN-Name: Der Wert $expectedWifi = "Your Wifi" muss dem tatsächlichen Namen deines WLANs entsprechen.
        Pfad für das Backup: Die Quellen- und Zielpfade im Skript müssen ebenfalls auf die richtigen Ordner auf deinem System angepasst werden.

Schritte zur Einrichtung über MMC mit Gruppenrichtlinien
1. Öffne die MMC (Microsoft Management Console) und füge das "Group Policy Object" Snap-In hinzu:

    Drücke Windows-Taste + R, gib mmc ein und drücke Enter.
    Im MMC-Fenster klicke auf Datei > Snap-In hinzufügen/entfernen.
    Wähle Gruppenrichtlinienobjekt-Editor aus der Liste und klicke auf Hinzufügen.
    Klicke dann auf OK.

2. Wähle das passende Gruppenrichtlinienobjekt aus:

    Wenn du eine neue Gruppenrichtlinie für eine bestimmte Benutzergruppe erstellen möchtest, kannst du dies direkt im Active Directory oder für den lokalen Computer tun.
    Klicke in der MMC auf Gruppenrichtlinienobjekt und dann auf Bearbeiten, um die GPO für den Benutzer oder Computer zu konfigurieren.
    Um das Skript beim Anmelden auszuführen, wähle Benutzereinstellungen.

3. Navigiere zu den Benutzerkonfigurationseinstellungen:

    Im Gruppenrichtlinien-Editor navigierst du zu:

    Benutzerkonfiguration > Windows-Einstellungen > Skripts (Anmeldung/Abmeldung)

    Klicke im rechten Bereich auf Anmeldung.
    Im daraufhin erscheinenden Fenster kannst du jetzt ein Skript hinzufügen.

4. Füge das PowerShell-Skript zur Anmeldung hinzu:

    Klicke auf Hinzufügen und dann auf Durchsuchen.
    Navigiere zum Speicherort deiner .ps1-Datei (z.B. C:\Pfad\zu\deinem\BackupScript.ps1).
    Klicke auf Öffnen.

Und als Argumente gibst du den folgenden Befehl ein:

-ExecutionPolicy Bypass -File "C:\Pfad\zu\deinem\BackupScript.ps1"


6. Speichern und schließen:

    Klicke auf OK, um das Skript hinzuzufügen.
    Schließe den Gruppenrichtlinien-Editor und speichere die Änderungen.

7. Gruppenrichtlinie aktualisieren:

    Um die Änderungen sofort anzuwenden, kannst du entweder den Computer neu starten oder den Befehl gpupdate /force in einer administrativen Eingabeaufforderung ausführen.

Wichtige Hinweise:

    WLAN-Namen anpassen: Im Skript selbst musst du sicherstellen, dass der $expectedWifi-Wert dem Namen deines WLANs entspricht. Falls du mit einem anderen Netzwerk verbunden bist, führt das Skript den Backup-Vorgang nicht aus.
    Backup-Pfade anpassen: Stelle sicher, dass die Pfade für das sourcePath und destinationPath korrekt gesetzt sind. Zum Beispiel, wenn das Quellverzeichnis auf C:\Backuptest zeigt, stelle sicher, dass der Ordner existiert. Dasselbe gilt für den Zielordner auf der externen Festplatte (D:\Backup).
    Ausführungsrichtlinien: Durch das Argument -ExecutionPolicy Bypass wird die Ausführung des PowerShell-Skripts auch dann erlaubt, wenn die lokalen Ausführungsrichtlinien für PowerShell-Skripte eingeschränkt sind.

