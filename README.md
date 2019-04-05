<a href="https://toolbox-bodensee.de"><img src="https://avatars0.githubusercontent.com/u/9744766?s=200&v=4" align="right" hspace="10" vspace="6"></a>

Webseite der Toolbox Bodensee e.V.
====================================

[![Build Status](https://travis-ci.org/ToolboxBodensee/toolbox-webseite.svg?branch=master)](https://travis-ci.org/ToolboxBodensee/toolbox-webseite)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

Dies ist der Quellcode zur aktuellen Webseite des Maker- und Hackspace Toolbox Bodensee e.V., die unter [toolbox-bodensee.de](https://toolbox-bodensee.de/) erreichbar ist.


Anforderungen
---------------------------------
Um das repository zu clonen müssen lediglich ``git`` sowie ``git-lfs`` installiert sein. Die Installation aller weiteren Abhängigkeiten ist mit ``make`` automatisiert.

Installation
---------------------------------

Zur Erleichterung der Installation beinhaltet das Projekt eine makefile. Diese erlaubt es ``Abhängigkeiten zu installieren``(zB nodejs), sowie die Webseite mit einem ``Python Module`` oder in einem ``Docker Container`` zu bauen.

Die Webseite kann beispielsweise folgendermaßen ausgeführt werden:
```bash
# source code lokal abspeichern
git clone https://github.com/ToolboxBodensee/toolbox-webseite.git

# Wechsel in den zugehörigen Ordner
cd toolbox-webseite

# Installation von Abhängigkeiten
make install

# Starten der Webseite (lässt sich unter 127.0.0.01:5000 aufrufen)
make server
```

Nähere Informationen
---------------------------------
| **[Grundlagen](https://github.com/ToolboxBodensee/toolbox-webseite/wiki/Grundlagen)**     | **[Installation](https://github.com/ToolboxBodensee/toolbox-webseite/wiki/Installation)**     | **[Beitragen](https://github.com/ToolboxBodensee/toolbox-webseite/wiki/Contributing)**           |
|-------------------------------------|-------------------------------|-----------------------------------|
| [![i1](https://github.com/ToolboxBodensee/toolbox-webseite-wiki/blob/master/images/tech-docs.svg)](https://github.com/ToolboxBodensee/toolbox-webseite/wiki/Grundlagen) | [![i2](https://github.com/ToolboxBodensee/toolbox-webseite-wiki/blob/master/images/install.svg)](https://github.com/ToolboxBodensee/toolbox-webseite/wiki/Installation) | [![i3](https://github.com/ToolboxBodensee/toolbox-webseite-wiki/blob/master/images/edit.svg)](https://github.com/ToolboxBodensee/toolbox-webseite/wiki/Contribution) |
