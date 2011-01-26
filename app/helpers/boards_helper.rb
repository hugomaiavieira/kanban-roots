module BoardsHelper
  def to_postit task
    category_class = task.category.nil? ? '' : " #{task.category.downcase}"
"<div class='postit#{category_class}'>
  <p class='points'>
    #{if task.points.nil?
      link_to 'Set points', edit_project_task_path(task.project, task)
    else
      task.points
    end}
  </p>
  #{link_to task.title, project_task_path(task.project, task), :class => :title}
  #{sponsors(task)}
</div>"
  end

  def sponsors task
    if task.contributors.empty?
return "<p class='sponsor'>
  #{link_to 'Set sponsor', edit_project_task_path(task.project, task)}
</p>"
    else
return "<p class='sponsor alias' title='#{task.contributors.collect(&:name).to_sentence}'>
  #{truncate(task.contributors.collect(&:name).to_sentence, :length => 25)}
</p>"
    end
  end
end

