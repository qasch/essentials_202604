# Übungen zu Netzwerkkonfiguration

## Wissensfragen - Multiple Choice

### Übung 1

Welcher Befehl zeigt die IP-Adresse aller Netzwerkschnittstellen auf einem modernen Linux-System an?

- [ ] a) `ipconfig -a`
- [ ] b) `ip addr show`
- [ ] c) `netstat -i`
- [ ] d) `route show`

#### Lösung

**b) `ip addr show`**

Der Befehl `ip addr show` (oder kurz `ip a`) ist der moderne Standard aus dem `iproute2`-Paket.`ipconfig` gibt es nur unter Windows, `ifconfig` unter Linux ist veraltet, funktioniert aber auf vielen Systemen noch (vorausgesetzt, das Paket `net-tools` ist installiert).

### Übung 2

Was bedeutet die CIDR-Notation `/24` bei der IP-Adresse `192.168.1.10/24`?

- [ ] a) Das Netzwerk hat 24 Hosts.
- [ ] b) Die ersten 24 Bits der IP-Adresse sind der Netzwerkanteil.
- [ ] c) Der Host hat die Nummer 24.
- [ ] d) Die Subnetzmaske ist `255.0.0.0`.

#### Lösung

**b) Die ersten 24 Bits der IP-Adresse sind der Netzwerkanteil.**

`/24` entspricht der Subnetzmaske `255.255.255.0`. Das bedeutet: 24 Bits für das Netzwerk, 8 Bits für Hosts → 254 nutzbare Host-Adressen.

### Übung 3

Welche der folgenden IP-Adressen ist eine **private** Adresse gemäß RFC 1918?

- [ ] a) `8.8.8.8`
- [ ] b) `172.32.0.1`
- [ ] c) `10.0.0.1`
- [ ] d) `169.254.0.1`

#### Lösung

**c) `10.0.0.1`**

Private Adressbereiche (RFC 1918):

- `10.0.0.0/8`
- `172.16.0.0/12`
- `192.168.0.0/16`

`172.32.0.1` liegt außerhalb des privaten Bereichs (`172.16–172.31`). `8.8.8.8` ist öffentlich (Google DNS). `169.254.x.x` ist APIPA (link-local).

### Übung 4

Welcher Dienst/Protokoll wird verwendet, um einem Host automatisch eine IP-Adresse zuzuweisen?

- [ ] a) DNS
- [ ] b) DHCP
- [ ] c) NTP
- [ ] d) FTP

#### Lösung

**b) DHCP**

Das *Dynamic Host Configuration Protocol* (DHCP) weist IP-Adresse, Subnetzmaske, Gateway und DNS-Server automatisch zu.

### Übung 5

Welche Datei enthält unter Linux typischerweise statische Hostname-zu-IP-Zuordnungen?

- [ ] a) `/etc/resolv.conf`
- [ ] b) `/etc/hostname`
- [ ] c) `/etc/hosts`
- [ ] d) `/etc/networks`

### Lösung

**c) `/etc/hosts`**

In `/etc/hosts` können IP-Adressen manuell Hostnamen zugeordnet werden, bevor DNS befragt wird. `/etc/resolv.conf` enthält die DNS-Serveradressen.

## Praktische Übungen

### Übung 6 – Netzwerkschnittstellen anzeigen

Zeige alle Netzwerkschnittstellen mit ihren IP-Adressen an.

#### Lösung

```bash
# Moderne Methode (empfohlen):
ip addr show
# Kurzform:
ip a

# Ältere Methode (noch weit verbreitet):
ifconfig -a
```

Erkläre den Unterschied: `ip` stammt aus dem Paket `iproute2` und ist der Nachfolger von `ifconfig` (aus `net-tools`).

### Übung 7 – Standard-Gateway anzeigen

Zeige die aktuelle Routing-Tabelle an und identifiziere das Standard-Gateway.

#### Lösung

```bash
# Moderne Methode:
ip route show
# oder:
ip r

# Ältere Methode:
route -n
# oder:
netstat -rn
```

Das Standard-Gateway ist die Zeile mit `default` (bei `ip route`) bzw. `0.0.0.0` als Ziel (bei `route -n`).
</details>

### Übung 8 – DNS-Konfiguration prüfen

Zeige an, welche DNS-Server aktuell konfiguriert sind.

#### Lösung

```bash
cat /etc/resolv.conf
```

Beispielausgabe:
```
nameserver 8.8.8.8
nameserver 1.1.1.1
search example.local
```

Zeile `nameserver` → DNS-Serveradresse
Zeile `search` → Standarddomäne für unvollständige Hostnamen

### Übung 9 – Verbindung testen

**Übung:** Teste die Netzwerkverbindung zum Host `1.1.1.1` mit **genau 4 Paketen**. Teste danach die Namensauflösung für `www.lpi.org`.

