class AppObject
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :length => 150
  property :value, String, :length => 50
  property :numeral, Integer
end
