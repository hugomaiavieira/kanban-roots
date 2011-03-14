module BoardsHelper

  def to_postit task
    "<li class='postit#{category_class(task)}'>
      <p class='top'>
        <span class='points'>#{points(task)}</span>
        #{comments(task)}
      </p>
      #{title(task)}
      #{sponsors(task)}
    </li>"
  end

  def category_class task
    category_class = task.category.nil? ? '' : " #{task.category.to_class}"
  end

  def points task
    if task.points.nil?
      link_to 'Set points', edit_project_task_path(task.project, task)
    else
      task.points
    end
  end

  def comments task
    "<span class ='comments_number'>#{task.comments.count}</span>"
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

  def sponsors task
    if task.contributors.empty?
      return "<p class='sponsor'>
        #{link_to 'Set sponsor', edit_project_task_path(task.project, task)}
      </p>"
    end

    sponsors_sentence = task.contributors.collect(&:name).to_sentence

    if sponsors_sentence.length > 25
      p = "p class='sponsor help_cursor' title='#{sponsors_sentence}'"
    else
      p = "p class='sponsor'"
    end

    return "<#{p}>
      #{truncate(sponsors_sentence, :length => 25)}
    </p>"
  end

  def my_projects
    projects = current_contributor.projects.sort
    str=''
    projects.each do |project|
      unless project == @project
        str += link_to project.name, project_board_path(project)
        str += ' | '
      end
    end
    str[0..-4].html_safe
  end

end

