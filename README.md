<a href="https://toolbox-bodensee.de"><img src="https://assets.gitlab-static.net/uploads/-/system/group/avatar/6246985/9744766.png" align="right" hspace="10" vspace="6"></a>

Webseite der Toolbox Bodensee e.V.
====================================

[![Build Status](https://gitlab.com/ToolboxBodensee/webseite/toolbox-webseite/badges/master/pipeline.svg)](https://gitlab.com/ToolboxBodensee/webseite/toolbox-webseite/pipelines)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

**Entwicklung nur auf [GitLab](https://gitlab.com/ToolboxBodensee/webseite/toolbox-webseite). Auf GitHub befindet sich lediglich ein Mirror**

Dies ist der Quellcode zur aktuellen Webseite des Maker- und Hackspace Toolbox Bodensee e.V., die unter [toolbox-bodensee.de](https://toolbox-bodensee.de/) erreichbar ist.


Anforderungen
---------------------------------
Um an der Webseite mitzuarbeiten, musst du lediglich dieses Git Repoitory runterladen und Lektor installieren.<br/>
Dies ist sowohl unter Linux, Windows und Apfel möglich.

Zum Clonen des Git Repository sollte lediglich ``git-lfs`` installiert sein. Die Installation aller weiteren Abhängigkeiten ist mit ``make`` möglich. Alternativ gibt es auch einen Docker Container der alles Erforderliche mitbringt.

### Linux:
Dein Paketmanager *(zum Beispiel ``apt``)* sollte das Paket git-lfs anbieten. Beispiel:
```bash
sudo apt install git-lfs
```

### Mac OSX
```bash
brew install git-lfs
```

### Windows
Lade den Downloader von [hier](https://github.com/git-lfs/git-lfs/releases) und führe ihn aus.

### Weitere Informationen
Weitere Informationen zur Installation von git-lfs gibt es auch hier: [git-lfs.github.com](https://git-lfs.github.com/)


Installation
---------------------------------

Zur Erleichterung der Installation beinhaltet das Projekt eine Makefile. Diese erlaubt es ``Abhängigkeiten zu installieren``(z.B. nodejs), sowie die Webseite mit einem ``Python Module`` oder in einem ``Docker Container`` zu bauen.

Die Webseite kann beispielsweise folgendermaßen ausgeführt werden:
```bash
# source code lokal abspeichern
git clone https://gitlab.com/ToolboxBodensee/webseite/toolbox-webseite.git toolbox-webseite

# Wechsel in den zugehörigen Ordner
cd toolbox-webseite

# Installation von Abhängigkeiten
make install

# Starten der Webseite (lässt sich unter 127.0.0.01:5000 aufrufen)
make server
```


Nähere Informationen
---------------------------------
| **[Grundlagen](https://gitlab.com/ToolboxBodensee/webseite/toolbox-webseite/-/wikis/Grundlagen)**     | **[Installation](https://gitlab.com/ToolboxBodensee/webseite/toolbox-webseite/-/wikis/Installation)**     | **[Beitragen](https://gitlab.com/ToolboxBodensee/webseite/toolbox-webseite/-/wikis/Contribution)**           |
|-------------------------------------|-------------------------------|-----------------------------------|
| [![Grundlagen](https://gitlab.com/ToolboxBodensee/webseite/toolbox-webseite/-/wikis/images/tech-docs.png)](https://gitlab.com/ToolboxBodensee/webseite/toolbox-webseite/-/wikis/Grundlagen) | [![Install](https://gitlab.com/ToolboxBodensee/webseite/toolbox-webseite/-/wikis/images/install.png)](https://gitlab.com/ToolboxBodensee/webseite/toolbox-webseite/-/wikis/Installation) | [![Beitragen](https://gitlab.com/ToolboxBodensee/webseite/toolbox-webseite/-/wikis/images/edit.png)](https://gitlab.com/ToolboxBodensee/webseite/toolbox-webseite/-/wikis/Beitragen) |
