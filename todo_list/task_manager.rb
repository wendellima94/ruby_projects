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
      status = task["done"] ? "[Completa]" : "[Pendente]"
      puts "#{index + 1}. #{status} #{task["title"]}"
    end
  end

  def add_task(title)
    task = {
      "title" => title,
      "done" => false
    }
    @tasks << task
    save_tasks
    puts "Tarefa adicionada com sucesso!"
  end

  def remove_task(index)
    @tasks.delete_at(index)
    save_tasks
    puts "Tarefa removida!"
  end 

  def mark_done(index)
    task = @tasks[index]

    return puts "Tarefa invalida!" unless task

    task["done"] = true
    save_tasks

    puts "Tarefa concluida!"
  end
end
