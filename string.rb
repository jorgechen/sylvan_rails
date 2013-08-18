class String
  # 'Mr. Karate' becomes 'mr_karate'
  def file_friendly_name
    if self
      self.underscore.gsub(/[\W\.\s]/, '_')
    end
  end
end