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
  
end