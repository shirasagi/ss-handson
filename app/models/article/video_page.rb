class Article::VideoPage
  include Cms::Model::Page
  include Cms::Page::SequencedFilename
  include Cms::Addon::Meta
  include Cms::Addon::Body
  include Article::Addon::Video
  include Cms::Addon::Release
  include Cms::Addon::ReleasePlan
  include Cms::Addon::GroupPermission

  set_permission_name "article_video_pages"

  default_scope ->{ where(route: "article/video_page") }
end
