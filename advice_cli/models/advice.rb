class Advice
  attr_reader :id, :text 

  def initialize(id, text)
    @id = id
    @text = text
  end

  def to_h 
    {
      id: @id,
      text: @text
    }
  end
end
