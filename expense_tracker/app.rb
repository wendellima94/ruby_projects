require_relative 'expense_manager'

manager = ExpenseManager.new

loop do
  puts "\n===== Bem vindo a sua central de gastos! ====="
  puts "1. Adicionar gasto"
  puts "2. Listar gastos"
  puts "3. Mostrar total"
  puts "4. Filtrar por categoria"
  puts "5. Mostrar maior gasto"
  puts "6. Agrupar por categoria"
  puts "7. Sair"

  print "\nEscolha uma opção: "

  option = gets.chomp

  case option
  when "1"
    print "Título: "
    title = gets.chomp

    print "Valor: "
    amount = gets.chomp.to_f

    print "Categoria: "
    category = gets.chomp

    manager.add_expense(title, amount, category)

  when "2"
    manager.list_expenses

  when "3"
    manager.total_expenses

  when "4"
    puts "\nCategorias disponíveis:"
    manager.list_categories

    print "\nEscolha o número da categoria: "

    category_index = gets.chomp.to_i - 1

    category = manager.category_by_index(category_index)

    manager.filter_by_category(category)

  when "5"
    manager.biggest_expense

  when "6"
    manager.group_by_category

  when "7"
    puts "Saindo..."
    break

  else
    puts "Opção inválida!"
  end
end