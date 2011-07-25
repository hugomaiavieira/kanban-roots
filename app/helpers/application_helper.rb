module ApplicationHelper

  def markdown_note(item)
    "<span class='markdown_note'>
       Note: #{item} are rendered using
       <a href='http://github.github.com/github-flavored-markdown/'>
         GitHub Flavored Markdown
       </a>
     </span>"
  end

end

