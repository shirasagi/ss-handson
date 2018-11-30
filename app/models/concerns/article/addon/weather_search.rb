module Article::Addon
  module WeatherSearch
    extend ActiveSupport::Concern
    extend SS::Addon

    included do
      belongs_to :search_node, class_name: "Article::Node::WeatherSearch"
      permit_params :search_node_id
    end
  end
end
