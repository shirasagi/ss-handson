class Article::Agents::Nodes::WeatherSearchController < ApplicationController
  include Cms::NodeFilter::View
  helper Cms::ListHelper

  def index
    # 検索条件が設定されていない場合、検索画面を表示
    @weathers = params[:weathers]
    return if @weathers.blank?

    @items = Article::Page.site(@cur_site).and_public(@cur_date).
      where(@cur_node.condition_hash).
      in(weather: @weathers).
      order_by(@cur_node.sort_hash).
      page(params[:page]).
      per(@cur_node.limit)

    render_with_pagination @items
  end
end
