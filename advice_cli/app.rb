require_relative 'services/advice_api_client'
require_relative 'services/advice_manager'
require_relative 'services/translator_service'

client = AdviceApiClient.new
manager = AdviceManager.new
translator = TranslatorService.new

def display_advice(advice, translator)
  translated = translator.translate(advice.text)

  puts "\n##{advice.id}"
  puts translated
end

loop do
  puts "\n===== ADVICE SYSTEM ====="
  puts "1. Conselho aleatório"
  puts "2. Buscar conselho"
  puts "3. Favoritar conselho atual"
  puts "4. Listar favoritos"
  puts "5. Remover favorito"
  puts "6. Sair"

  print "\nEscolha: "

  option = gets.chomp

  case option
  when "1"
    @current = client.random

    display_advice(@current, translator)

  when "2"
    print "Termo: "

    term = gets.chomp

    results = client.search(term)

    if results.empty?
      puts "Nenhum conselho encontrado."
      next
    end

    results.each_with_index do |advice, index|
      translated = translator.translate(advice.text)

      puts "\n#{index + 1}."
      puts translated
    end

  when "3"
    if @current
      manager.add(@current)

      puts "Conselho favoritado!"
    else
      puts "Nenhum conselho carregado."
    end

  when "4"
    favorites = manager.all

    if favorites.empty?
      puts "Nenhum favorito encontrado."
      next
    end

    favorites.each_with_index do |advice, index|
      translated = translator.translate(advice.text)

      puts "\n#{index + 1}."
      puts translated
    end

  when "5"
    favorites = manager.all

    if favorites.empty?
      puts "Nenhum favorito encontrado."
      next
    end

    favorites.each_with_index do |advice, index|
      translated = translator.translate(advice.text)

      puts "\n#{index + 1}."
      puts translated
    end

    print "\nNúmero do favorito: "

    index = gets.chomp.to_i - 1

    manager.remove(index)

    puts "Favorito removido."

  when "6"
    puts "Saindo..."
    break

  else
    puts "Opção inválida."
  end
end