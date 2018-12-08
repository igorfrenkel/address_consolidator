require 'csv'

consolidate(['list1.csv', 'list2.csv'])

def consolidate(lists)
  addresses = {}
  lists = []

  lists.each do |list|
  end

  keys = addresses.keys.sort

  keys.each do |address|
    csv << [address]
  end
end

normal_addresses = {
  'ave' => 'Avenue',
  'st' => 'Street',
  'cres' => 'Crescent',
  'blvd' => 'Boulevard',
  'rd' => 'Road',
  'dr' => 'Drive',
  'gdns' => 'Gardens',
}

def normalize(address_parts)
  if address_parts.last == 'W' || address_parts.last == 'E'
    address_parts = address_parts[0..-2]
  end
end

def process(csv_file)
  CSV.open(list).for_each do |arr|
    street_number, *rest = arr
    street_name = normalize(rest)
    address = "#{street_number} #{street_name}"

    next if addresses.has_key?(address)

    addresses[address] = true
  end
end
