module Webmail
  class Initializer
    SS::User.include Webmail::UserExtension
    Cms::User.include Webmail::UserExtension
    Gws::User.include Webmail::UserExtension
  end
end
