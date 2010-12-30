module BoardsHelper

  def to_postit task
    # XXX: It is not tested!
    string=''
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
</div>"
    return string
  end

end

