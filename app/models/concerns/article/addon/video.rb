module Article::Addon
  module Video
    extend ActiveSupport::Concern
    extend SS::Addon

    included do
      field :video_id, type: String
      permit_params :video_id
    end
  end
end
