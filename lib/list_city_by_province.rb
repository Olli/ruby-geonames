require 'geonames'
require 'pp'
ITALY = 3175395
ENGLAND = 2635167
PATH = "/home/wintermute/code/"
#STATE_FILE = PATH + "IT.txt"
STATE_FILE = PATH + "GB.txt"
OUTPUT_FILE = PATH + "Britain.txt"

# Il metodo apre il file contenente tutti i punti di interesse dello stato
# e cerca un match, restituendo un array con tutti i risultati del grep
def greppa_stato( search_string )
  results = Array.new
  File.open( STATE_FILE ) do |fh|
    fh.grep( /#{search_string}/ ) do |line|
      results << line
    end
  end
  return results
end

def crea_file_stato_online
  f = File.open( OUTPUT_FILE ,"w+")
  puts "Output file aperto"

  #regions = Geonames::WebService.children_search( ITALY )
  regions = Geonames::WebService.children_search( ENGLAND )
  puts "Elenco delle regioni ottenuto"
  regions.each do |region|
    f.puts("*******Regione:\t" + region.name + "\t" + region.geoname_id)
    provinces = Geonames::WebService.children_search( region.geoname_id.to_i )
    #f.puts(provinces)
    provinces.each do |province|
      puts "Sto elaborando " + province.name + "\t" + province.geoname_id

      #infos = greppa_stato(province.geoname_id)
      #f.puts infos if infos
      # greppo info sulla provincia cosi da avere tutti i campi (il webservice non li ritorna tutti)
      #if infos
      #  province_infos = infos.first.split(/\t/)
      #  name = province_infos[1]
      #  name_abbr = province_infos[11]
      #  f.puts("******Provincia:\t" + name + "\t" + name_abbr)
      #else
        f.puts("******Provincia:\t" + province.name)
        f.puts(province)
      #end
      cities = Geonames::WebService.children_search( province.geoname_id.to_i )
      cities.each do |city|
        f.puts( "Nome:\t" + city.name )
      end
    end
  end
end

def crea_file_example
  f = File.open( OUTPUT_FILE ,"w+")
  puts "Output file aperto"
  regions = Geonames::WebService.children_search( ITALY )
  puts "Elenco delle regioni ottenuto"
  region = regions.first
  f.puts("*******   Regione: " + region.name + " geoname id: " + region.geoname_id)
  provinces = Geonames::WebService.children_search( region.geoname_id.to_i )
  province = provinces.first
  puts "Sto elaborando " + province.name
  infos = greppa_stato(province.geoname_id) # greppo info sulla provincia da IT.txt cosi da avere tutti i campi (il webservice non li ritorna tutti)
  province_infos = infos.first.split(/\t/)
  name = province_infos[1]
  name_abbr = province_infos[11] # posizione del campo contenente la sigla della provincia
  f.puts( name + "  " + name_abbr)
  cities = Geonames::WebService.children_search( province.geoname_id.to_i )

  cities.each do |city|
    f.puts( "Nome: " + city.name )
  end
end
# TO BE COMPLETED
def crea_file_usando_file_stato
  region_match = "[0-9]+\\sRegione "
  elenco_regioni = greppa_stato(region_match)
  #pp elenco_regioni
  elenco_regioni.each do |regione|
    info = regione.split(/\t/)
    puts "Geocode id: " + info[0] + " nome: " + info[1]
  end
end

crea_file_stato_online
#crea_file_usando_file_stato

