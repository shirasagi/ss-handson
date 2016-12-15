class Article::VideoPagesController < ApplicationController
  include Cms::BaseFilter
  include Cms::PageFilter

  model Article::VideoPage

  append_view_path "app/views/cms/pages"
  navi_view "article/main/navi"

  private
    def fix_params
      { cur_user: @cur_user, cur_site: @cur_site, cur_node: @cur_node }
    end
end
