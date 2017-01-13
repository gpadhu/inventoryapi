Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'total/:id' => 'stocks#total', defaults: { format: :json}
  
  get 'stocks/:id' => 'stocks#stocks', defaults: { format: :json}
end
