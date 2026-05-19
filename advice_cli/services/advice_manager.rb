require 'json'
require_relative '../models/advice'

class AdviceManager
  def initialize
    @file_path = "storage/favorites.json"
    @favorites = load
  end

  def all
    @favorites
  end

  def add(advice)
    @favorites << advice
  end

  def remove(index)
    @favorites.relete_at(index)
    save  
  end

  def load
    return [] unless File.exist?(@file_path)

    file = File.read(@file_path)
    return [] if file.strip.empty?

    JSON.parse(file).map do |item|
      Advice.new(item["id", item["text"]])
    end
  end

  def save
    File.write(
      @file_path,
      JSON.pretty_generate(@favorites.map(&:to_h))
    )
  end
end