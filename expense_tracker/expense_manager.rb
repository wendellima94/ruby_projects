require 'json'
require_relative 'expense'

class ExpenseManager
  def initialize
    @file_path = 'expenses.json'
    @expenses = load_expenses
  end

  def load_expenses
    return [] unless File.exist?(@file_path)

    file = File.read(@file_path)

    return [] if file.strip.empty?

    # JSON.parse(file)
    JSON.parse(file).map do |expense|
      Expense.new(
        expense["title"],
        expense["amount"],
        expense["category"]
      )
    end
  end

  def save_expenses
    File.write(
      @file_path,
      JSON.pretty_generate(
        @expenses.map(&:to_h)
      )
    )
  end
  
  def add_expense(title, amount, category)
    expense = Expense.new(title, amount, category)

    @expenses << expense

    save_expenses

    puts "Gasto adicionado com sucesso!"
  end

  def list_expenses
    return puts "Nenhum gasto encontrado." if @expenses.empty?

    @expenses.each_with_index do |expense, index|
      puts "#{index + 1}. #{expense.title}"
      puts "Valor: R$ #{expense.amount}"
      puts "Categoria: #{expense.category}"
      puts "-------------------------"
    end
  end

  def total_expenses
    total = @expenses.sum do |expense|
      expense.amount
    end

    puts "Total de gasto: R$ #{total}"
  end

  def filter_by_category(category)
    filtered = @expenses.select do |expense|
      expense.category.downcase == category.downcase
    end

    return puts "Nenhum gasto encontrado." if filtered.empty?

    filtered.each do |expense|
      puts "#{expense.title} - R$ #{expense.amount}"
    end
  end

  def biggest_expense
    biggest = @expenses.max_by do |expense|
      expense.amount
    end

    return puts "Nenhum gasto encontrado." unless biggest

    puts "Maior gasto:"
    puts "#{biggest["title"]} - R$ #{biggest["amount"]}"
  end

  def group_by_category
    grouped = @expenses.group_by do |expense|
      expense.category
    end

    grouped.each do |category, expenses|
      puts "\n#{category}:"

      expenses.each do |expense|
        puts "- #{expense.title} | R$ #{expense.amount}"
      end
    end
  end

  def categories
    @expenses
      .map { |expense| expense.category}
      .uniq
  end

  def list_categories
    categories.each_with_index do |category, index|
      puts "#{index + 1}. #{category}"
    end
  end

  def category_by_index(index)
    categories[index]
  end
end