#### Lösung

```bash
# Verbindungstest mit 4 Paketen:
ping -c 4 1.1.1.1

# Namensauflösung testen:
host www.lpi.org
# oder:
nslookup www.lpi.org
# oder:
dig www.lpi.org
```

### Übung 10 – Hostnamen anzeigen und verstehen

Zeige den aktuellen Hostnamen des Systems an. Welche Datei speichert den Hostnamen dauerhaft?

#### Lösung

```bash
# Hostnamen anzeigen:
hostname
# oder:
hostnamectl

# Datei mit dauerhaftem Hostnamen:
cat /etc/hostname
```

`hostnamectl` zeigt zusätzlich Static hostname, Transient hostname und das Betriebssystem.

### Übung 11 – Netzwerkschnittstelle aktivieren/deaktivieren

Wie aktivierst und deaktivierst du eine Netzwerkschnittstelle namens `eth0`? Nenne die moderne und die ältere Methode.

#### Lösung

```bash
# Moderne Methode (ip):
ip link set eth0 up      # aktivieren
ip link set eth0 down    # deaktivieren

# Ältere Methode (ifconfig):
ifconfig eth0 up
ifconfig eth0 down
```


## Zuordnungsaufgaben

### Übung 12 - Ordne die Befehle ihrer Funktion zu.

| Befehl | Funktion |
|--------|----------|
| `ip addr show` | |
| `ip route show` | |
| `ping -c 4 8.8.8.8` | |
| `cat /etc/resolv.conf` | |
| `hostname` | |
| `ss -tulpn` | |

**Funktionen:**
- A) DNS-Server-Konfiguration anzeigen
- B) Aktuellen Hostnamen ausgeben
- C) Offene Netzwerk-Ports und Verbindungen anzeigen
- D) IP-Adressen aller Schnittstellen anzeigen
- E) Routing-Tabelle anzeigen
- F) Netzwerkverbindung mit 4 Paketen testen

#### Lösung

| Befehl | Funktion |
|--------|----------|
| `ip addr show` | **D** – IP-Adressen aller Schnittstellen anzeigen |
| `ip route show` | **E** – Routing-Tabelle anzeigen |
| `ping -c 4 8.8.8.8` | **F** – Netzwerkverbindung mit 4 Paketen testen |
| `cat /etc/resolv.conf` | **A** – DNS-Server-Konfiguration anzeigen |
| `hostname` | **B** – Aktuellen Hostnamen ausgeben |
| `ss -tuln` | **C** – Offene Netzwerk-Ports und Verbindungen anzeigen |


## Szenario-Übungn

### Szenario 1 – Kein Internetzugriff

Du meldest dich auf einem Linux-Server an. Der Server hat angeblich keinen Internetzugriff. Gehe systematisch vor, um das Problem einzugrenzen.

Beschreibe die Diagnoseschritte in der richtigen Reihenfolge und nenne jeweils den passenden Befehl.

#### Lösung

1. **IP-Adresse prüfen** – Hat der Server überhaupt eine IP?
   ```bash
   ip addr show
   ```

2. **Standard-Gateway prüfen** – Ist ein Gateway konfiguriert?
   ```bash
   ip route show
   ```

3. **Gateway erreichbar?** – Lokale Netzwerkverbindung testen
   ```bash
   ping -c 4 <Gateway-IP>
   ```

4. **Internet erreichbar?** – Öffentliche IP testen (ohne DNS)
   ```bash
   ping -c 4 8.8.8.8
   ```

5. **DNS funktioniert?** – Namensauflösung testen
   ```bash
   host www.lpi.org
   cat /etc/resolv.conf
   ```

Wenn Schritt 4 funktioniert, Schritt 5 aber nicht → DNS-Problem → `/etc/resolv.conf` prüfen.

### Szenario 2 – Netzwerkinformationen auslesen

**Situation:** Du erhältst folgende Ausgabe von `ip addr show`:

```
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP
    link/ether 00:1a:2b:3c:4d:5e brd ff:ff:ff:ff:ff:ff
    inet 192.168.10.42/24 brd 192.168.10.255 scope global eth0
```

Beantworte folgende Fragen:

1. Wie lautet die IP-Adresse des Hosts?
2. Wie lautet die Subnetzmaske (ausgeschrieben)?
3. Wie lautet die MAC-Adresse?
4. Ist die Schnittstelle aktiv?
5. Wie lautet die Broadcast-Adresse?

#### Lösung

1. **IP-Adresse:** `192.168.10.42`
2. **Subnetzmaske:** `255.255.255.0` (entspricht `/24`)
3. **MAC-Adresse:** `00:1a:2b:3c:4d:5e`
4. **Aktiv?** Ja – erkennbar an `UP` im Status (`<BROADCAST,MULTICAST,UP,LOWER_UP>`)
5. **Broadcast:** `192.168.10.255`

