module BoardsHelper
  def to_postit task
"<div class='postit'>
  <p class='points'>#{task.points}</p>
  #{link_to task.title, project_task_path(task.project, task), :class => :title}
  <p class='sponsor'>
    #{if task.contributors.empty?
      link_to 'Set sponsor', edit_project_task_path(task.project, task)
    else
      task.contributors.collect(&:name).to_sentence
    end}
</div>"
  end
end

