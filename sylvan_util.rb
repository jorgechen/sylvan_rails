module SylvanUtil

  ##################################################
  class << self

    #@return path to first file with name, disregarding extension
    def file_path_search(dir, file_name)
      Dir.glob(File.join(dir, "#{file_name}.*")).first
    end

    # get a random record from a table
    def random_row(model)
      model.offset(rand(model.count)).first
    end

    # save a record into YAML
    def save_to_yml(record, file_location)
      f = File.open(file_location, 'w')
      f << YAML::dump(record)
      f.close
    end
  end
end
