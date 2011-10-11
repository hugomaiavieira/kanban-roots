function update_score_points(contributors, score) {
  $.each(contributors, function(index, id) {
    contributor = $('#contributor_'.concat(id));
    contributor_points = parseFloat(contributor.text());
    contributor.text((contributor_points + score).toFixed(1));
    // TODO: sort of the scores list
  });
}

$(function() {
  var $todo = $('#todo'),
      $doing = $('#doing'),
      $done = $('#done'),
      $backlog = $('#backlog'),
      // the divisions should accept post-its from all divisions, except from itself
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

  // let the divisions be droppable, accepting the post-its from others divisions
  $('.droppable').each(function(key, value){
      $(value).droppable({
        accept: $accepted_by[value.id],
        hoverClass: 'ui-state-hover',
        drop: function(event, ui) {
          movePostit(ui.draggable, $(value));
          defineHeight();
        }
      });
  });
});

// slide points select
$(function() {
  $(".show_points").click(function () {
    var task = $(this).parents('li'),
        select = task.find('.points_select');
    select.fadeToggle("fast");
  });
});

// change task points and slide back the select
$(function() {
  $('.points_select').change(function () {
    var show_points = $(this).siblings('.show_points'),
        division_id = show_points.closest('ul').attr('id'),
        task = $(this).parents('li'),
        task_id = task.attr('id'),
        points = $(this).children(':selected').attr('value');
    if (points != show_points.text()) {
      $.ajax({
        type: "PUT",
        url: "/board/update_points",
        data: ({ task_id: task_id, points: points, division_id: division_id }),
        dataType: 'json',
        success: function(data) {
          var division_points = data.division_points;
          // update task points
          show_points.text(points);
          // update board division points
          show_points.closest('.division').find('span[id*=_points]').text(division_points);
          // update score points
          update_score_points(data.contributors, data.score);
        }
      });
    }
    $(this).fadeToggle("fast");
  });
});

// slide assignees form
$(function() {
  $(".show_assignees").click(function () {
    var task = $(this).parents('li'),
        form = task.find('.assignees_form');
    form.fadeToggle("fast");
  });
});

// slide postit options
$(function() {
  $(".postit_options").click(function () {
    var task = $(this).parents('li'),
        form = task.find('.postit_options_list');
    form.fadeToggle("fast");
  });
});

// TODO: Update the points in the board divisions and score
// change task assignees and slide back the assignees form
$(function() {
  $(".assignees_form > input").click(function () {
    var form = $(this).parents('.assignees_form'),
        show_assignees = form.siblings('.show_assignees');
        task = form.parents('li'),
        task_id = task.attr('id'),
    assignees = [];
    form.find('option:selected').each(function() {
      assignees.push($(this).attr('value'))
    });
    $.ajax({
      type: "PUT",
      url: "/board/update_assignees",
      data: ({ task_id: task_id, assignees: assignees }),
      dataType: 'json',
      success: function(data) {
        if (data.long_sentence == true) {
          show_assignees.attr('title', data.assignees_long_sentence);
        }
        else {
          show_assignees.removeClass('help_cursor');
          show_assignees.removeAttr('title');
        }
        show_assignees.text(data.assignees_sentence);
      }
    });
    form.fadeToggle("fast");
  });
});

// move the post-its between the board divisions
function movePostit (postit, ul) {
  var task_id = postit.attr('id'),
      new_position = ul.attr('id')

  postit.appendTo(ul);

  $.ajax({
    type: "PUT",
    url: "/board/update_position",
    data: ({ new_position: new_position, task_id: task_id }),
    dataType: 'json',
    success: function updateBoard(data) {
      // update divisions points
      old_division = $('#'.concat(data.old_position, '_points'));
      new_division = $('#'.concat(new_position, '_points'));
      old_division_points = parseInt(old_division.text());
      new_division_points = parseInt(new_division.text());
      new_division.text(new_division_points + data.task_points);
      old_division.text(old_division_points - data.task_points);
      // update scores
      update_score_points(data.contributors, data.score);
    }
  });
}

function defineHeight() {
  var max_line_number = 0,
      division_postit_per_line = 2,
      backlog_postit_per_line = 6,
      postit_height = $('.postit').get(0)? $('.postit').get(0).clientHeight : null,
      postit_margin = 14,
      // TODO: Make this work
      // margin_top + margin_bottom == margin * 2
      // postit_margin = $('.postit').css('margin') * 2,
      divisions = [$('#todo'), $('#doing'), $('#done')]

  // get the maximum divisions height
  $.each(divisions, function(index, division) {
    line_number = Math.ceil(division.children().length / division_postit_per_line)
    if ( line_number > max_line_number ) {
      max_line_number = line_number;
    }
  });

  // set the divisions height as the maximum height
  $.each(divisions, function(index, division) {
    division.css('height', function(index, value) {
      return max_line_number * ( postit_height + postit_margin );
    });
  });

  // set the backlog height
  backlog = $('#backlog');
  line_number = Math.ceil(backlog.children().length / backlog_postit_per_line);
  backlog.css('height', function(index, value) {
    return line_number * ( postit_height + postit_margin );
  });
}

// define the divisions and board height on page load
$(function() {
    defineHeight();
});

