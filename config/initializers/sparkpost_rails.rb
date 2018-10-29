# frozen_string_literal: true
#referencia https://github.com/the-refinery/sparkpost_rails
#def self.configure
#    self.configuration ||= Configuration.new
#    yield(configuration)
#end
SparkPostRails.configure do |c|
  c.api_key = ENV["SPARKPOST_API_KEY"]
  #c.sandbox = true                                # default: false
  #c.track_opens = true                            # default: false
  #c.track_clicks = true                           # default: false
  #c.return_path = ENV["SPARKPOST_REMETENTE_EMAIL"]		   # default: nil
  #c.campaign_id = 'YOUR-CAMPAIGN'                 # default: nil
  #c.transactional = true                          # default: false
  #c.ip_pool = "MY-POOL"                           # default: nil
  #c.inline_css = true                             # default: false
  #c.html_content_only = true                      # default: false
  #c.subaccount = "123"                            # default: nil
end
