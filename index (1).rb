require 'sinatra'
require 'httparty'
require 'debugger'
require 'multi_json'

# set :port, 4567

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


# SERVER
post "/email_processor" do
   command = params[:Subject]
   case command.downcase
   when "status"
      HTTParty.post("http://api.mailjet.com/v3/send/message", :body => {to: params[:From], from: "tmhall1@pipeline.sbcc.edu", subject: "Node Updates", text: "Stuff we will put later"}, :basic_auth => {username: "67277d9381e70cac1ea98102a9463bf3", password: "d26319db8e691bfc47a7efb88ef7d560"})
   when "on"

   else

   end

end
