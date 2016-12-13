module Cms::Addon
  module Weather
    extend ActiveSupport::Concern
    extend SS::Addon

    included do
      field :weather, type: String
      permit_params :weather

      template_variable_handler :weather, :template_variable_handler_weather
      template_variable_handler :weather_code, :template_variable_handler_weather_code
    end

    def weather_options
      [ ["晴れ", "sunny"], ["曇り", "cloudy"],
        ["雨", "rain"], ["雪", "snow"],
      ]
    end

    def template_variable_handler_weather(*args)
      ERB::Util.html_escape(label(:weather))
    end

    def template_variable_handler_weather_code(*args)
      ERB::Util.html_escape(weather)
    end
  end
end
