require 'json'

class TaskManager
  def initialize
    @file_path = 'tasks.json'
    @tasks = load_tasks
  end

  def load_tasks
    if File.exist?(@file_path)
      file = File.read(@file_path)
      JSON.parse(file)
    else
      []
    end
  end

  def save_tasks
    File.write(@file_path, JSON.pretty_generate(@tasks))
  end

  def list_tasks
    if @tasks.empty?
      puts "Nenhuma tarefa encontrada."
      return
    end

    @tasks.each_with_index do |task, index|
      puts "#{index + 1}. #{task}"
    end
  end

  def add_task(task)
    @tasks << task
    save_tasks
    puts "Tarefa adicionada com sucesso!"
  end

  def remove_tasks(index)
    @tasks.delete_at(index)
    save_tasks
    puts "Tarefa removida!"
  end 
end

