# name: bookmark-route
# about: Fix bookmark-route
# version: 0.0.1
# authors: Paitoon Burapavijitnon
# url: https://github.com/yourusername/basic-plugin

enabled_site_setting :custom_bookmark_route_enabled

after_initialize do
  module ::bookmark-route
  end

  Discourse::Application.routes.append do
    post '/bookmarks' => 'bookmarks#create'
    delete '/bookmarks/:id' => 'bookmarks#destroy'
  end
end