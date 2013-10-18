Devise.setup do |config|
  config.secret_key = 'f8a4ad300e77a55ab40789b363bac7caa0ca395456c0e06512ab5fd0bbad4a15360af2ac6cb48cd6738155a1ba4de929f7c0fe9e4e4b25a8b4a6a6bb3c51b7f5'

  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [ :email ]

  config.strip_whitespace_keys = [ :email ]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 10

  config.reconfirmable = true

  config.password_length = 8..128

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete

end
