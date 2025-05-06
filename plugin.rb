# name: bookmark-route
# about: Fix bookmark-route
# version: 0.0.1
# authors: Paitoon Burapavijitnon
# url: https://github.com/yourusername/basic-plugin

enabled_site_setting :custom_bookmark_route_enabled

after_initialize do
  module ::BookmarkRoute
  end

  Discourse::Application.routes.append do
    get '/bookmarks' => 'list#bookmarks'
    post '/bookmarks' => 'bookmarks#create'
    delete '/bookmarks/:id' => 'bookmarks#destroy'
  end

  class BookmarksController < ApplicationController
    def index
      # ดึงข้อมูล bookmark ของ current_user
      @bookmarks = Bookmark.where(user_id: current_user.id)
  
      # รองรับทั้ง HTML และ JSON
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @bookmarks } # JSON handler
      end
    rescue StandardError => e
      # จัดการ error หากมี
      render json: { success: false, error: e.message }, status: :unprocessable_entity
    end
  end
end