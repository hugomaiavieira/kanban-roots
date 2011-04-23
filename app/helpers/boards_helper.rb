module BoardsHelper

  def to_postit task
    "<li id='#{task.id}' class='postit#{category_class(task)}'>
      <p class='postit_top'>
        <span class='show_points'>#{points(task)}</span>
        #{select_for_points(task)}
        #{comments(task)}
      </p>
      #{title(task)}
      <p class='postit_bottom'>
        #{sponsors(task)}
        <span class='sponsors_form'>#{form_for_sponsors(task)}</span>
      </p>
    </li>"
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

  def form_for_sponsors task
    string = "<select multiple='multiple' size='5'>"
    string += "<option value='-'>-</option>"
    task.project.contributors.each do |contributor|
      selected = task.contributors.include?(contributor) ? " selected='selected'" : ''
      string += "<option#{selected} value='#{contributor.id}'>#{contributor.username}</option>"
    end
    string += "</select>"
    string += "<input type='submit' value='ok' />"
  end

  def category_class task
    category_class = task.category.nil? ? '' : " #{task.category.to_class}"
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

  def sponsors task
    return "<span class='show_sponsors'>-</span>" if task.contributors.empty?

    sponsors_sentence = task.contributors.collect(&:username).to_sentence

    if sponsors_sentence.length > 25
      span = "span class='show_sponsors' title='#{sponsors_sentence}'"
    else
      span = "span class='show_sponsors'"
    end

    return "<#{span}>
      #{truncate(sponsors_sentence, :length => 25)}
    </span>"
  end

end

