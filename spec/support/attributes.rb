# Attribute getter.
def it_has_getter_for(attribute)
  context "getter" do
    it "allows reading" do
      expect { subject.send(attribute) }.to_not raise_error
    end

    it "returns value" do
      subject.send(attribute).should be_kind_of Object
    end
  end
end

# Attribute setter.
def it_has_setter_for(attribute)
  context "setter" do
    it "allows modification" do
      expect { subject.send("#{attribute}=", 'value') }.to_not raise_error
    end

    it "sets value" do
      subject.send("#{attribute}=", 'new_value')
      subject.instance_variable_get("@#{attribute}").should eq 'new_value'
    end
  end
end

# Attribute with getter and settter.
def it_has_attribute(attribute)
  describe "attribute #{attribute}" do
    it_has_getter_for attribute
    it_has_setter_for attribute
  end
end

# Readable attribute.
def it_has_readable_attribute(attribute)
  describe "readable attribute #{attribute}" do
    it_has_getter_for attribute

    it "not allows modification" do
      expect { subject.send("#{attribute}=", 'new_value') }.to raise_error
    end
  end
end
