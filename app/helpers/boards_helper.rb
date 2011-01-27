module BoardsHelper

  def to_postit task
    "<div class='postit#{category_class(task)}'>
      <p class='top'>
        #{points(task)}
        #{comments(task)}
      </p>
      #{title(task)}
      #{sponsors(task)}
    </div>"
  end

  def category_class task
    category_class = task.category.nil? ? '' : " #{task.category.downcase}"
  end

  def points task
    if task.points.nil?
      link_to 'Set points', edit_project_task_path(task.project, task)
    else
      task.points
    end
  end

  def comments task
    number = task.comments.count
    return "<span class ='comments_number'>#{number} comment</span>" if number == 1
    "<span class ='comments_number'>#{number} comments</span>"
  end

  def title task
    link_to truncate(task.title, :length => 45),
      project_task_path(task.project, task),
      :class => :title
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

end

