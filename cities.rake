namespace :pippo do
  # invoca con rake pippo:collect
  country_name = "Italy"
  task :collect => :environment do
    path = "/home/wintermute/code/Italy.txt"
    country = Country.find_by_name( country_name )
    puts "country id:\t" + country.id.to_s if country

    File.open(path).each { |line|
      m = line.match(/Regione/)
      if m
        nomi = line.split(/\t/)
        #puts "Nome regione:\t" + nomi[1]
        nome_regione = nomi[1].chomp
        region_id = add_region(nome_regione, country.id )
      end
      m = line.match(/Provincia/)
      if m
        nomi = line.split(/\t/)
        #puts "Nome provincia:\t" + nomi[1]
        nome_provincia = nomi[1].chomp
        abbr_provincia = nomi[2].chomp
        province_id = add_provincia(nome_provincia, abbr_provincia, region_id)
      end
      m = line.match(/Nome/) #da cambiare nello script originario?
      if m
        nomi = line.split(/\t/)
        #puts "Nome citta:\t" + nomi[1].chomp 
        nome_citta = nomi[1].chomp
        add_city(nome_citta, province_id)
      end
    }
  end

  def add_region(nome_regione, country_id)
    r = Stateregion.find_by_name( nome_regione )
    if r
      #puts "Region exists:\t" + r.name + "\t" + r.id.to_s
    else
      r = Stateregion.new
      r.name = nome_regione
      r.country_id = country_id
      #r.save!
      puts "Region would be created:\t" + nome_regione
    end
    return r.id
  end

  def add_provincia(nome, abbr, region_id)
    p = Province.find_by_name_abbr(abbr)
    if p
      #puts "Province exists:\t" + p.name + "\t" + p.id.to_s
    else
      p = Province.new
      p.name = nome
      p.name_abbr = abbr
      p.stateregion_id = region_id if region_id
      #p.save!
      puts "Province would be created:\t" + nome
    end

    return p.id
  end

  def add_city(citta, province_id)
    c = City.find_by_name(citta)
    if c
      #puts "City exists:\t" + c.name + "\t" + c.id.to_s
    else
      c = City.new
      c.name = citta
      c.province_id = province_id if province_id
      puts "City would be created:\t" + citta + "\t" + c.id.to_s
      #c.save!
    end

    return c.id
  end


  #File.open(DOCNAME).each { |line|
  #  splitted_line = line.split(/\t/)
  #  if splitted_line[C_tab::COUNTRY_CODE] == "IT"
  #    outfile.puts(splitted_line[C_tab::NAME])
  #  end
  #}
end
