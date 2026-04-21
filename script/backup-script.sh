#!/usr/bin/env bash

# TODO:
# - Backup erstellen von:
#   - erstmal Home Verzeichnis -> Quellverzeichnis
#   - Zielverzeichnis? Wo speichern wir unsere Backups?
#     - erstmal im Heimatverzeichnis -> darf nicht mit ins Backup
#       - Archiv an einem Ort ausserhalb des Homeverzeichnisses ablegen
#       - Archiv selbst vom Backup ausschliessen
#     - später anderer Ort
#     - evtl. sogar externer Datenträger
#   - später andere Verzeichnisse hinzufügen
#     - hardcodiert ins Skript?
#     - dem Skript übergeben?
#     - interaktiv abfragen?
#   - modular aufbauen
# - Wie machen wir das Backup? Mit welchen Kommandos?
#   - tar
#   - gzip, bzip2, xz
# - später automatisiert ablaufen lassen (cron)
# - vielleicht nur geänderte Dateien speichern (inkrementell)
# - [x] Backup nicht im scripts verzeichnis ablegen -> sondern: ~/home-backups
# - [x] Backup nicht immer wieder überschreiben -> timestamp im Namen
# - [x] Zusammenfassung: Wie viele Verzeichnisse/Dateien wurden gesichert
# - [ ] zu sichernde Verzeichnisse im Backup-Namen
# - [x] Backup auf externen Datenträger
#   - [x] prüfen, ob dieser eingehangen ist

#set -x
 
TIMESTAMP=$(date +%Y%m%d_%H%M)
BACKUP_FILE=backup_home_$TIMESTAMP.tar
DEFAULT_DIR_TO_BACKUP=/home/tux
DIRS_TO_BACKUP=$@
MOUNT_DIR=/mnt
PARTITION_TO_MOUNT=/dev/vdb1
DEST_DIR=$MOUNT_DIR/backups

# Prüfen, ob Script mit Root-Rechten ausgeführt wird
#if [ $UID -ne 0 ]; then
#	echo ERROR: Dieses Script muss mit root Rechten ausgeführt werden
#	exit 1
#fi

# Prüfen, ob Datenträger unter /mnt gemountet ist
if [ $(mount | grep $MOUNT_DIR | grep $PARTITION_TO_MOUNT | wc -l) -ne 1 ]; then
	mount $PARTITION_TO_MOUNT $MOUNT_DIR
fi

# Backups Verzeichnis erstellen falls es nicht existiert
if [ ! -d $DEST_DIR ]; then
	echo Verzeichnis erstellen
	mkdir $DEST_DIR
fi

# Anzahl der dem Skript übergebenen Argumente prüfen
if [ $# -eq 0 ]; then
	# Backup des Heimatverzeichnisses mit tar erstellen
	echo Backup des Heimatverzeichnisses erstellen
	DIRS_TO_BACKUP=$DEFAULT_DIR_TO_BACKUP
fi 

# Prüfen, ob Dateien/Verzeichnisse existieren
for DIR in $DIRS_TO_BACKUP; do
	if [ ! -e $DIR ]; then
		echo $DIR ERROR: existiert nicht, Abbruch
		exit 2
	fi
done

# diese Dateien/Verzeichnisse sichern
echo Backup der Verzeichnisse $DIRS_TO_BACKUP erstellen
tar --create --file $DEST_DIR/$BACKUP_FILE --exclude=$BACKUP_FILE $DIRS_TO_BACKUP 2>/dev/null

# Prüfen, ob tar erfolgreich ausgeführt werden konnte
EXIT_CODE_TAR=$?
if [ $EXIT_CODE_TAR -ne 0 ]; then
	echo ERROR: Das Backup konnte nicht erfolgreich erstellt werden. 
	echo tar hat einen Exit Code $EXIT_CODE_TAR zurückgegeben.
	exit 3
fi

# Anzahl der gesicherten Dateien zählen und ausgeben
echo Es wurden insgesamt $(tar --list --file $DEST_DIR/$BACKUP_FILE | wc -l) Dateien gesichert.

echo Skript zu Ende
exit 0











