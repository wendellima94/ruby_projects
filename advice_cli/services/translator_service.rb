require 'net/http'
require 'json'
require 'uri'

class TranslatorService
  BASE_URL = "https://api.mymemory.translated.net/get"

  def translate(text, target_lang = "pt")
    uri = URI(BASE_URL)

    uri.query = URI.encode_www_form({
      q: text,
      langpair: "en|#{target_lang}"
    })

    response = Net::HTTP.get_response(uri)

    body = response.body

    if body.strip.start_with?("<")
      puts "\nError."
      return text
    end

    begin
      data = JSON.parse(body)

      translated = data.dig("responseData", "translatedText")

      translated.nil? || translated.empty? ? text : translated

    rescue JSON::ParserError
      puts "\nErro na resposta da tradução."
      puts body[0..200]
      text
    end
  end
end