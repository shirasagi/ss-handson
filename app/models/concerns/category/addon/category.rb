module Category::Addon
  module Category
    extend SS::Addon
    extend ActiveSupport::Concern

    included do
      field :category_upper_html, type: String
      field :category_lower_html, type: String
      permit_params :category_upper_html, :category_lower_html
    end
  end
end
