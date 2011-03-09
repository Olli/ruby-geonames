
require 'geonames'
require 'pp'
ITALY = 3175395

f = File.open("/home/wintermute/code/Italy.txt","w+")

regions = Geonames::WebService.children_search( ITALY )
regions.each do |region|
  f.puts("Regione: " + region.name + " geoname id: " + region.geoname_id)
  provinces = Geonames::WebService.children_search( region.geoname_id.to_i )
  #pp provinces
  provinces.each do |province|
    f.puts(province.name)
  end
end

