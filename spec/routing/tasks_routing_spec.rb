require "rails_helper"

RSpec.describe TasksController, type: :routing do
  describe "routing" do
    {
      "index":  { get:   "/tasks"     },
      "new":    { get:   "/tasks/new" },
      "create": { post:  "/tasks"     },
    }.each do |action, path|
      it "routes to ##{action}" do
        expect(path).to route_to("tasks##{action}") 
      end
    end

    {
      "show":    { get:   "/tasks/1"      },
      "edit":    { get:   "/tasks/1/edit" },
      "update":  { put:   "/tasks/1"      },
      "update":  { patch: "/tasks/1"      },
      "destroy": { delete:"/tasks/1"      },
    }.each do |action, path|
      it "routes to ##{action}" do
        expect(path).to route_to("tasks##{action}", id: "1") 
      end
    end
    it "routes to #logs" do
      expect({ get: "/tasks/1/logs" }).to route_to("tasks#logs", task_id: "1") 
    end
  end
end
