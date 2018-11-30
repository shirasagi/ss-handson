module Article::Addon
  module Video
    extend ActiveSupport::Concern
    extend SS::Addon

    included do
      field :video_id, type: String
      field :width, type: Integer
      field :height, type: Integer
      permit_params :video_id, :width, :height
    end
  end
end
