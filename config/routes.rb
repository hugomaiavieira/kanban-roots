KanbanRoots::Application.routes.draw do

  devise_for :contributors

  get 'contributors/:id/' => 'contributors#show',  :as => :contributor

  resources :teams

  resources :projects do
    resources :tasks do
      resources :comments
    end
    resources :categories
  end

  match 'teams/:id/manage_contributors' => 'teams#manage_contributors',  :as => :manage_contributors
  match 'teams/:id/manage_projects' => 'teams#manage_projects',  :as => :manage_projects
  match 'projects/:project_id/board' => 'boards#show',  :as => :project_board
  match 'projects/:project_id/clean_up_done' => 'boards#clean_up_done',  :as => :clean_up_done
  match 'board/update' => 'boards#update'

  root :to => 'contributors#home'

end

