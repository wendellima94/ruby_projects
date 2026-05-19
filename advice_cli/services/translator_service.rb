require 'net/http'
require 'json'

class TranslatorService
  BASE_URL = "https://libretranslate.de/translate"

  def translate(text)
    uri = URI(BASE_URL)

    response = Net::HTTP.post_form(uri, {
      q: text,
      source: "en",
      target: "pt",
      format: "text"
    })

    data = JSON.parse(response.body)

    data["translatedText"]
  end
end