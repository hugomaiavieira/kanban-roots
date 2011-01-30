class CategoriesController < InheritedResources::Base
  before_filter :authenticate_contributor!

  belongs_to :project
end

