module Bumblebee
    class API < Grape::API
        prefix :api
        format :json

        mount ::ProductAPI::V1
    end
end
