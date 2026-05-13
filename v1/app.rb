require_relative 'task_manager'

manager = TaskManager.new

loop do
  puts "\n===== TODO LIST ====="
  puts "1. Listar tarefas"
  puts "2. Adicionar tarefa"
  puts "3. Remover tarefa"
  puts "4. Sair"

  print "\nEscolha uma opção: "

  option = gets.chomp

  case option
  when "1"
    manager.list_tasks

  when "2"
    print "Digite a tarefa: "
    task = gets.chomp
    manager.add_task(task)

  when "3"
    manager.list_tasks
    print "Digite o numero da tafera: "
    index = gets.chomp.to_i - 1
    manager.remove_tasks(index)

  when "4"
    puts "Saindo..."
    break
    
  else
    puts "Opçao invalida!"
  end
end