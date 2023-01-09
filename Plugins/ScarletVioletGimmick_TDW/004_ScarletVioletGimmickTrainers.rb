class NPCTrainer < Trainer
  attr_accessor :teraIndex

  alias tdwtrainerinit initialize
  def initialize(name, trainer_type)
    tdwtrainerinit(name, trainer_type)
    @teraIndex     = -5
  end
  
  def teraIndex=(i)
	@teraIndex = i
  end

  def teraIndexForceType(type,index=-5)
	index = @teraIndex if @teraIndex >= 0
	self.party[index].tera_type = [type] if index >= 0
  end
  
end