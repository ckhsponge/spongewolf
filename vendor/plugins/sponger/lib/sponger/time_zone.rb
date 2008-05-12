class Sponger::TimeZone < Sponger::Resource

  HUMANS_TO_TZIDS = {
  'Yankee Time Zone'=>'Etc/UTC-1200',
  'Samoa'=>'Etc/UTC-1100',
  'Hawaii-Aleutian Standard Time'=>'Etc/UTC-1000',
  'Alaska Standard Time'=>'Etc/UTC-0900',
  'Pacific Standard Time'=>'Etc/UTC-0800',
  'Mountain Standard Time'=>'Etc/UTC-0700',
  'Central Standard Time'=>'Etc/UTC-0600',
  'Eastern Standard Time'=>'Etc/UTC-0500',
  'Caracas'=>'Etc/UTC-0400',
  'Newfoundland'=>'America/St_Johns',
  'Buenos Aires'=>'Etc/UTC-0300',
  'Mid-Atlantic'=>'Etc/UTC-0200',
  'Cape Verde Is.'=>'Etc/UTC-0100',
  'Greenwich Mean Time'=>'Etc/UTC',
  'Central European Time'=>'Etc/UTC+0100',
  'Pretoria'=>'Etc/UTC+0200',
  'Nairobi'=>'Etc/UTC+0300',
  'Abu Dhabi'=>'Etc/UTC+0400',
  'Islamabad'=>'Etc/UTC+0500',
  'Dhaka'=>'Etc/UTC+0600',
  'Bangkok'=>'Etc/UTC+0700',
  'Singapore'=>'Etc/UTC+0800',
  'Tokyo'=>'Etc/UTC+0900',
  'Adelaide'=>'Australia/Darwin',
  'Guam'=>'Etc/UTC+1000',
  'Lord Howe'=>'Australia/Lord_Howe',
  'New Caledonia'=>'Etc/UTC+1100',
  'Norfolk'=>'Pacific/Norfolk',
  'Fiji'=>'Etc/UTC+1200',
  'Honolulu'=>'America/Honolulu',
  'Anchorage'=>'America/Anchorage',
  'Los Angeles'=>'America/Los_Angeles',
  'Phoenix'=>'America/Phoenix',
  'Denver'=>'America/Denver',
  'Chicago'=>'America/Chicago',
  'New York'=>'America/New_York',
  'Indianapolis'=>'America/Indianapolis',
  'Auckland'=>'Pacific/Auckland',
  'Sydney'=>'Australia/Sydney',
  'London'=>'Europe/London',
  'Rome'=>'Europe/Rome'
  }
  HUMAN_NAMES = [
    '(GMT-11:00) Samoa',
    '(GMT-10:00) Honolulu',
    '(GMT-09:00) Anchorage',
    '(GMT-08:00) Los Angeles',
    '(GMT-07:00) Phoenix',
    '(GMT-07:00) Denver',
    '(GMT-06:00) Chicago',
    '(GMT-05:00) New York',
    '(GMT-04:00) Caracas',
    '(GMT-03:30) Newfoundland',
    '(GMT-03:00) Buenos Aires',
    '(GMT-02:00) Mid-Atlantic',
    '(GMT-01:00) Cape Verde Is.',
    '(GMT-00:00) London',
    '(GMT+01:00) Rome',
    '(GMT+02:00) Pretoria',
    '(GMT+03:00) Nairobi',
    '(GMT+04:00) Abu Dhabi',
    '(GMT+05:00) Islamabad',
    '(GMT+06:00) Dhaka',
    '(GMT+07:00) Bangkok',
    '(GMT+08:00) Singapore',
    '(GMT+09:00) Tokyo',
    '(GMT+09:30) Adelaide',
    '(GMT+10:00) Sydney',
    '(GMT+10:30) Lord Howe',
    '(GMT+11:00) New Caledonia',
    '(GMT+11:30) Norfolk',
    '(GMT+12:00) Auckland'
  ]
  
  def self.tzid_from_human(human)
    tzid = HUMANS_TO_TZIDS[human.sub(/\(GMT(\+|\-)\d\d\:\d\d\)\s/,'')]
    raise "tzid not found" unless tzid
    tzid
  end
  
  
  def self.options_for_select
    @@options_for_select ||= nil
    return @@options_for_select if @@options_for_select 
    @@options_for_select = []
    HUMAN_NAMES.each{ |n| @@options_for_select << [n, n.gsub(/\(GMT(\+|\-)\d\d\:\d\d\)\s/,'')]}
    @@options_for_select
  end

end