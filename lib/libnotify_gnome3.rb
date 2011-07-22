module Libnotify_gnome3
class Notification 
  # Creates a new libnotify notification , using the system command
  # notify-send rather than the libnotify API (see libnotify gem).
  # This allows the transient option to be set, meaning notifications
  # can dissapear after a time on GNOME3 (to stop the queuing up of 
  # notification icons as happens with the libnotify gem).
  # 
  # Semi-based upon libnotify gem
  
  # @example Block syntax
  # n = Libnotify_gnome3::Notification.new
  # n.body = "Test body"
  # n.summary = "Summary"
  # #Defaults to GNOME-provided icon
  # #notify.icon_path = "/path/to/icon/here"
  # n.urgency = "normal"
  # #Show notification
  # n.show!
  
  # @example Hash syntax
  # Libnotify_gnome3::Notification.show(:body => "hi", :summary => "test")

  attr_accessor :body, :summary, :icon_path, :urgency
  
  def initialize(options = {})
    @body = options[:body]
    @summary = options[:summary]
    @icon_path = options[:icon_path]
    @urgency = options[:urgency]
    set_defaults
  end
  
  #Sets defaults if options not passed
  def set_defaults
    @body ||= ""
    @summary ||= "Summary"
    @icon_path ||= "/usr/share/icons/gnome/scalable/emblems/emblem-default-symbolic.svg"
    @urgency ||= "normal"
  end
  
  #Calls notify-send system command
  def show!
    base = "notify-send"
    base_options = "--hint=int:transient:1"
    command = "#{base} #{base_options} --icon=#{icon_path} '#{summary}' '#{body}'"
    system(command)
  end
  
  def self.show(options = {})
    self.new(options).show!
  end
end
end