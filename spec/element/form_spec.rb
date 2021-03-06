require 'helper'

describe "Form" do
  before do
    html = <<-EOF
    <form>
      <input name="input_1" value="value_1">
      <input type="text" name="text_input" value="text_input_value">

      <input type="password" name="password_input" value="password">

      <select name="colour">
        <option>red</option>
        <option selected>blue</option>
      </select>

      <select name="countries" multiple>
        <option>france</option>
        <option selected>spain</option>
        <option selected>germany</option>
      </select>

      <textarea name="essay">hello world</textarea>
      <input type="checkbox" name="checkbox_1" value="checkbox_value_1">
      <input type="checkbox" name="checkbox_2" value="checkbox_value_2" checked>

      <input type="radio" name="radio_button_1" value="radio_value_1">
      <input type="radio" name="radio_button_2" value="radio_value_2" checked>

      <input type="submit" value="submit button"></input>
      <input type="reset" value="reset button"></input>
      <input type="button" value="button button"></input>
      <button>button 2</button>
    </form>
    EOF
    @form = CapybaraPageObject::Form.from_string html, 'form'
  end

  context "#buttons" do
    it "return the buttons contained in the form" do
      @form.buttons.size.should == 4
    end
  end

  context "#inputs" do
    it "returns the inputs on the page (excluding buttons)" do
      @form.inputs.keys.should == ["input_1", "text_input", "password_input", "checkbox_1",
        "checkbox_2", "radio_button_1", "radio_button_2"]
    end
  end

  context "#textareas" do
    it "returns the textareas on the page" do
      @form.textareas.keys.should == ["essay"]
    end
  end

  context "#selects" do
    it "returns the selects on the page" do
      @form.selects.keys.should == ["colour", "countries"]
    end
  end

  context "#fields" do
    it "merges inputs, textareas and selects" do
      @form.stub!(:inputs => {'a' => 1})
      @form.stub!(:textareas => {'b' => 2})
      @form.stub!(:selects => {'c' => 3})
      @form.fields.should == {'a' => 1, 'b' => 2, 'c' => 3}
    end
  end

  # it "provides direct read access to form's fields" do
  #   @form.essay.should == 'hello world'
  # end

  # it "doesn't respond to nonexistant fields" do
  #   @form.should_not respond_to(:nonexistant_field)
  # end
end
