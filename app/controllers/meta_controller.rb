class MetaController < ApplicationController
  def chrome
  end

  def chrome_extension
    send_file "#{Rails.root}/public/people.crx"
  end
end
