module BoardsHelper

  def postit position
    # XXX: This awful code at is just temporary, until the drag and drop come
    #      in the scene. It is not tested!
    task = ((@tasks.collect { |item| item if item.position == position }).compact).first
    string=''
    if task
      string=
"<div class='postit'>
  <p class='points'>#{task.points}</p>
  #{link_to task.title, project_task_path(@project, task), :class => :title}
  <p class='sponsor'>
    #{if task.contributors.empty?
      link_to 'Set sponsor', edit_project_task_path(@project, task)
    else
      task.contributors.collect(&:name).to_sentence
    end}
  </p>
</div>"
      task = @tasks.delete_if { |item| item == task }
    end
    return string
  end

end

