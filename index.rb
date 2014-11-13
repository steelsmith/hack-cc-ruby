require 'sinatra'
require 'httparty'
#require 'debugger'
require 'multi_json'
require 'serialport'

#set :port, 3000
#port should be 4567
#setup serial
baud_rate = 57600
port_file = "/dev/ttyUSB0"
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE
port = SerialPort.new(port_file, baud_rate, data_bits, stop_bits, parity)

# https://github.com/aj0strow/sinatra-json_body_params
module Sinatra
  module JsonBodyParams

    def self.registered(app)
      app.before do
        params.merge! json_body_params
      end

      app.helpers do
        def json_body_params
          @json_body_params ||= begin
            MultiJson.load(request.body.read.to_s, symbolize_keys: true)
          rescue MultiJson::LoadError
            {}
          end
        end
      end
    end

  end
end

register Sinatra::JsonBodyParams

$i = ''
#$counter=0
$valueLight
$valueMotion
$valueFinger
$testingvalues = "i want to kill myself"

$string
Thread.new do
  while true do
    $string = ''
   while ($i = port.gets) do
      #puts "$i : #{$i}" #String
      $string<< $i
      break
    end
    puts "$string : #{$string.dump}"
    puts "$string.length : #{$string.length}"
    key, value = $string.split ': ', 2
    puts key
    puts value
    if (key.eql? "Light")
        $valueLight = value
        #put "Light:"
        #put $valueLight
    end
    if (key.eql? "Finger")
        #put "Finger: "
        $valueFinger = value
        #put $valueFinger
    end
    if (key.eql? "Motion")
        #put "Motion: "
        $valueMotion = value
        #put $val
    end

    # if ($string.eql?  "this is a test\n")
    #   puts "comparison worked"
    #   $counter +=1
    #   puts "counter changes
"    #   puts "$counter : #{$counter}"
    # end
    # if (key.eql? "Light")
    # end

    sleep 1
  end
end


  # SERVER
  post "/email_processor" do
     command = params[:Subject].downcase
     if command == "status"
        HTTParty.post("http://api.mailjet.com/v3/send/message", :body => {to: params[:From], from: "tmhall1@pipeline.sbcc.edu", subject: "Count", text: "test email stuffs sad   #{$testingvalues}"}, :basic_auth => {username: "67277d9381e70cac1ea98102a9463bf3", password: "d26319db8e691bfc47a7efb88ef7d560"})
        puts "sent"
     end
  end


