require 'spec_helper'

describe HTMLwithAlbino do
  before(:all) do
    @render = HTMLwithAlbino.new
    @code_text = 'puts "hello!"'
  end

  it 'should get the highlighted block code from pygments.appspot.com' do
    @render.stub(:can_pygmentize?).and_return(false)
    @render.block_code(@code_text, 'ruby').should ==
      "<div class=\"highlight\"><pre>" +
        "<span class=\"nb\">puts</span> <span class=\"s2\">&quot;hello!&quot;</span>\n" +
      "</pre></div>\n"
  end

  # XXX: This test is commented because Travis doesn't have pygments to run this
  #      integration test.
  # it 'should get the highlighted block code from local pygments' do
  #   @render.stub(:can_pygmentize?).and_return(true)
  #   @render.block_code(@code_text, 'ruby').should ==
  #     "<div class=\"highlight\"><pre>" +
  #       "<span class=\"nb\">puts</span> <span class=\"s2\">&quot;hello!&quot;</span>\n" +
  #     "</pre>\n</div>\n"
  # end
end