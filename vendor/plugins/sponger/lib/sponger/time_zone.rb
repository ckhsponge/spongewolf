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
  HUMAN_NAMES = HUMANS_TO_TZIDS.keys.sort
  
  def self.tzid_from_human(human)
    return HUMANS_TO_TZIDS[human]
  end

end