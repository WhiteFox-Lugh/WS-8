module MarkdownHelper
  def markdown(text)
    unless @markdown
      options = {
        filter_html: true,
        hard_wrap: true,
        space_after_headers: true,
        with_toc_data: true,
        xhtml: true,
        lax_html_blocks: true,
        strikethrough: true,
        tables: true,
        no_intra_emphasis: true
      }
      extensions = {
        no_intra_emphasis: true,
        tables: true,
        fenced_code_blocks: true,
        autolink: true,
        quote: true
      }
      renderer = Redcarpet::Render::HTML.new(options)
      @markdown = Redcarpet::Markdown.new(renderer, extensions)
    end
    @markdown.render(text).html_safe
  end
end

