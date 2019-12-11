require 'ffi/hunspell'

class Spelly
  attr_accessor :language

  def initialize(language)
    @language = language
  end

  def spell_check(words)
    results = []
    FFI::Hunspell.dict(language) do |dict|
      words.each do |word|
        unless dict.check?(word)
          results << { word: word, suggest: dict.suggest(word) }
        end
      end
    end
    results
  end

  def stem_check(words)
    results = []
    FFI::Hunspell.dict(language) do |dict|
      words.each do |word|
        results << { word: word, stem: dict.stem(word) }
      end
    end
    results
  end
end
