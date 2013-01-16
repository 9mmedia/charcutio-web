require 'yaml'

module MeatMarkov

  def self.load_parsed_words
    if File.exists?("#{Rails.root}/lib/meat_markov_data")
      File.open("#{Rails.root}/lib/meat_markov_data", 'r') { |f| @parsed_words = YAML::load f.read }
    end
  end

  def self.parse_and_marshall_text(filename)
    @parsed_words ||= Hash.new
    File.open(filename, 'r') { |f| parse_words f.read.split(/[\s\n]/) }
    marshall_parsed_words
  end

  def self.random_text(limit=140)
    @parsed_words || load_parsed_words
    word = random_word
    text = word
    until text.length > limit || text[-1].match(/[.!?]/)
      word = get_next(word)
      break unless word
      text += ' ' + word
    end
    trim_text(text, limit)
  end

  private

    def self.add_datum(word, next_word)
      @parsed_words[word] ||= Hash.new(0)
      @parsed_words[word][next_word] += 1
    end

    def self.get_next(word)
      followers = @parsed_words[word]
      total_follower_wordcount = followers.inject(0) {|sum, key_value| sum += key_value[1]}
      random_threshold = rand(total_follower_wordcount).succ
      total = 0
      follower = followers.detect do |word, count|
        next unless @parsed_words[word]
        total += count
        total >= random_threshold
      end
      follower[0] if follower
    end

    def self.marshall_parsed_words
      File.open("#{Rails.root}/lib/meat_markov_data", 'w') { |f| f.puts YAML::dump @parsed_words }
    end

    def self.parse_words(all_words)
      all_words.each_with_index do |word, index|
        next if word.length == 0 || index.succ >= all_words.size
        next_word = all_words[index.succ]
        add_datum word, next_word if next_word.length > 0
      end
    end

    def self.random_word
      @parsed_words.keys.sample
    end

    def self.trim_text(text, limit)
      until text.length <= limit
        text = text.rpartition(/\s/)[0]
      end
      text
    end

end
