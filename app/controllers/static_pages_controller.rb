class StaticPagesController < ApplicationController

  MARKDOWN = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
  def home; end

  def terms; end

  def privacidad; end

  #get '/home/:event_id/:page_path', to: 'static_pages#prepare_render'
  def prepare_render
    @content = '## Página no encontrada'
    event = Event.find(params[:event_id])
    if (event)
      pages = event.pages.select{ |page| page.path == params[:page_path]}
      unless(pages.empty?)
        @content = pages[0].content
      end
    end
    @content = MARKDOWN.render(@content)
    render
  end
  
end
