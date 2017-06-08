# 指定河川洪水予報
class Jmaxml::Trigger::FloodForecast < Jmaxml::Trigger::Base
  include Jmaxml::Addon::Trigger::FloodForecast

  def verify(page, context, &block)
    control_title = REXML::XPath.first(context.xmldoc, '/Report/Control/Title/text()').to_s.strip
    return false unless control_title.start_with?('指定河川洪水予報')

    control_status = REXML::XPath.first(context.xmldoc, '/Report/Control/Status/text()').to_s.strip
    return false unless weather_xml_status_enabled?(control_status)

    return false unless fresh_xml?(page, context)

    area_codes = extract_area_codes(context.site, context.xmldoc)
    return false if area_codes.blank?

    context[:type] = Jmaxml::Type::FLOOD
    context[:area_codes] = area_codes

    return true unless block_given?

    yield
  end

  private
  def extract_area_codes(site, xmldoc)
    area_codes = []
    REXML::XPath.match(xmldoc, '/Report/Body/Warning[@type="指定河川洪水予報"]/Item/Stations/Station').each do |station|
      area_code = REXML::XPath.first(station, 'Code[@type="水位観測所"]/text()').to_s.strip
      region = target_regions.site(site).where(code: area_code).first
      next if region.blank?

      area_codes << area_code
    end
    area_codes.sort
  end
end
