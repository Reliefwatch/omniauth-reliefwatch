require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Reliefwatch < OmniAuth::Strategies::OAuth2
      option :name, :reliefwatch
      DEFAULT_SCOPE = 'public'
      option :client_options, :site          => 'https://reliefwatch.com',
                              :authorize_url => '/oauth/authorize'

      uid { raw_info['id'] }

      info do
        prune!(
          'nickname'    => raw_info['user']['username'],
          'email'       => raw_info['user']['email'],
          'full_name'        => raw_info['user']['full_name'],
        )
      end

      extra do
        hash = {}
        hash['raw_info'] = raw_info unless skip_info?
        prune! hash
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/me').parsed || {}
      end

      def request_phase
        options[:authorize_params] = {
          :scope          => (options['scope'] || DEFAULT_SCOPE)
        }

        super
      end

    private

      def prune!(hash)
        hash.delete_if do |_, value|
          prune!(value) if value.is_a?(Hash)
          value.nil? || (value.respond_to?(:empty?) && value.empty?)
        end
      end

    end
  end
end