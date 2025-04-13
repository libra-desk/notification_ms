require_relative "../config/environment"
require_relative "../app/consumers/kafka_consumer"

threads = []

threads << Thread.new do
  puts "NOTIFICATION_MS: Listening to book borrowed event to send mails"
  KafkaConsumer.new(topic: "book_borrowed").listen
end

threads << Thread.new do
  puts "NOTIFICATION_MS: Listening to book returned event to send mails"
  KafkaConsumer.new(topic: "book_returned").listen
end

threads.each(&:join)
