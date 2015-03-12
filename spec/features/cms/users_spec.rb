require 'spec_helper'

describe "cms_users" do
  subject(:site) { cms_site }
  subject(:item) { Cms::User.last }
  subject(:index_path) { cms_users_path site.host }
  subject(:new_path) { new_cms_user_path site.host }
  subject(:show_path) { cms_user_path site.host, item }
  subject(:edit_path) { edit_cms_user_path site.host, item }
  subject(:delete_path) { delete_cms_user_path site.host, item }

  it "without login" do
    visit index_path
    expect(current_path).to eq sns_login_path
  end

  it "without auth" do
    login_ss_user
    visit index_path
    expect(status_code).to eq 403
  end

  context "with auth" do
    before { login_cms_user }

    it "#index" do
      visit index_path
      expect(current_path).not_to eq sns_login_path
    end

    context "with sns user" do
      it "#new" do
        visit new_path
        within "form#item-form" do
          name = unique_id
          fill_in "item[name]", with: name
          fill_in "item[email]", with: "#{name}@example.jp"
          fill_in "item[in_password]", with: "pass"
          check "item[group_ids][]"
          check "item[cms_role_ids][]"
          click_button "保存"
        end
        expect(status_code).to eq 200
        expect(current_path).not_to eq new_path
        expect(page).not_to have_css("form#item-form")
      end

      it "#show" do
        visit show_path
        expect(status_code).to eq 200
        expect(current_path).not_to eq sns_login_path
      end

      it "#edit" do
        visit edit_path
        within "form#item-form" do
          fill_in "item[name]", with: "modify"
          click_button "保存"
        end
        expect(status_code).to eq 200
        expect(current_path).not_to eq sns_login_path
        expect(page).not_to have_css("form#item-form")
      end

      it "#delete" do
        visit delete_path
        within "form" do
          click_button "削除"
        end
        expect(status_code).to eq 200
        expect(current_path).to eq index_path
      end
    end

    context "with ldap user" do
      it "#new" do
        visit new_path
        within "form#item-form" do
          name = unique_id
          fill_in "item[name]", with: name
          fill_in "item[in_uid]", with: name
          fill_in "item[ldap_dn]", with: "dc=#{name},dc=city,dc=example,dc=jp"
          check "item[group_ids][]"
          check "item[cms_role_ids][]"
          click_button "保存"
        end
        expect(status_code).to eq 200
        expect(current_path).not_to eq new_path
        expect(page).not_to have_css("form#item-form")
      end

      it "#show" do
        visit show_path
        expect(status_code).to eq 200
        expect(current_path).not_to eq sns_login_path
      end

      it "#edit" do
        visit edit_path
        within "form#item-form" do
          fill_in "item[name]", with: "modify"
          click_button "保存"
        end
        expect(status_code).to eq 200
        expect(current_path).not_to eq sns_login_path
        expect(page).not_to have_css("form#item-form")
      end

      it "#delete" do
        visit delete_path
        within "form" do
          click_button "削除"
        end
        expect(status_code).to eq 200
        expect(current_path).to eq index_path
      end
    end
  end
end
