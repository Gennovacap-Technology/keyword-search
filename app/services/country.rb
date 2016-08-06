class Country < Struct.new(:id, :code, :name)
  COUNTRIES = [
    self.new(2076, 'BR', 'Brazil'),
    self.new(2276, 'DE', 'Germany'),
    self.new(2840, 'US', 'United States'),
    self.new(2250, 'FR', 'France'),
    self.new(2724, 'ES', 'Spain')
  ]

  class << self
     def list
       COUNTRIES
     end

     def find_by_code code
       list.find { |country| country.code == code.upcase }
     end

     def list_with_names_and_codes
       list.map { |country| [ country.name, country.code ]}
     end
   end
end
