$(function() {

   var $todo = $('#todo'),
       $doing = $('#doing');
       $done = $('#done');
       $backlog = $('#backlog');
       $accepted_by = {
        todo: '#doing > li, #done > li, #backlog > li',
        doing: '#todo > li, #done > li, #backlog > li',
        done: '#todo > li, #doing > li, #backlog > li',
        backlog: '#todo > li, #doing > li, #done > li'
       }

  // let the post-its be draggable
  $('.postit').draggable({
    cursor: 'move',
    helper: 'clone',
    revert: 'invalid'
  });

  // TODO: Make this work and remove the others methods. The this.id do not
  // return what I whant. Yeah, I don't know javascript. Shame on me.
  // let the divisions be droppable, accepting the post-its from others divisions
//  $('.droppable').droppable({
//    accept: $accepted_by[this.id],
//		hoverClass: 'ui-state-hover',
//    drop: function(event, ui) {
//      movePostit(ui.draggable, this);
//    }
//  });

  // let the todo be droppable, accepting the doing, done and backlog items
  $todo.droppable({
    accept: $accepted_by['todo'],
		hoverClass: 'ui-state-hover',
    drop: function(event, ui) {
      movePostit(ui.draggable, this);
    }
  });

  // let the doing be droppable, accepting the todo, done and backlog items
  $doing.droppable({
    accept: $accepted_by['doing'],
		hoverClass: 'ui-state-hover',
    drop: function(event, ui) {
      movePostit(ui.draggable, this);
    }
  });

  // let the done be droppable, accepting the todo, doing and backlog items
  $done.droppable({
    accept: $accepted_by['done'],
		hoverClass: 'ui-state-hover',
    drop: function(event, ui) {
      movePostit(ui.draggable, this);
    }
  });

  // let the backlog be droppable, accepting the todo, doing and done items
  $backlog.droppable({
    accept: $accepted_by['backlog'],
		hoverClass: 'ui-state-hover',
    drop: function(event, ui) {
      movePostit(ui.draggable, this);
    }
  });

});

function movePostit ($postit, $ul) {
  $postit.appendTo($ul);
}
