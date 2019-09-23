#!/bin/bash
pwd
git remote add gitea gitea@gitea.see-base.de:toolbox/toolbox-webseite.git
echo $LEKTOR_DEPLOY_KEY > $HOME/.ssh/id_rsa
chmod 600 $HOME/.ssh/id_rsa
git push gitea master
