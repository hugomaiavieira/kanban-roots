Initial ideas
============

## __Goal__

__Keep as simple as possible__

##View

  * The board have 4 divisions: backlog, todo, doing and done.

  * The backlog division can optionally appear or not on the board, and should
  have a separated view too.

  * Use drag-and-drop of HTML5 to move the tasks between the positions.

  * Different types of Task have different colors.

##Features

  * When a tasks is created, all contributors of the project are informed, besides
    who create.

  * When the position of a tasks is modified, all contributors of the project are
    informed, besides who move.

  * A simple burn-down chart

##Models

  * Project
    * name
    * description

  * Contributor
    * name
    * email
    * project_ids

  * Task
    * title
    * description
    * points
    * category (Normal, Bug, ...)
    * position (on the board)
    * project_id
    * contributor_ids
    * comments __new__

##Future

  * Interact with Github

