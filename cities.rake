namespace :pippo do
  # invoca con rake pippo:collect
  task :put_into_db do
  end

  #task :zic_e_zac => [:collect_cities, :put_into_db] do
  #end
  task :collect do
    path = "/home/wintermute/code/Italy.txt"
    country_id = Country.find_by_name( country_name )
    #puts "dai cazzo!!"
    File.open(path).each { |line|
      m = line.match(/Regione/)
      if m
        nomi = line.split(/\t/)
        puts nomi[1]
        nome_regione = nomi[1]
        #puts m.split()[1]
        region_id = add_region(nome_regione, country_id )
      end
      m = line.match(/Provincia/)
      if m
        nomi = line.split(/\t/)
        puts nomi[1]
        nome_provincia = nomi[1]
        abbr_provincia = nomi[2]
        province_id = add_provincia(nome_provincia, abbr_provincia, region_id)
      end
      m = line.match(/Nome/) #da cambiare nello script originario?
      if m
        nomi = line.split(/\t/)
        puts nomi[1]
        nome_citta = nomi[1]
        add_city(nome_citta, province_id)
      end
    }
  end

  def add_region(nome_regione, country_id)
    r = Region.find_by_name( nome_regione )
    unless r
      r = Region.new
      r.name = nome_region
      r.country_id = country_id
      r.save!
    end
    return r.id
  end

  def add_provincia(nome, abbr, region_id)
    p = Province.find_by_abbr_name(abbr)
    unless p
      p = Province.new
      p.name = nome
      p.name_abbr = abbr
      p.stateregion_id = region_id if region_id
      p.save!
    end

    return p.id
  end

  def add_city(citta, province_id)
    c = City.find_by_name(citta)
    unless c
      c = City.new
      c.name = citta
      c.province_id = province_id if province_id
      c.save!
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
