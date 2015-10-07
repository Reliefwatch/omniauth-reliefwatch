require 'spec_helper'

describe OmniAuth::Strategies::Reliefwatch do
  subject do
    @subject ||= begin
      args = ['client_id', 'client_secret', @options || {}].compact
      OmniAuth::Strategies::Reliefwatch.new(*args)
    end
  end

  context 'client options' do
    it 'has correct name' do
      expect(subject.options.name).to eq(:reliefwatch)
    end

    it 'has correct site' do
      expect(subject.options.client_options.site).to eq('https://reliefwatch.com')
    end

    it 'has correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('/oauth/authorize')
    end

  end

  context 'figuring stuff out' do 
    it "gets log in" do 
      app = lambda{|env| [200, {}, ["Hello World."]]}
      OmniAuth::Strategies::Developer.new(app).options.uid_field                      # => :email
      OmniAuth::Strategies::Developer.new(app, :uid_field => :name).options.uid_field # => :name
    end
  end

end
