class MetaController < ApplicationController

  def index
  end

  def root
   @people = ::Juicer.trending_people
   @max_score = @people.first.cooccurence_count
   @page_title = 'People'
   render 'profiles/index'
  end

  def chrome
  end

  def chrome_extension
    send_file "#{Rails.root}/public/people.crx"
  end
end
