[![Build Status](https://travis-ci.org/ToolboxBodensee/toolbox-webseite.svg?branch=master)](https://travis-ci.org/ToolboxBodensee/toolbox-webseite)

Webseite der Toolbox Bodensee e.V.
====================================

![Toolbox](https://avatars0.githubusercontent.com/u/9744766?s=200&v=4 "Toolbox Logo")

Status
------------------------

Dies ist der Quellcode zur aktuellen Webseite des Maker- und Hackspace Toolbox Bodensee e.V., die unter [toolbox-bodensee.de](https://toolbox-bodensee.de/) erreichbar ist.

Lektor CMS
------------------------

Das CMS für diese Webseite ist [Lektor](https://www.getlektor.com/).
Die Installationsanleitung gibt es [hier](https://www.getlektor.com/downloads/).
Lektor ist auch als Python-Modul verfügbar und kann mit ``python2 -m lektor`` verwendet werden.
Auch die Installation über pip *(in einem [virtuellen Enviroment](https://docs.python.org/3/tutorial/venv.html)* ist möglich:
```bash
# create virtual enviroment
virtualenv venv
# activate virtual enviroment
. venv/bin/activate
# install lektor to virtual enviroment
pip install lektor

# install ruby-sass (for css styles)
gem install sass
```

Zum Starten von Lektor muss man mit der Komandozeile in das root-Verzeichnis der Webseite gehen
und dort mit dem Befehl ``lektor server`` Lektor starten. Im Browser kann dann 127.0.0.1:5000 aufgerufen werden, um die Webseite zu bearbeiten. Die Versionskontrolle der Webseite findet über Git statt. Daher wenn möglich Bilder erst
bearbeiten, bevor diese veröffentlicht werden!

Zur Webseite Beitragen
------------------------

1.  Dieses Repository forken oder einen neuen Branch machen (übers GitHub Interface)
2.  Geforktes Repository Clonen (``git lfs clone https://github.com/<Your_Name>/toolbox-webseite.git``)
3.  Öffne deine Komandozeile im geklonten Repository-Fork (``cd toolbox-webseite``)
4.  Lektor starten (``python2 -m lektor server``)
5.  Webseite updaten... (``http://localhost:5000/``)
6.  Lektor Beenden (``Strg. + C``)
7.  Änderungen commiten (``git add --all; git commit -m "An der Webseite habe ich _____ geändert"``)
8.  Änderungen hochladen (``git push``)
9.  Pull Request Stellen (übers GitHub Interface)

 Bilder und große Dateien
---------------------------
Für große Dateien haben wir angefangen auf [git-lfs](https://git-lfs.github.com/) zu setzen. Hierbei werden große Dateien nicht mehr ganz so schlimm in die History des git eingebaut.
Das war mit mehreren MB großen Bildern schon schlimm, aber noch verkraftbar. Mit größeren Videos aber... Sollte man das halt echt nicht direkt ins git werfen!

Zur Verwendung von git-lfs muss die git-lfs command line extention installiert sein!
Die geschieht auf den gängigsten Platformen zB. mit:

```bash
sudo apt install git-lfs
```
oder
```bash
sudo pacman -S git-lfs
```
 
Webseite übersetzen
------------------------

Lektor bietet in der Admin-Oberfläche die Möglichkeit die Toolbox Webseiten ins Englische zu übersetzen.
Diese Funktion befindet sich unter dem Punkt ``Alternative``.
Als Übersetzer mit guten Ergebnissen kann man beispielsweise [deepl](https://www.deepl.com) verwenden.<br/>
Links auf Seiten haben in der englischsprachigen Version ein ``/en/`` vor der Adresse.
So wird ``https://toolbox-bodensee.de/projekte/c3woc/`` bspw. zu ``https://toolbox-bodensee.de/en/projekte/c3woc/``.

Fork aktuell halten ohne neu zu forken
------------------------

```bash
cd toolbox-webseite

# Das Original Repository der Toolbox einbinden:
git remote add upstream https://github.com/ToolboxBodensee/toolbox-webseite.git
git fetch upstream

# Deinen Fork lokal aktualisieren:
git pull upstream master
```

Pull Request Reviewen
------------------------

Es gibt zwei Möglichkeiten Pull Requests zu reviewen:

### Änderungen lokal Downloaden und Bewerten

1.  Die im Pull Request eingereihte Version clonen

```bash
# ID des Pull Request eintragen
PULLREQUEST=42
# Git-Repository clonen
git clone --depth=30 https://github.com/ToolboxBodensee/toolbox-webseite.git toolbox-pull-request
# In das Repo navigieren
cd toolbox-pull-request
# zum Pull Request wechseln
git fetch origin +refs/pull/$PULLREQUEST/merge:
git checkout -qf FETCH_HEAD
```

2.  Den geklonten Pull Request anschauen ``lektor server``
3.  Änderungen requesten oder Pull Request approven

### Änderungen online reviewen

Die eingereichten Pull Requests werden automatisiert durch ein [Go-Skript](https://github.com/ottojo/pullRequestHost) und Travis auf ein Testsystem deployed. Nachdem die Travis-Checks durchgelaufen sind, kann man diesen Pull Request unter den von einem bot geposteten Link anschauen. Auf GitHub sieht man, welche Dateien hier betroffen sind. Auf dem Testsystem sieht man, wie das fertige Ergebnis aussieht.

Design
------------------------

Das Websitelayout basiert auf [HTML5UP](https://html5up.net), genauer gesagt auf dem Design [Landed](https://html5up.net/landed). Und wurde natürlich für die Toolbox-Webseite angepasst!

Bei der Farbwahl (z.B. Menüfarben) sollte das [Toolbox Presse-Kit](https://github.com/ToolboxBodensee/presskit) berücksichtigt werden. ![#E64F2D](https://placehold.it/15/E64F2D/000000?text=+) `#E64F2D` Orange und ![#9B160F](https://placehold.it/15/9B160F/000000?text=+) `#9B160F` Rot sind hier die Primärfarben.

CSS
------------------------

Das CSS-Design wird mit [sass](https://sass-lang.com/) generiert.
Das vereinfacht die Verständlichkeit der einzelnen Designelemente
und ermöglicht auch das Anpassen des Designs durch das simple Verändern weniger Variablen.
Example use:
```bash
make sass
```

Docker
------------------------

Hat man auf seiner Host kein python oder will man *keine* zusätzliche Software installieren, so steht ein Docker Image `toolboxbodensee/lektor:latest` zur Verfügung.

Damit lässt sich das Projekt innerhalb eines *Containers* bauen und sogar der Lektor-Server ausführen.

Der Einfachheit halber stehen mehrere *make* **docker-** Befehle zur Verfügung. Der Projektordner sowie die Lektor-cache `.cache/lektor` werden als Volume zu der Container angehängt.

```bash
make docker-pull # lädt die Lektor Docker Image vom Docker Hub herunter
make docker-build # baut die Assets und die lektor cache (lektor build)
make docker-server # führt den Lektor Server auf localhost:5000 aus
make docker-shell # führt eine Shell aus innerhalb des Containers. Diese kann man zum Debuggen nutzen.
```

**Tipp:** Zum Verwenden von Docker muss ``docker`` installiert sein und als Service gestartet sein.<br/>
Außerdem muss dein User zur Gruppe docker gehören und sollte nicht als root ausgeführt werden!<br/>
Weitere Hinweise dazu u.a. auf [wiki.archlinux.org](https://wiki.archlinux.org/index.php/docker#Installation).
