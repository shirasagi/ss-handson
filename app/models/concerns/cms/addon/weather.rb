module Cms::Addon
  module Weather
    extend ActiveSupport::Concern
    extend SS::Addon

    included do
      field :weather, type: String
      permit_params :weather
    end

    def weather_options
      %w(sunny cloudy rain snow).map do |v|
        [ I18n.t("cms.options.weather.#{v}"), v ]
      end
    end
  end
end
