class LinksController < ApplicationController
  def create
    link = Link.find_or_initialize_by(url: params[:url])
    if link.save
      link.update(count: link.count + 1)
      render json: link, status: 201
    else
      render json: link.errors.full_messages, status: 500
    end
  end

  def index
    @hot_links = Link.hot

    respond_to do |format| 
      format.json {render json: @hot_links}
      format.html
    end
  end
end
