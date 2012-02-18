module ApplicationHelper
  # TODO: Test it!
  def li_link_to label, path
    if request.fullpath == path
      return "<li class='active'>#{link_to(label, path)}</li>".html_safe
    else
      return "<li>#{link_to(label, path)}</li>".html_safe
    end
  end

  def markdown_note(item)
    "Note: #{item} are rendered using
     <a href='http://github.github.com/github-flavored-markdown/'>
       GitHub Flavored Markdown
     </a>"
  end

  # TODO: Test it!
  def gravatar_image_tag(user, options={})
    options.reverse_merge!(:size => 24, :class => '')
    if Rails.env.production?
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      url = "http://gravatar.com/avatar/#{gravatar_id}?d=mm&s=#{options[:size]}"
      image_tag(url,
                :class => "avatar #{options[:class]}",
                :height => options[:size],
                :width => options[:size]).html_safe
    else
      image_tag('gravatar.png',
                :class => "avatar #{options[:class]}",
                :height => options[:size],
                :width => options[:size]).html_safe
    end
  end

  # TODO: Test it!
  def markdown(text)
    render = HTMLwithAlbino.new(:filter_html => true, :hard_wrap => true)
    options = {:autolink => true, :no_intra_emphasis => true, :fenced_code_blocks => true}
    md = Redcarpet::Markdown.new(render, options)
    md.render(text).html_safe
  end
end

# TODO: Test it!
# create a custom renderer that allows highlighting of code blocks
class HTMLwithAlbino < Redcarpet::Render::HTML
  def block_code(code, lang)
    lang = sanitaze_lang(lang)

    if can_pygmentize?
      Albino.colorize(code, lang)
    else
      # This is a hack for pygments work on Heroku
      require 'net/http'
      Net::HTTP.post_form(URI.parse('http://pygments.appspot.com/'),
                          {'code'=>code, 'lang'=>lang}).body
    end
  end

  private

  def can_pygmentize?
    system 'pygmentize -V'
  end

  # Sanitize the language highlighting to not raise an error if used github code
  # block style (~~~.lang). This is based on Albino valid options.
  # http://rubydoc.info/gems/albino/1.3.3/Albino#convert_options-instance_method
  def sanitaze_lang(lang)
    lang.scan(/[a-z0-9\-\_\+\=\#\,\s]+/i).join
  end
end