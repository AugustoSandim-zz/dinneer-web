class City < ActiveRecord::Base
  belongs_to :state

  scope :by_state, ->(state_id) { where(state_id: state_id) }

  # def display_name
  # 	state_acronym = self.state.acronym
  # 	"#{name}/#{state_acronym.upcase}"
  # end

  def as_json(attributes = {})
  	{ id: id, name: name }
  end
end
