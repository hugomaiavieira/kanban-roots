module BoardsHelper
  def to_postit task
"<div class='postit'>
  <p class='points'>
    #{if task.points.nil?
      link_to 'Set points', edit_project_task_path(task.project, task)
    else
      task.points
    end}
  </p>
  #{link_to task.title, project_task_path(task.project, task), :class => :title}
  <p class='sponsor'>
    #{if task.contributors.empty?
      link_to 'Set sponsor', edit_project_task_path(task.project, task)
    else
      task.contributors.collect(&:name).to_sentence
    end}
  </p>
</div>"
  end
end

