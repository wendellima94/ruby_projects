class Expense 
  attr_reader :title, :amount, :category
  
  def initialize (title, amount, category)
    @title = title
    @amount = amount
    @category = category
  end

  def to_h
    {
      title: @title,
      amount: @amount,
      category: @category
    }
  end
end

