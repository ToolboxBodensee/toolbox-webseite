# -*- coding: utf-8 -*-
from lektor.pluginsystem import Plugin
from jinja2.utils import Markup

class IndentfixPlugin(Plugin):
    name = 'indentfix'
    description = u'this is the fixed version of the indent filter, thats not in the newest version of jinja2 yet'

    def on_setup_env(self, **extra):
        def indentfix(s, width=4, first=False, blank=False):
            indention = u' ' * width
            newline = u'\n'

            if isinstance(s, Markup):
                indention = Markup(indention)
                newline = Markup(newline)
        
            s += newline  # this quirk is necessary for splitlines method
        
            if blank:
                rv = (newline + indention).join(s.splitlines())
            else:
                lines = s.splitlines()
                rv = lines.pop(0)
        
                if lines:
                    rv += newline + newline.join(
                        indention + line if line else line for line in lines
                    )
        
            if first:
                rv = indention + rv
        
            return rv
        
        self.env.jinja_env.filters['indentfix'] = indentfix
