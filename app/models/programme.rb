class Programme
  include ActiveAttr::Model
  include Icalendar

  attribute :pid
  attribute :title
  attribute :subtitle
  attribute :synopsis
  attribute :start_time
  attribute :end_time
  attribute :channel
  attribute :type
  attribute :image

  def self.calendar(programmes)
    @calendar = Icalendar::Calendar.new
    programmes ||= []
    programmes.each do |programme|
      event = Icalendar::Event.new
      event.start = programme.start_time.strftime("%Y%m%dT%H%M%S")
      event.end = programme.end_time.strftime("%Y%m%dT%H%M%S")
      event.summary = programme.title
      event.location = programme.channel
      event.description = programme.synopsis
      @calendar.add event
    end
    @calendar.publish
    @calendar
 end


end
