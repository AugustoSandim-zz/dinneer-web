Dir["#{Rails.root}/db/*_seed.rb"].each { |file| require file }

if City.first.blank?
	CitiesSeed.run
end
