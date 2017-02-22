module API
  class V1 < Grape::API

    format :json
    namespace :v1 do
    # this 'v1' is part of the url request:
    # http://localhost:9092/api/v1/monitor.json
      
      resource :monitor do
        desc 'Basic check of the grape system'
        get do
          "v1 up"
        end
      end # monitor

      resource :greeters do
        desc 'get all the greeters'
        # http://localhost:9092/api/v1/greeters
        get do
          Greeter::Models::Greeter.all
        end
      end # greeters

      resource :ops do
        desc 'allowed operations'
        # http://localhost:9092/api/v1/ops

        get do
          "ops allowed: [concat]"
        end

        desc 'concat two given words'
        # http://localhost:9092/api/v1/ops/concat?word1=yair&word2=segal

        params do
          requires :word1,      type: String, desc: "First word"
          requires :word2,      type: String, desc: "Second word"
          optional :connector,  type: String, desc: "String to connect the two words", default: "-"
        end

        get '/concat' do
          params[:word1] + params[:connector] + params[:word2]
        end
      end # ops

      resource :route_example do
        desc 'Return a status'

        params do
          requires :id, type: Integer, desc: "Status id."
        end

        route_param :id do # produces the route GET /example/:id
          # http://localhost:9092/api/v1/route_example/3
          get do
            params[:id]*10+1
          end
        end

        get do
          # http://localhost:9092/api/v1/route_example?id=3
          params[:id]
        end

      end # example

    end # namespace
  end
end