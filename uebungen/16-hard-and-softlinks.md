# Übungen zu Hard- und Softlinks

Erzeugt in eurem Heimatverzeichnis einen Ordner `hard-und-softlinks` mit den Unterordnern `originals` und `links`. Erstellt nun in `originals` die Dateien `orig1`, `orig2`, `orig3` und `orig4`.

Füllt diese mit jeweils einer Zeile Inhalt (mittles `echo` und Redirects oder einem Editor).

Erstellt zusätzlich einen Ordner `origdir` in `originals` in welchem sich eine Datei `dirdat` befinden soll.

## Übung 1

- Erstellt nun jeweils einen symbolischen Link von `orig1` nach `softlink1` in `links`.
- Ändert nun den Inhalt des Links `softlink1`. Prüft nach, ob sich der Inhalt auch in der Originaldatei geändert hat. 
- Löscht nun die Originaldatei und versucht anschließend, über den Link auf den Inhalt der Datei zuzugreifen.

## Übung 2

- Erstellt einen weiteren Softlink von `orig2` nach `links/softlink2`. 
- Ändert nun die Berechtigungen des Links auf `600`. 
- Prüft die Berechtigungen auf den Softlink. Warum hat das nicht geklappt? 
- Prüft nun einmal, welche Berechtigungen auf die Originaldatei gesetzt sind. Macht euch klar was hier passiert ist...

## Übung 3

- Löscht nun den Link. 
- Ist das Original noch erhalten?

## Übung 4

- Verlinkt nun den Ordner `origdir` nach `links/linkdir` mit einem Softlink. 
- Was passiert mit der darin enthaltenen Datei? Könnt ihr auf den Inhalt zugreifen und diesen ändern? Was passiert dabei mit der Originaldatei?

## Übung 5

- Führt obige Aufgaben analog mit Hardlinks aus. 
- Verlinkt also entsprechend die Dateien `orig3` und `orig4` bzw. das Verzeichnis `origdir`.
- Die Namen der Links sollten jetzt natürlich `hardlink1` etc. heissen. 
- Prüft auch hier nach, was passiert:
  - beim Erstellen neuen Inhalts
  - beim Ändern der Berechtigungen
  - beim Löschen des "Originals" etc.

## Übung 6

- Erzeugt einen weiteren Hardlink von `orig3` nach `links/hardlink3`. 
- Ermittelt nun mit den Kommandos `ls` und `stat`, wie viele Links auf die Dateien `orig3` und `orig4` gesetzt sind.
- Probiert auch einmal die Option `-i` von `ls` aus. Diese zeigt die *Inode* einer Datei an. 
- Lasst euch also jeweils die Inode des Hardlinks und des "Originals" anzeigen.
- Macht das gleiche einmal mit Softlinks und deren "Original"
- Recherchert, was eine Inode ist.

## Übung 7

- Was genau ist also ein Hardlink?
- Was ist der Unterschied zu einem Softlink?

## Übung 8

Um Links zu löschen, kann auch das Kommando `unlink` verwendet werden. Probiert das einmal aus. Was passiert, wenn man `unlink` auf eine _normale_ Datei anwende? Warum?
