class CategoriesController < InheritedResources::Base
  actions :all, :except => [ :show ]

  before_filter :authenticate_contributor!

  belongs_to :project
end

