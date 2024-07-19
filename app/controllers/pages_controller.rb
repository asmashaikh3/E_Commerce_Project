class PagesController < ApplicationController
    def show
      @page = Page.find_by(title: params[:title])
      if @page
        render :show
      else
        render :page_not_found
      end
    end
  end
  