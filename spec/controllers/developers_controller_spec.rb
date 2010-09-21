require 'spec_helper'

describe DevelopersController do

  def mock_developer(stubs={})
    @mock_developer ||= mock_model(Developer, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all developers as @developers" do
      Developer.stub(:all) { [mock_developer] }
      get :index
      assigns(:developers).should eq([mock_developer])
    end
  end

  describe "GET show" do
    it "assigns the requested developer as @developer" do
      Developer.stub(:find).with("37") { mock_developer }
      get :show, :id => "37"
      assigns(:developer).should be(mock_developer)
    end
  end

  describe "GET new" do
    it "assigns a new developer as @developer" do
      Developer.stub(:new) { mock_developer }
      get :new
      assigns(:developer).should be(mock_developer)
    end
  end

  describe "GET edit" do
    it "assigns the requested developer as @developer" do
      Developer.stub(:find).with("37") { mock_developer }
      get :edit, :id => "37"
      assigns(:developer).should be(mock_developer)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created developer as @developer" do
        Developer.stub(:new).with({'these' => 'params'}) { mock_developer(:save => true) }
        post :create, :developer => {'these' => 'params'}
        assigns(:developer).should be(mock_developer)
      end

      it "redirects to the created developer" do
        Developer.stub(:new) { mock_developer(:save => true) }
        post :create, :developer => {}
        response.should redirect_to(developer_url(mock_developer))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved developer as @developer" do
        Developer.stub(:new).with({'these' => 'params'}) { mock_developer(:save => false) }
        post :create, :developer => {'these' => 'params'}
        assigns(:developer).should be(mock_developer)
      end

      it "re-renders the 'new' template" do
        Developer.stub(:new) { mock_developer(:save => false) }
        post :create, :developer => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested developer" do
        Developer.should_receive(:find).with("37") { mock_developer }
        mock_developer.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :developer => {'these' => 'params'}
      end

      it "assigns the requested developer as @developer" do
        Developer.stub(:find) { mock_developer(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:developer).should be(mock_developer)
      end

      it "redirects to the developer" do
        Developer.stub(:find) { mock_developer(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(developer_url(mock_developer))
      end
    end

    describe "with invalid params" do
      it "assigns the developer as @developer" do
        Developer.stub(:find) { mock_developer(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:developer).should be(mock_developer)
      end

      it "re-renders the 'edit' template" do
        Developer.stub(:find) { mock_developer(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested developer" do
      Developer.should_receive(:find).with("37") { mock_developer }
      mock_developer.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the developers list" do
      Developer.stub(:find) { mock_developer }
      delete :destroy, :id => "1"
      response.should redirect_to(developers_url)
    end
  end

end
