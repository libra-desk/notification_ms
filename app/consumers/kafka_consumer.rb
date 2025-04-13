require 'kafka'

class KafkaConsumer
  def initialize(topic:)
    @kafka = Kafka.new(["127.0.0.1:9092"], client_id: "notification-ms")
    @topic = topic
    @group_id = "notification-ms-consumer"
  end

  def listen
    consumer = @kafka.consumer(group_id: @group_id)
    consumer.subscribe(@topic)

    puts "Listening to #{@topic} topic..."
    
    consumer.each_message do |message|
      puts "Received the message #{message.value}"
      handle_message(JSON.parse(message.value))
    end
  rescue => e
    puts "There seems to be an error: #{e}"
    retry
  end


  private

  def handle_message(payload)
    student_email = payload['email']

    # Here we are using 'send' method to dynamically call the method instead
    # of doing nested conditionals
    if StudentMailer.respond_to? @topic 
      StudentMailer.send(@topic, student_email).deliver_now
    end
  end
end
