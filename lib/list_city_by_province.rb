require 'geonames'
require 'pp'
EUROPE = 6255148
ITALY = 3175395
ENGLAND = 2635167
FRANCE = 3017382
GERMANY = 2921044
PATH = "/home/wintermute/code/nation-project/"
#STATE_FILE = PATH + "IT.txt"
#STATE_FILE = PATH + "FR.txt"
#OUTPUT_FILE = PATH + "Britain.txt"
#OUTPUT_FILE = PATH + "France.txt"
OUTPUT_FILE = PATH + "Germany.txt"

# Il metodo apre il file contenente tutti i punti di interesse dello stato
# e cerca un match, restituendo un array con tutti i risultati del grep
def greppa_stato( search_string, file )
  results = Array.new
  File.open( file ) do |fh|
    fh.grep( /#{search_string}/ ) do |line|
      results << line
    end
  end
  return results
end

def crea_albero_posti_online
  f = File.open( OUTPUT_FILE ,"w+")
  #regions = Geonames::WebService.children_search( ITALY )
  lev1 = Geonames::WebService.children_search( GERMANY )
  lev1.each do |item1|
    f.puts("***Livello1:\t" + item1.name + "\t" + item1.geoname_id)
    puts("***Livello1:\t" + item1.name + "\t" + item1.geoname_id)
    lev2 = Geonames::WebService.children_search( item1.geoname_id.to_i )
    lev2.each do |item2|
      #infos = greppa_stato(item2.geoname_id, STATE_FILE)
      # greppo info sulla provincia cosi da avere tutti i campi (il webservice non li ritorna tutti)
      #unless infos.empty?
      #  province_infos = infos.first.split(/\t/)
      #  name = province_infos[1]
      #  name_abbr = province_infos[11]
      #  f.puts("******Livello2:\t" + name + "\t" + name_abbr)
      #end
      f.puts("******Livello2:\t" + item2.name + "\t" + item2.geoname_id)
      lev3 = Geonames::WebService.children_search( item2.geoname_id.to_i )
      lev3.each do |item3|
        f.puts( "*******Livello3:\t" + item3.name + "\t" + item3.geoname_id)
				lev4 = Geonames::WebService.children_search( item3.geoname_id.to_i )
				lev4.each do |item4|
					f.puts( "*********Livello4:\t" + item4.name + "\t" + item4.geoname_id)
				end
      end
    end
  end
end

crea_albero_posti_online

#def crea_file_example
#  f = File.open( OUTPUT_FILE ,"w+")
#  puts "Output file aperto"
#  regions = Geonames::WebService.children_search( ITALY )
#  puts "Elenco delle regioni ottenuto"
#  region = regions.first
#  f.puts("*******Regione:\t" + region.name + "\tgeoname id:\t" + region.geoname_id)
#  provinces = Geonames::WebService.children_search( region.geoname_id.to_i )
#  province = provinces.first
#  puts "Sto elaborando\t" + province.name
#  infos = greppa_stato(province.geoname_id) # greppo info sulla provincia da IT.txt cosi da avere tutti i campi (il webservice non li ritorna tutti)
#  province_infos = infos.first.split(/\t/)
#  name = province_infos[1]
#  name_abbr1 = province_infos[11] # posizione del campo contenente la sigla della provincia
#  name_abbr2 = province_infos[9] # posizione del campo contenente la sigla della provincia
#  f.puts( name + "\t" + name_abbr1 + "\t" + name_abbr2)
#  cities = Geonames::WebService.children_search( province.geoname_id.to_i )
#
#  cities.each do |city|
#    f.puts( "Nome:\t" + city.name )
#  end
#end
## TO BE COMPLETED
#def crea_file_usando_file_stato
#  region_match = "[0-9]+\\sRegione "
#  elenco_regioni = greppa_stato(region_match)
#  #pp elenco_regioni
#  elenco_regioni.each do |regione|
#    info = regione.split(/\t/)
#    puts "Geocode id: " + info[0] + " nome: " + info[1]
#  end
#end

