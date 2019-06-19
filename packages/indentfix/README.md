# indentfix

Jinja2 has a indent filter. Sadly the version thats in the current jinja2 release is broken and always escapes html. However there is already a fixed version of the filter on the master branch of jinja2 which can be found at: [filters.py](https://github.com/pallets/jinja/blob/master/jinja2/filters.py)

This is implements the indent filter that can be found on the master branch of jinja2 as a plugin for lektor2, so it can be used here until the fixed version of the filter gets into the release. The filter can be used in the same way the original filter can be used:

indentfix(s, width=4, first=False, blank=False)
  Return a copy of the string with each line indented by 4 spaces. The first line and blank lines are not indented by default.

  Parameters:	
  width – Number of spaces to indent by.
  first – Don’t skip indenting the first line.
  blank – Don’t skip indenting empty lines.
