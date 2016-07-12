require "json"

class CitiesSeed
  def self.states
    file_path = File.join(Rails.root, "db", "states.json")
    JSON.parse(File.open(file_path).read)
  end

  def self.run
    states.each do |state|
      state_obj = State.new(acronym: state["acronym"], name: state["name"], 
        capital: state["capital"])
      state_obj.save

      state["cities"].each do |city|
        city_obj = City.new(name: city, state: state_obj)
        city_obj.capital = city == state_obj.capital
        city_obj.save
      end
    end
  end
end