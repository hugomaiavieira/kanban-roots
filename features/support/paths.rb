module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'

    when /the project edit page/
      edit_project_path(@project)

    when /the projects board page/
      project_board_path(@project)

    when /my details page/
      contributor_path(@contributor)

    when /the new contributor page/
      new_contributor_registration_path

    when /the task edit page/
      edit_project_task_path(@project, @task)

    when /^the (.*) tasks page$/i
      project_tasks_path(@project)

    when /the task page/
      project_task_path(@project, @task)

    when /the team page/
      team_path(@team)

    when /the sign in page/
      new_contributor_session_path

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)

