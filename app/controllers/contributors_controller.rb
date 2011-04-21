class ContributorsController < InheritedResources::Base
  actions :show

  before_filter :authenticate_contributor!

  def dashboard
  end
end

