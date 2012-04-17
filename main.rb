require 'rubygems'
require 'twitter'
require 'pp'

Twitter.configure do |config|
  config.consumer_key = 'uwAeOh98aL4QjDjky1EA'
  config.consumer_secret = 'R4ZRG6obcfCx0zPxcSNWDp6fOyrvKbABE18yrym65M'
  config.oauth_token = '3153611-vFoPJG3alSPqMxTjNLiUNOKQuokvtO0ZB6dZJ3XyrL'
  config.oauth_token_secret = '8q2NNtXhzIHxuRpPpc0qDc3LN7Tp2dRO5wX1pnuNk'
end

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