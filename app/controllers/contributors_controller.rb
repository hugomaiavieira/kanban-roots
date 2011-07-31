class ContributorsController < InheritedResources::Base
  actions :show

  before_filter :authenticate_contributor!

  def index
    query = "%#{params[:q]}%"
    @contributors = Contributor.where('name LIKE ? OR username LIKE ?', query, query)
    render :json => @contributors.map { |c| { :id => c.id, :name => c.name} }
  end

  def dashboard
  end
end

