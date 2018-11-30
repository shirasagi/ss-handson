class Article::VideoPage
  include Cms::Model::Page
  include Cms::Page::SequencedFilename
  include Cms::Addon::Meta
  include Cms::Addon::Body
  include Article::Addon::Video
  include Cms::Addon::ParentCrumb
  include Event::Addon::Date
  include Map::Addon::Page
  include Cms::Addon::RelatedPage
  include Contact::Addon::Page
  include Cms::Addon::Tag
  include Cms::Addon::Release
  include Cms::Addon::ReleasePlan
  include Cms::Addon::GroupPermission
  include History::Addon::Backup

  set_permission_name "article_video_pages"

  default_scope ->{ where(route: "article/video_page") }
end
