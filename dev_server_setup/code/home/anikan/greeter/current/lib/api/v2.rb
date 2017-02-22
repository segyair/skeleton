module API
    class V2 < Grape::API

      format :json
      namespace :v2 do
        resource :monitor do
          desc 'Basic check of the grape system'
          get do
            "v2 up"
          end
        end # resource
      end # namespace
    end
end