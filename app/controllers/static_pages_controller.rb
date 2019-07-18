class StaticPagesController < ApplicationController

  MARKDOWN = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(
      filter_html:false,no_images:false, no_links: true, hard_wrap: true),
                                     autolink: true, tables: true)
  def home
    if(current_user&.actual_event)
      redirect_to("/#{current_user.actual_event.id}/#{current_user.actual_event.default_page_path}")
    else
      render
    end
  end

  def home_v2
    if(current_user&.actual_event)
      redirect_to("/#{current_user.actual_event.id}/#{current_user.actual_event.default_page_path}")
    else
      render
    end
  end

  def terms; end

  def privacidad; end

  #get '/:event_id/:page_path', to: 'static_pages#prepare_render'
  def prepare_render
    @content = '## Página no encontrada'
    event = Event.find(params[:event_id])
    if (event)
      pages = event.pages.select{ |page| page.path == params[:page_path]}
      unless(pages.empty?)
        @content = MarkdownEventParser.add_event_details(event, pages[0].content)
      end
    end
    @content = MARKDOWN.render(@content)
    render
  end
  
end
