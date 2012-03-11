module BoardsHelper

  def to_postit task
    "<li id='#{task.id}' class='postit#{category_class(task)}'>
      <p class='postit_top'>
        <span class='show_points'>#{points(task)}</span>
        #{select_for_points(task)}
        #{comments(task)}
      </p>
      #{title(task)}
      <div class='postit_bottom'>
        #{options(task)}
        <div class='assignees_block'>
          #{assignees(task)}
          <div class='assignees_form'>#{form_for_assignees(task)}</div>
        </div>
      </div>
    </li>"
  end

  def options task
    string = "<div class='postit_options_block'>"
    string += "<a class='postit_options' href='javascript:;'></a>"
    string += "<ul class='postit_options_list'>"
    string += '<li>' + link_to('edit', edit_project_task_path(task.project, task)) + '</li>'
    string += '<li>' + link_to('destroy', project_task_path(task.project, task),
                                          :confirm => 'Are you sure?',
                                          :method => :delete) + '</li>'
    string += '</ul></div>'
  end

  def select_for_points task
    string = "<select class='points_select'>"
    string += "<option value='-'>-</option>"
    Task::POINTS.each do |point|
      selected = task.points == point ? " selected='selected'" : ''
      string += "<option#{selected} value='#{point}'>#{point}</option>"
    end
    string += "</select>"
  end

  def form_for_assignees task
    string = "<select multiple='multiple' size='5'>"
    string += "<option value='-'>-</option>"
    task.project.all_contributors.each do |contributor|
      selected = task.contributors.include?(contributor) ? " selected='selected'" : ''
      string += "<option#{selected} value='#{contributor.id}'>#{contributor.username}</option>"
    end
    string += "</select>"
    string += "<input type='submit' value='ok' />"
  end

  def category_class task
    category_class = task.category.nil? ? '' : " #{task.category.name_as_css_class}"
  end

  def points task
    task.points.nil? ? '-' : task.points
  end

  def comments task
    number = task.comments.count
    return "<span class ='comments_number'>#{number} comment</span>" if number == 1
    "<span class ='comments_number'>#{number} comments</span>"
  end

  def title task
    if task.title.length > 45
      link_to truncate(task.title, :length => 45),
        project_task_path(task.project, task),
        :class => 'title help_cursor', :title => task.title
    else
      link_to task.title, project_task_path(task.project, task), :class => :title
    end
  end

  def assignees task
    return "<p class='show_assignees'>-</p>" if task.contributors.empty?

    assignees_sentence = task.contributors.collect(&:username).to_sentence

    if assignees_sentence.length > 25
      p = "p class='show_assignees' title='#{assignees_sentence}'"
    else
      p = "p class='show_assignees'"
    end

    return "<#{p}>
      #{truncate(assignees_sentence, :length => 25)}
    </p>"
  end

end

