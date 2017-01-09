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
end
