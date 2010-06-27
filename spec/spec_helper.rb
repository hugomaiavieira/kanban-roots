ENV["RAILS_ENV"] ||= 'test'
require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
require 'spec/autorun'
require 'spec/rails'
require 'remarkable_rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

Spec::Runner.configure do |config|

  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

  def current_user(stubs = {})
    return @current_user if @current_user

    roles = (stubs.delete(:roles) || {}).symbolize_keys
    @current_user = stub_model(Usuario, stubs.merge(:roles => roles))

    def @current_user.has_role?(role, object=nil)
      result = !! if object.nil?
        roles.has_key?(role.to_sym)
      else
        roles[role.to_sym] == object
      end

      result
    end

    def @current_user.has_no_roles!
      roles = {}
    end

    def @current_user.has_role!(role, object=nil)
      roles[role] = object
    end

    @current_user
  end

  def user_session(stubs = {}, user_stubs = {})
    user = current_user(user_stubs)
    @current_user_session ||= mock_model(UsuarioSession, {:record => user, :user => user}.merge(stubs))
  end

  def login(session_stubs = {}, user_stubs = {})
    UsuarioSession.stub!(:find).and_return(user_session(session_stubs, user_stubs))
  end

  def logout
    @current_user = nil
    @user_session = nil
  end

end

