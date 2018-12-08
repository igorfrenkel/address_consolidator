require 'csv'

def consolidate(csv_files)
  addresses = {}
  lists = []

  csv_files.each do |csv_file|
    process(csv_file, addresses)
  end

  address_parts = addresses.values.sort { |a,b| [a[1], a[0]] <=> [b[1], b[0]] }
  address_parts.each do |address|
    puts address.join(" ")
  end
end

def normalize(address_parts)
  normal_addresses = {
    'ave' => 'Avenue',
    'st' => 'Street',
    'cres' => 'Crescent',
    'blvd' => 'Boulevard',
    'rd' => 'Road',
    'dr' => 'Drive',
    'gdns' => 'Gardens',
  }

  directions = { 'e' => true, 'w' => true, 'east' => true, 'west' => true }

  address_parts = address_parts[0].split(" ")

  if directions[address_parts.last.downcase]
    address_parts = address_parts[0..-2]
  end

  converted_part = normal_addresses[address_parts.last.downcase]
  if converted_part
    address_parts[-1] = converted_part
  end

  return address_parts.join(" ")
end

def process(csv_file, addresses)
  CSV.foreach(csv_file) do |arr|
    arr = arr.reject { |item| item.nil? }
    street_number, *rest = arr
    street_name = normalize(rest)
    address = "#{street_number} #{street_name}"

    next if addresses.has_key?(address)

    addresses[address] = [street_number, street_name]
  end
end

consolidate(['data/1.csv', 'data/2.csv'])
