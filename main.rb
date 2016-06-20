module Bumblebee
    class API < Grape::API
        prefix :api
        format :json

        mount ::ProductAPI::V1
        mount ::OrderAPI::V1
        mount ::CartAPI::V1
        mount ::BreakdownAPI::V1
    end
end
