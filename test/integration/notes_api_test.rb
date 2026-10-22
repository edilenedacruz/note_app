require "test_helper"

class NotesApiTest < ActionDispatch::IntegrationTest
  test "POST /api/v1/notes creates a note" do
    assert_difference("Note.count", 1) do
      post "/api/v1/notes",
           params: {
             note: {
               topic: "Ruby",
               content: "Learning Rails"
             }
           },
           as: :json
    end

    assert_response :created

    json = JSON.parse(response.body)

    assert_equal "Ruby", json["topic"]
    assert_equal "Learning Rails", json["content"]
    assert json["id"].present?
  end

  test "POST /api/v1/notes rejects missing topic" do
    assert_no_difference("Note.count") do
      post "/api/v1/notes",
           params: {
             note: {
               topic: "",
               content: "Learning Rails"
             }
           },
           as: :json
    end

    assert_response :unprocessable_entity

    json = JSON.parse(response.body)

    assert_includes json["errors"], "Topic can't be blank"
  end

  test "POST /api/v1/notes rejects missing content" do
    assert_no_difference("Note.count") do
      post "/api/v1/notes",
           params: {
             note: {
               topic: "Ruby"
             }
           },
           as: :json
    end
  
    assert_response :unprocessable_entity
  
    json = JSON.parse(response.body)
  
    assert_includes json["errors"], "Content can't be blank"
  end
end