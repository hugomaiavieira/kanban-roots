# from http://openhood.com/rack/ruby/2010/07/15/rack-test-warning/

module Rack
  module Utils
    def escape(s)
      EscapeUtils.escape_url(s)
    end
  end
end

