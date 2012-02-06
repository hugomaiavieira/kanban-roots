# Kanban roots [![Build Status](https://secure.travis-ci.org/hugomaiavieira/kanban-roots.png)](http://travis-ci.org/hugomaiavieira/kanban-roots) [![Dependency Status](https://gemnasium.com/hugomaiavieira/kanban-roots.png)](https://gemnasium.com/hugomaiavieira/kanban-roots)

A kanban board that keep the simplicity as well as the roots of the concept.

## Example

[http://kanban-roots.heroku.com](http://kanban-roots.heroku.com)

**Obs.:** the database of this example is regularly cleaned up.

![kanban-roots board print](http://github.com/downloads/hugomaiavieira/kanban-roots/kanban-roots.png "kanban-roots board print")

## System dependencies

### pygments

The [pygments](http://pygments.org/) is a python package used on 
[markdown](http://daringfireball.net/projects/markdown/) syntax
highlighting. To install it, just run:

    $ (sudo) easy_install pygments


## Using on Heroku

If you don't know [heroku](http://heroku.com) yet, just follow the
[Geting Started with Heroku](http://docs.heroku.com/quickstart) guide with one
difference: instead of use `git push heroku master`, you will use the script
_heroku-deploy.sh_.

I [add a hack](https://github.com/hugomaiavieira/kanban-roots/commit/e008af61bdcce90f5ff0eb0e2edd359ac206f53c)
for pygments work on Heroku, based on [this post](http://matthewboston.com/posts/3)
from [Matthew Boston](https://github.com/bostonaholic) blog. So, don't worry
about that.

That's it! Simple like that =)

## License

Copyright (c) 2011 Hugo Henriques Maia Vieira

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

