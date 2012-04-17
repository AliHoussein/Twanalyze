require 'rubygems'
require 'twitter'
require 'secret.rb'
require 'pp'

data = Twitter.user_timeline("sylvainkalache")

common_word = []

# Get the most common words list
file = File.open('common_words')
file.each_line do |line|
  common_word << line.chomp.downcase
end

# Get stastics about number time word found
counter = Hash.new(0)
data.each do |tweet|
  tweet['text'].downcase.scan(/[\w']+/) do |word|

    if !(common_word.include?(word))
      counter[word] += 1
    end

  end
end

# Sort the Hash
sorted_hash = counter.sort_by {|word,number| number}
Hash[sorted_hash.sort_by { |k,v| -v }[0..1]]

sorted_hash.each do |word,number|
  #puts "#{word} said #{number} times"
end

puts Twitter.rate_limit_status.remaining_hits.to_s + " Twitter API request(s) remaining this hour"
