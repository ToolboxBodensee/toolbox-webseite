[![Build Status](https://travis-ci.org/ToolboxBodensee/toolbox-webseite.svg?branch=master)](https://travis-ci.org/ToolboxBodensee/toolbox-webseite)

 Webseite der Toolbox Bodensee e.V.
====================================

![Toolbox](https://avatars0.githubusercontent.com/u/9744766?s=200&v=4 "Toolbox Logo")

Status
------------
Dies ist der Quellcode der aktuellen Webseite des Maker- und Hackspace Toolbox Bodensee e.V.
Diese findet man unter [toolbox-bodensee.de](https://toolbox-bodensee.de/)

 Lektor CMS:
------------
Das CMS für diese Webseite ist [Lektor](https://www.getlektor.com/).
Die Installationsanleitung gibt es [hier](https://www.getlektor.com/downloads/).
Lektor ist auch als Python Modul verfügbar und kann mit ``python2 -m lektor`` verwendet werden.
Auch die Installation über pip ist möglich:
```bash
virtualenv venv
. venv/bin/activate
pip install lektor
```

Zum Starten von Lektor muss man mit der Komandozeile in das root Verzeichnis der Webseite gehen
und dort mit dem Befehl ``lektor server`` startet man Lektor und öffnen auf 127.0.0.1 den Port 5000 über den die Webseite
bearbeitbar ist. Die Versionskontrolle der Webseite findet über Git statt. Daher wenn möglich Bilder erst
bearbeiten, bevor diese Veröffentlicht werden!


 Zur neuen Webseite Beitragen:
------------------------
 1. Dieses Repository Forken oder einen neuen Branch machen (übers GitHub Interface)
 2. Geforktes Repository Clonen (``git clone https://github.com/<Your_Name>/toolbox-webseite.git``)
 3. Öffne deine Komandozeile im geklonten Repository-Fork (``cd toolbox-webseite``)
 4. Lektor starten (``python2 -m lektor server``)
 5. Webseite updaten... (``http://localhost:5000/``)
 6. Lektor Beenden (``Strg. + C``)
 7. Änderungen commiten (``git add --all; git commit -m "An der Webseite habe ich _____ geändert"``)
 8. Änderungen hochladen (``git push``)
 9. Pull-Request Stellen (übers GitHub Interface)

 Fork aktuell halten ohne neu zu forken:
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
-----------------------
 1. Die im Pull-Request eingereite Version clonen ``git clone --depth 23 <REPO> -b <BRANCH> <ORDNERNAME>``
 2. Den geklonten Pull-Request anschauen ``lektor server``
 3. Änderungen requesten oder Pull-Request approven

 Design:
---------
Das Design basiert auf [HTML5UP](https://html5up.net), genauer gesagt auf dem Design [Landed](https://html5up.net/landed). Und wurde natürlich für die Toolbox Webseite angepasst!

Bei den Menüfarben sollte die Farbauswahl aus dem [Toolbox Presse-Kit](https://github.com/ToolboxBodensee/presskit) berücksichtigt werden. ![#E64F2D](https://placehold.it/15/E64F2D/000000?text=+) `#E64F2D` Orange und ![#9B160F](https://placehold.it/15/9B160F/000000?text=+) `#9B160F` Rot sind hier die Primärfarben.

 CSS:
------
Das CSS Design wird mit [sass](https://sass-lang.com/) generiert.
Das vereinfacht die Verständlichkeit der einzelnen Design Elemente
und ermöglicht auch das anpassen des Designs durch das simple verändern weniger variablen.
Example use:
```bash
sassc assets/sass/main.scss > assets/css/main.css
```



