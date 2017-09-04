require 'httparty'
require 'kafka'

okta_token = '<insert your token information here>'
url = 'https://YourOktaOrg.com/ap1/v1/whateveryourendpointis'

## Pull the information form the Okta API
response = HTTParty.get(url, headers: {"Authorization" => "SSWS #{okta_token}"}, format: :json)

#Client to Initialize with the Kafka Broker 
kafka = Kafka.new(
    seed_brokers: ["localhost:9092"],
)

# Producer Code 
# Instantiate the new producer 

producer = kafka.producer

#Add message to the producer buffer 
response.each do |log|
    producer.produce(log, topic: "OktaLogs")
    producer.deliver_messages
end 