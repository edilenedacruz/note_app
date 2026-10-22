require "test_helper"

class NoteTest < ActiveSupport::TestCase
  test "valid note" do
    note = Note.new(
      topic: "Ruby",
      content: "Learning Rails"
    )

    assert note.valid?
  end

  test "topic is required" do
    note = Note.new(content: "Learning Rails")

    assert_not note.valid?
    assert_includes note.errors[:topic], "can't be blank"
  end

  test "content is required" do
    note = Note.new(topic: "Ruby")

    assert note.invalid?
  end
end