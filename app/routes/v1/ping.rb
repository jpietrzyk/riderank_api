module Routes
  module V1
    class Ping < Grape::API
      get :ping do
        'pong'
      end
    end
  end
end
