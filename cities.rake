namespace :pippo do
  # invoca con rake pippo:collect
  task :put_into_db do
  end

  #task :zic_e_zac => [:collect_cities, :put_into_db] do
  #end
  task :collect do
    path = "/home/wintermute/code/Italy.txt"
    puts "dai cazzo!!"
    File.open(path).each { |line|
      #line.match(/Regione:/) {|m| puts m}
      m = line.match(/Regione/)
      if m
        nomi = line.split(/\t/)
        puts nomi[1]
        #puts m.split()[1]
      end
      #linea_splittata = line.split()
      #puts(linea_splittata[0])

    }
  end


  #File.open(DOCNAME).each { |line|
  #  splitted_line = line.split(/\t/)
  #  if splitted_line[C_tab::COUNTRY_CODE] == "IT"
  #    outfile.puts(splitted_line[C_tab::NAME])
  #  end
  #}
end
