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