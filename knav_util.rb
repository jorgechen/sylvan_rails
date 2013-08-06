module KnavUtil

  ############################## Rails Model ##############################

  # this returns a hash with only keys that match given model's attributes
  def self.retrieve_model_attributes(model_instance, hash)
    hash.reject{ |k,v| !model_instance.attributes.keys.member?(k.to_s) }
  end

  ############################## String manipulation ##############################
  # 'Mr. Karate' becomes 'mr_karate'
  def self.convert_to_file_friendly_name(name)
    if name
      incinerate_non_words name.delete('.').underscore.gsub(' ', '_') #NOTE: order of function calls matter
    end
  end

  # NOTE: words have letters, underscores, digits
  def self.incinerate_non_words(string)
    string.gsub(/\W/,'')
  end

  # before:  {a: nil, s: '', b: 3, c: nil, d: 9939, nil => 1}
  # after:   {:s=>"", :b=>3, :d=>9939}
  def self.incinerate_nils_in_hash(hash)
    hash.delete_if {|k, v| !k or !v}
  end

  # print phrases such that there is proper fillers that follow
  def self.print_with_padding(content, fill = '_', fill_length = 60)
    puts
    puts content.to_s.ljust(fill_length, fill)
  end

  ############################## Hash ##############################

  # hash_from: {:id=>1, :name=>"Abe Lincoln", :acronym=>"AL"}   hash_to: {}
  # hash_from: {:id=>1, :name=>"Abe Lincoln", :acronym=>"AL"}   hash_to: {:id=>1, :name=>"Abe Lincoln", :acronym=>"AL"}
  def self.transfer_hash_values(hash_from, hash_to, keys = [])
    # if keys list is nil, then transfer everything
    if keys and not keys.empty?
      hash_from.each do |k, v|
        hash_to[k] = v
      end
    else
      # transfer only specified keys
      keys.each do |k|
        hash_to[k] = hash_from[k]
      end
    end
  end


  # Reference   http://stackoverflow.com/a/4157635/982802
  def self.deep_copy(obj)
    Marshal.load(Marshal.dump(obj))
  end

  #NOTE: this returns nothing if too many File objects are not closed!!!
  #@return path if the file path is valid (case insensitive), or nil if not found
  def self.find_and_verify_file_path(tentative_path)
    Dir.glob( tentative_path, File::FNM_CASEFOLD ).first
  end

  #@return the result of a query directly to the database database
  def self.direct_sql_query(query)
    ActiveRecord::Base.connection.execute(query)
  end

end
