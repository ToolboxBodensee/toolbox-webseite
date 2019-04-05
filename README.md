<a href="https://toolbox-bodensee.de"><img src="https://avatars0.githubusercontent.com/u/9744766?s=200&v=4" align="right" hspace="10" vspace="6"></a>

Webseite der Toolbox Bodensee e.V.
====================================

[![Build Status](https://travis-ci.org/ToolboxBodensee/toolbox-webseite.svg?branch=master)](https://travis-ci.org/ToolboxBodensee/toolbox-webseite)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

Dies ist der Quellcode zur aktuellen Webseite des Maker- und Hackspace Toolbox Bodensee e.V., die unter [toolbox-bodensee.de](https://toolbox-bodensee.de/) erreichbar ist.


Anforderungen
---------------------------------
Um das repository zu klonen müssen lediglich ``git`` sowie ``git-lfs`` installiert sein. Die Installation aller weiteren Abhängigkeiten ist mit ``make`` automatisiert.

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

Nähere Information
---------------------------------
| **[Technical Docs][techdocs]**     | **[Setup Guide][setup]**     | **[Roadmap][roadmap]**           | **[Contributing][contributing]**           |
|-------------------------------------|-------------------------------|-----------------------------------|---------------------------------------------|
| [![i1][techdocs-image]][techdocs] | [![i2][setup-image]][setup] | [![i3][roadmap-image]][roadmap] | [![i4][contributing-image]][contributing] |

:fa-thumbs-up:

Nähere Informationen zu Installation und Ausführung können im zugehörigen [Wiki](https://github.com/ToolboxBodensee/toolbox-webseite/wiki/Home) im Bereich [Installation](https://github.com/ToolboxBodensee/toolbox-webseite/wiki/Installation) nachgelesen werden



Inhaltsverzeichnis Dokumentation
---------------------------------

* [Home](https://github.com/ToolboxBodensee/toolbox-webseite/wiki/Home)
* [Installation](https://github.com/ToolboxBodensee/toolbox-webseite/wiki/Installation)
  * [Python](https://github.com/ToolboxBodensee/toolbox-webseite/wiki/Installation%3A-Python)
  * [Docker](https://github.com/ToolboxBodensee/toolbox-webseite/wiki/Installation%3A-Docker)
* [Grundlagen](https://github.com/ToolboxBodensee/toolbox-webseite/wiki/Grundlagen)
  * [Lektor CMS](https://github.com/ToolboxBodensee/toolbox-webseite/wiki/Grundlagen%3A-Lektor-CMS)
  * [git LFS](https://github.com/ToolboxBodensee/toolbox-webseite/wiki/Grundlagen%3A-git-LFS)
  * [Design](https://github.com/ToolboxBodensee/toolbox-webseite/wiki/Grundlagen%3A-Design)
  * [CSS](https://github.com/ToolboxBodensee/toolbox-webseite/wiki/Grundlagen%3A-CSS)
* [Contribution](https://github.com/ToolboxBodensee/toolbox-webseite/wiki/Contribution)
  * [Pull Requests Reviewen](https://github.com/ToolboxBodensee/toolbox-webseite/wiki/Contribution%3A-Pull-Requests)
  * [Zur Webseite beitragen](https://github.com/ToolboxBodensee/toolbox-webseite/wiki/Contribution%3A-Projekte)
