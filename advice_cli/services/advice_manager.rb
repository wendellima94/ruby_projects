require 'json'
require_relative '../models/advice'

class AdviceManager
  STORAGE_DIR = "storage"
  FILE_PATH = "#{STORAGE_DIR}/favorites.json"

  def initialize
    ensure_storage_dir
    @favorites = load
  end

  def all
    @favorites
  end

  def add(advice)
    @favorites << advice
    save
  end

  def remove(index)
    return unless valid_index?(index)

    @favorites.delete_at(index)
    save
  end

  private

  def load
    return [] unless File.exist?(FILE_PATH)

    file = File.read(FILE_PATH)
    return [] if file.strip.strip.empty?

    JSON.parse(file).map do |item|
      build_advice(item)
    end
  rescue JSON::ParserError
    []
  end

  def save
    File.write(FILE_PATH, JSON.pretty_generate(@favorites.map(&:to_h)))
  end

  def valid_index?(index)
    index.between?(0, @favorites.size - 1)
  end

  def ensure_storage_dir
    Dir.mkdir(STORAGE_DIR) unless Dir.exist?(STORAGE_DIR)
  end

  def build_advice(item)
    Advice.new(item["id"], item["text"])
  end
end