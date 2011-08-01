class ContributorsController < InheritedResources::Base
  actions :show

  before_filter :authenticate_contributor!

  def index
    respond_to do |format|
      format.json do
        query = "%#{params[:q]}%"
        @contributors = Contributor.where('name LIKE ? OR username LIKE ?', query, query)
        render :json => @contributors.map { |c| { :id => c.id, :name => c.name} }
      end
    end
  end

  def dashboard
  end
end

