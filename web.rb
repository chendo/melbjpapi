require 'json'
require 'sinatra'
require 'sinatra/json'
require 'metlinkr'

set :json_encoder, JSON

get '/route' do
  options = {:limit => 3, :methods => :all}
  options[:methods] = params['methods'].to_sym if params['methods']
  journey = Metlinkr.plan(params[:from], params[:to], options)
  ret = {}
  ret['trips'] = journey.trips.map do |trip|
    {
      'steps' => trip.steps.map do |step|
        {
          'origin' => step.origin,
          'departure_time' => step.departure_time,
          'duration' => step.duration,
          'route' => step.route,
          'arrival_time' => step.arrival_time,
          'destination' => step.destination,
          'method' => step.method,
        }
      end
    }
  end

  json ret
end
