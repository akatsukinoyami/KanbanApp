require "rails_helper"

RSpec.describe Devise::SessionsController, type: :routing do
  describe "routing" do
    {
      "new":     { get:   "/users/sign_in"  },
      "create":  { post:  "/users/sign_in"  },
      "destroy": { delete:"/users/sign_out" },
    }.each do |action, path|
      it "routes to ##{action}" do
        expect(path).to route_to("devise/sessions##{action}") 
      end
    end
  end
end


RSpec.describe Devise::RegistrationsController, type: :routing do
  describe "routing" do
    {
      "new":    { get:   "/users/sign_up" },
      "create": { post:  "/users"         },
    }.each do |action, path|
      it "routes to ##{action}" do
        expect(path).to route_to("devise/registrations##{action}") 
      end
    end
  end
end