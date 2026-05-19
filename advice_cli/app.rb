require_relative 'services/advice_api_client'
require_relative 'services/advice_manager'
require_relative 'services/translator_service'

client = AdviceApiClient.new
manager = AdviceManager.new
translator = TranslatorService.new

@last_results = []
@current = nil
@translation_cache = {}

def translate_cached(text, translator)
  @translation_cache[text] ||= translator.translate(text)
end

def display_advice(advice, translator)
  translated = translate_cached(advice.text, translator)

  puts "\n##{advice.id}"
  puts translated
end

loop do
  puts "\n===== ADVICE SYSTEM ====="
  puts "1. Conselho aleatório"
  puts "2. Buscar conselho"
  puts "3. Favoritar conselho"
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

    @last_results = client.search(term)

    if @last_results.empty?
      puts "Nenhum conselho encontrado."
      next
    end

    puts "\nResultados:\n"

    @last_results.each_with_index do |advice, index|
      puts "#{index + 1}. #{translate_cached(advice.text, translator)}"
    end

  when "3"
    if @last_results.empty?
      puts "Nenhuma lista carregada. Faça uma busca primeiro."
      next
    end

    puts "\nEscolha o conselho para favoritar:\n"

    @last_results.each_with_index do |advice, index|
      puts "#{index + 1}. #{translate_cached(advice.text, translator)}"
    end

    print "\nNúmero: "
    index = gets.chomp.to_i - 1

    selected = @last_results[index]

    if selected
      manager.add(selected)
      puts "Conselho favoritado!"
    else
      puts "Índice inválido."
    end

  when "4"
    favorites = manager.all

    if favorites.empty?
      puts "Nenhum favorito."
      next
    end

    favorites.each_with_index do |advice, index|
      puts "\n#{index + 1}. #{translate_cached(advice.text, translator)}"
    end

  when "5"
    favorites = manager.all

    if favorites.empty?
      puts "Nenhum favorito."
      next
    end

    favorites.each_with_index do |advice, index|
      puts "\n#{index + 1}. #{translate_cached(advice.text, translator)}"
    end

    print "\nNúmero do favorito: "
    index = gets.chomp.to_i - 1

    manager.remove(index)
    puts "Removido com sucesso."

  when "6"
    puts "Saindo..."
    break

  else
    puts "Opção inválida."
  end
end