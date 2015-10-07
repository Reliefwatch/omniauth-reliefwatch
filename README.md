OmniAuth::Reliefwatch
==============

Reliefwatch OAuth2 Strategy for OmniAuth 1.0.

Supports the OAuth 2.0 server-side and client-side flows.

### Adding omniauth-reliefwatch to your gemfile

Because you may want reference your own local reliefwatch app (which needs to be running at http://localhost:3000).

**Production**: add 'gem 'omniauth-reliefwatch'` to your gemfile

**Local**: `gem 'omniauth-reliefwatch', github: "reliefwatch/omniauth-reliefwatch", branch: 'local'` to your gemfile instead.


## Creating an application

To be able to use OAuth on the Reliefwatch, you have to create an application. Go to [reliefwatch.org/oauth/applications](https://reliefwatch.com/oauth/applications)

Once you've added your application and your routes, you'll be able to see your Application ID and Secret, which you will need for omniauth.

**Note**: Callback url has to be an exact match - if your url is `http://localhost:3001/users/auth/reliefwatch/callback` you _must_ enter that exactly - `http://localhost:3001/users/auth/` will not work.


Check out **[API V1 Documentation](https://reliefwatch.com/documentation/api_v1)** to see what can be done with authenticated users.

## Usage with rails and Devise

First add it to you Gemfile:

`gem 'omniauth-reliefwatch'`

Here's a quick example, adding the middleware to a Rails app in
`config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :reliefwatch, ENV['RELIEFWATCH_APP_ID'], ENV['RELIEFWATCH_APP_SECRET']
end
```

Your `RELIEFWATCH_APP_ID` and your `RELIEFWATCH_APP_SECRET` are both application specific. To create or view your applications go to [reliefwatch.com/oauth/applications](https://reliefwatch.com/oauth/applications).

Edit your routes.rb file to have:

`devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }`

And create a file called `omniauth_callbacks_controller.rb` which should have this inside:

```ruby
class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def reliefwatch
    # Delete the code inside of this method and write your own.
    # The code below is to show you where to access the data.
    raise request.env["omniauth.auth"].to_json
  end
end
```

## Scopes

The default scope is `public` - which will be submitted unless you configure additional scopes. You can set scopes in the configuration with a space seperated list, e.g. for Devise

```ruby
Devise.setup do |config|
  config.omniauth :reliefwatch, ENV['RELIEFWATCH_APP_ID'], ENV['RELIEFWATCH_APP_SECRET'], scope: 'public`
end
```



## Credentials

The response will include a `uid` from Reliefwatch for the user and nothing else.


-----

Based on [omniauth-bike-index](https://github.com/bikeindex/omniauth-bike-index)