class Gws::Memo::MessagesController < ApplicationController
  include Gws::BaseFilter
  include Gws::CrudFilter

  model Gws::Memo::Message

  before_action :apply_recent_filters, only: [:index]
  before_action :set_item, only: [:show, :edit, :update, :delete, :destroy, :toggle_star]
  before_action :set_selected_items, only: [:destroy_all, :set_seen_all, :unset_seen_all, :set_star_all, :unset_star_all, :move_all]
  before_action :set_group_navi, only: [:index]

  def set_crumbs
    apply_recent_filters
    @crumbs << ['連絡メモ', gws_memo_messages_path ]
  end

  def set_group_navi
    @group_navi = Gws::Memo::Folder.staticItems +
        Gws::Memo::Folder.site(@cur_site).allow(:read, @cur_user, site: @cur_site)
  end

  def fix_params
    { cur_user: @cur_user, cur_site: @cur_site, from: {@cur_user.id.to_s => 'INBOX.Sent'}  }
  end

  def apply_recent_filters
    return 0 # if inbox.status.recent == 0
    #
    # counts = Webmail::Filter.user(imap.user).enabled.map do |filter|
    #   filter.imap = imap
    #   filter.apply 'INBOX', ['NEW']
    # end
    #
    # update_status
    # counts.inject(:+) || 0
  end

  def index
    direction = (params[:folder] == 'INBOX.Sent') ? 'from' : 'to'
    @items = @model.site(@cur_site).
        allow(:read, @cur_user, site: @cur_site).
        where("#{direction}.#{@cur_user.id}": params[:folder]).
        search(params[:s]).
        page(params[:page]).per(50)
  end

  def show
    raise '403' unless @item.allowed?(:read, @cur_user, site: @cur_site)
    @item.set_seen(@cur_user).update
    render
  end

  def move_all
    @items.each{ |item| item.move(@cur_user, params[:path]).update }
    render_destroy_all(false)
  end

  def set_seen_all
    @items.each{ |item| item.set_seen(@cur_user).update }
    render_destroy_all(false)
  end

  def unset_seen_all
    @items.each{ |item| item.unset_seen(@cur_user).update }
    render_destroy_all(false)
  end

  def toggle_star
    render_destroy @item.toggle_star(@cur_user).update
  end

  def set_star_all
    @items.each{ |item| item.set_star(@cur_user).update }
    render_destroy_all(false)
  end

  def unset_star_all
    @items.each{ |item| item.unset_star(@cur_user).update }
    render_destroy_all(false)
  end
end
