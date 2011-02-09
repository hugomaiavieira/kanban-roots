module ApplicationHelper

  def markdown_note(item)
    "<span class='markdown_note'>
       Note: #{item} are rendered using Markdown, a lightweight markup language.
       See
       <a href='http://en.wikipedia.org/wiki/Markdown#Syntax_examples'>
         this examples</a> and
       <a href='http://daringfireball.net/projects/markdown/basics'>
         the basic usage.</a>
     </span>"
  end

end

