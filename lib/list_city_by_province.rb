require 'geonames'
require 'pp'
ITALY = 3175395
PATH = "/home/wintermute/code/"
STATE_FILE = PATH + "IT.txt"
REGIONS_FILE = PATH + "regioni.txt"

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
  f = File.open("/home/wintermute/code/Italy.txt","w+")
  puts "File Italy aperto"

  regions = Geonames::WebService.children_search( ITALY )
  puts "Elenco delle regioni ottenuto"
  #File.open("/home/wintermute/code/tmp","w+").puts(regions)
  regions.each do |region|
    f.puts("*******   Regione: " + region.name + " geoname id: " + region.geoname_id)
    provinces = Geonames::WebService.children_search( region.geoname_id.to_i )
    #pp provinces
    provinces.each do |province|
      puts "Sto smandruppando la " + province.name
      infos = greppa_stato(province.geoname_id) # greppo info sulla provincia da IT.txt cosi da avere tutti i campi (il webservice non li ritorna tutti)
      #pp infos
      f.puts( infos )
    end
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

