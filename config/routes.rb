Rails.application.routes.draw do
  match '(*any)', to: redirect(subdomain: ''), via: :all, constraints: {subdomain: 'www'}

  scope '/wave/:wave_id' do
    resources :provinces, :path => ''
  end

  resources :provinces, :path => '' do
    scope format: true, constraints: { format: /rss/ } do
        resources :municipalities, :path => ''
    end
  end

  root to: "provinces#index"

  post 'push/:version/log', to: "safari#log"
  post 'push/:version/pushPackages/web.nl.pletdecurve', to: "safari#package"
  post 'push/:version/devices/:device_token/registrations/web.nl.pletdecurve', to: "safari#register"
  delete 'push/:version/devices/:device_token/registrations/web.nl.pletdecurve', to: "safari#deregister"

  post 'subscriptions', to: "subscriptions#add"
  delete 'subscriptions/:municipality_id', to: "subscriptions#remove"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
